#!/usr/bin/env python3
'''
modified from https://github.com/mikgroup/extreme_mri_data/blob/master/convert_uwute.py
'''
import argparse
import os
import numpy as np
import h5py
import sigpy.mri as mr
import logging
from scipy.signal import firls, convolve, find_peaks
from scipy.ndimage import maximum_filter, minimum_filter
from scipy.interpolate import interp1d

def convert_uwute(hf):
    try:
        time = np.squeeze(hf['Gating']['time'])
        order = np.argsort(time)
    except Exception:
        time = np.squeeze(hf['Gating']['TIME_E0'])
        order = np.argsort(time)
    
    # load coordinates
    coord = []
    for i in ['Z', 'Y', 'X']:
        logging.info(f'Loading {i} coord.')

        coord.append(hf['Kdata'][f'K{i}_E0'][0][order])

    coord = np.stack(coord, axis=-1)
    
    # load density compensation
    logging.info('Loading dcf')
    dcf = hf['Kdata']['KW_E0'][0][order]
    
    # number of coils
    num_coils = 0
    while f'KData_E0_C{num_coils}' in hf['Kdata']:
        num_coils += 1
    logging.info(f'Number of coils: {num_coils}')
    
    # number of echoes
    num_echo = 0
    while f'KData_E{num_echo}_C0' in hf['Kdata']:
        num_echo += 1
    logging.info(f'Number of echoes: {num_echo}')
    
    ksp = []
    for e in range(num_echo):
        logging.info(f'Loading kspace, echo {e + 1} / {num_echo}.')
        kspc = []
        for c in range(num_coils):
            logging.info(f'Loading kspace, coil {c + 1} / {num_coils}.')
    
            k = hf['Kdata'][f'KData_E{e}_C{c}']
            kspc.append(k['real'][0][order] + 1j * k['imag'][0][order])
        kspc = np.stack(kspc, axis=0)
        ksp.append(kspc)
    ksp = np.squeeze(np.stack(ksp, axis=0))

    try:
        noise = hf['Kdata']['Noise']['real'] + 1j * hf['Kdata']['Noise']['imag']

        logging.info('Whitening ksp.')
        cov = mr.util.get_cov(noise)
        ksp = mr.util.whiten(ksp, cov)
    except Exception:
        ksp /= np.abs(ksp).max()
        logging.info('No noise data.')
        pass
    
    return ksp, coord, dcf

def estimate_resp(dc, tr, n=9999, fl=0.1, fh=0.5, fw=0.01):
    """Estimate respiratory signal from DC.
    The function performs:
    1) Filter DC with a band-pass filter with symmetric extension.
    2) Normalize each channel by a robust estimation of mean and variance.
    3) Return the channel with the maximum variance.
    Args:
        dc (array): multi-channel DC array of shape [num_coils, num_tr].
        tr (float): TR in seconds.
        n (int): length of band-pass filter.
        fl (float): lower cut-off of band-pass filter in Hz.
        fh (float): higher cut-off of band-pass filter in Hz.
        fw (float): transition width of band-pass filter.
    Returns:
        array: respiratory signal of length num_tr.
    """
    dc = np.abs(dc)
    fs = 1 / tr
    bands = [0, fl - fw, fl, fh, fh + fw, fs / 2]
    desired = [0, 0, 1, 1, 0, 0]

    filt = firls(n, bands, desired, fs=fs)
    sigma_max = 0
    for c in range(len(dc)):
        dc_pad = np.pad(dc[c], [n // 2, n // 2], mode='reflect')
        resp_c = convolve(dc_pad, filt, mode='valid')
        sigma_c = 1.4826 * np.median(np.abs(resp_c - np.median(resp_c)))

        if sigma_c > sigma_max:
            resp = (resp_c - np.median(resp_c)) / sigma_c
            sigma_max = sigma_c

    return resp

def mr_binning(ksp, coord, dcf, resp, B, margin=5):
    #bins = np.percentile(resp, np.linspace(0 + margin, 100 - margin, B + 1))
    index = np.argsort(resp)
    
    margin = int(len(resp) * margin / 100)
    index = index[margin : -margin]
    
    npe = len(index) // B
    bksp = []
    bcoord = []
    bdcf = []
    for b in range(B):
        #idx = (resp >= bins[b]) & (resp < bins[b + 1])
        idx = index[npe * int(b) : npe * int(b + 1)]
        bksp.append(ksp[:, idx,:])
        bcoord.append(coord[idx,:,:])
        bdcf.append(dcf[idx,:])

    bksp = np.stack(bksp, axis=0)
    bcoord = np.stack(bcoord, axis=0)
    bdcf = np.stack(bdcf, axis=0)
    
    return bksp, bcoord, bdcf

def mr_binning2(ksp, coord, dcf, resp, TR, nbin):
    T_resp = 2 #s
    N_resp = np.ceil(T_resp / TR)
    
    resp_max = maximum_filter(resp, size = N_resp)
    resp_min = minimum_filter(resp, size = N_resp)
    
    signal_m = np.mean((resp_max + resp_min)/2)
    signal_s = np.mean(resp_max - resp_min)
    
    index = np.arange(len(resp))
    upper_bound = signal_m + 1.2 * signal_s
    lower_bound = signal_m - .8 * signal_s
    eff_index = index[(resp < upper_bound) & (resp > lower_bound)]
    
    exhale_th = signal_m + 0.2 * signal_s
    exhale_pos, ex_dict = find_peaks(resp[eff_index], distance = N_resp, height = exhale_th)
    ex_signal = ex_dict['peak_heights']
    drift = interp1d(eff_index[exhale_pos], ex_signal, kind='cubic', fill_value = "extrapolate")(index)
    
    resp = resp - drift
    exhale_pos, ex_dict = find_peaks(resp[eff_index], distance = N_resp, height = -1000)
    ex_signal = ex_dict['peak_heights']
    
    ex_std = np.std(ex_signal)    
    resp = resp[eff_index] + np.random.rand(len(eff_index)) * .01 * ex_std
    
    tmp_ind = np.arange(nbin * (len(resp) // nbin))
    index = eff_index[np.argsort(resp[tmp_ind])]
    
    npe = len(index) // nbin
    bksp = []
    bcoord = []
    bdcf = []
    
    for b in range(nbin):
        idx = index[npe * int(b) : npe * int(b + 1)]
        bksp.append(ksp[:, idx,:])
        bcoord.append(coord[idx,:,:])
        bdcf.append(dcf[idx,:])

    bksp = np.stack(bksp, axis=0)
    bcoord = np.stack(bcoord, axis=0)
    bdcf = np.stack(bdcf, axis=0)
    
    return bksp, bcoord, bdcf

def pr_binning(ksp, coord, dcf, resp, TR, nbin):
    T_resp = 2 #s
    N_resp = np.ceil(T_resp / TR)
    
    resp_max = maximum_filter(resp, size = N_resp)
    resp_min = minimum_filter(resp, size = N_resp)
    
    signal_m = np.mean((resp_max + resp_min)/2)
    signal_s = np.mean(resp_max - resp_min)
    
    index = np.arange(len(resp))
    upper_bound = signal_m + 1.2 * signal_s
    lower_bound = signal_m - .8 * signal_s
    eff_index = index[(resp < upper_bound) & (resp > lower_bound)]
    
    exhale_th = signal_m + 0.2 * signal_s
    exhale_pos, ex_dict = find_peaks(resp[eff_index], distance = N_resp, height = exhale_th)
    ex_signal = ex_dict['peak_heights']
    drift = interp1d(eff_index[exhale_pos], ex_signal, kind='cubic', fill_value = "extrapolate")(index)
    
    resp = resp - drift
    exhale_pos, ex_dict = find_peaks(resp[eff_index], distance = N_resp, height = -1000)
    ex_signal = ex_dict['peak_heights']
    
  
    
    # assign phase
    phase = np.zeros(np.size(eff_index))
    for p in range(len(exhale_pos)-1):
        phase[exhale_pos[p]:exhale_pos[p+1]] = np.linspace(0.5, nbin + 0.5, exhale_pos[p+1] - exhale_pos[p], endpoint=False) % nbin
    
    # discard points before 1st exhale and last exhale 
    phase = phase[(eff_index >= exhale_pos[0]) & (eff_index <= exhale_pos[-1])]
    eff_index = eff_index[(eff_index >= exhale_pos[0]) & (eff_index <= exhale_pos[-1])]  
    
    
    # introduce slight disturb
    ex_std = np.std(ex_signal)    
    phase = phase + np.random.rand(len(eff_index)) * .01 * ex_std
    
    # sort index according to phase
    index = eff_index[np.argsort(phase)]
    
    npe = len(index) // nbin
    bksp = []
    bcoord = []
    bdcf = []
    
    for b in range(nbin):
        idx = index[npe * int(b) : npe * int(b + 1)]
        bksp.append(ksp[:, idx,:])
        bcoord.append(coord[idx,:,:])
        bdcf.append(dcf[idx,:])

    bksp = np.stack(bksp, axis=0)
    bcoord = np.stack(bcoord, axis=0)
    bdcf = np.stack(bdcf, axis=0)
    
    return bksp, bcoord, bdcf
    
if __name__=='__main__':
    # parse arguments
    parser = argparse.ArgumentParser(
         description='Converts UWUTE h5 files to npy arrays in natural time ordering.')
    
    parser.add_argument('h5_file', type=str)
    parser.add_argument('folder', type=str)
    parser.add_argument('--tr', type=float, default = 0.0037, help='TR in seconds.')
    parser.add_argument('--bins', type=int, default = 6, help='number of bins')
    parser.add_argument('--resp_polar', type=float, default = -1, help='Polarization of respiratory motion +1 or -1')
    args = parser.parse_args()
    
    
    folder = args.folder
    #h5_file = os.path.join(folder, 'MRI_Raw.h5')
    h5_file = os.path.join(args.h5_file, 'MRI_Raw.h5')
    tr = args.tr
    bins = args.bins
    resp_polar = args.resp_polar
    logging.basicConfig(level=logging.INFO)
    
    # convert h5 
    with h5py.File(h5_file, 'r') as hf:
        ksp, coord, dcf = convert_uwute(hf)
        
    logging.info('Saving data.')
    os.makedirs(folder, exist_ok=True)
    # np.save(os.path.join(folder, 'ksp.npy'), ksp)
    # np.save(os.path.join(folder, 'coord.npy'), coord)
    # np.save(os.path.join(folder, 'dcf.npy'), dcf)
    
    # respiratory signal
    logging.info('Extracting respiratory signal.')
    dc = ksp[:, :, 0]
    resp = resp_polar * estimate_resp(dc, tr)
    #np.save(os.path.join(folder, 'resp.npy'), resp)
    
    # binning
    logging.info('Motion resolved binning.')
    bksp, bcoord, bdcf = pr_binning(ksp, coord, dcf, resp, tr, bins)
    np.save(os.path.join(folder, 'bksp.npy'), bksp)
    np.save(os.path.join(folder, 'bcoord.npy'), bcoord)
    np.save(os.path.join(folder, 'bdcf.npy'), bdcf)