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
import twixtools
from scipy.signal import firls, convolve, find_peaks
from scipy.ndimage import maximum_filter, minimum_filter
from scipy.interpolate import interp1d

def convert_siemens(dat_dir, traj_dir):
    #% ksp [nCoil, npe, nfe]
    twix = twixtools.read_twix(dat_dir)
    
    ksp = list()
    par = list()
    lin = list()
    for mdb in twix[-1]['mdb'][::1]:
        print('line: %3d; partition: %3d; flags:'%(mdb.cLin, mdb.cPar), mdb.get_active_flags(), mdb.is_image_scan())
        if mdb.is_image_scan():
            ksp.append(mdb.data)
            par.append(mdb.cPar)
            lin.append(mdb.cLin)
    ksp = np.asarray(ksp)  
    ksp = ksp[:,:,10:] # crop the first 10 data points
    ksp = np.transpose(ksp, [1,0,2])

    kz_n = np.max(par) - np.min(par) + 1
    lin_n = np.max(lin) - np.min(lin) + 1

    #% coord [npe, nfe, 3]
    traj_dim = np.loadtxt(traj_dir, max_rows=1) # first row are dimensions
    traj_dim = traj_dim.astype(int)
    traj = np.loadtxt(traj_dir, skiprows=1) # trajectory starts from second row
    traj_reshape = np.reshape(traj, (traj_dim[3], traj_dim[1], 3))
    coord = np.repeat(traj_reshape[::-1,:,:], kz_n, axis=0) # only first two colomns for stack of spiral

    # create kz coord
    # 1d
    kz_minus = np.linspace(-1, -kz_n/2, int(kz_n/2))
    kz_plus = np.linspace( 0, kz_n/2-1, int(kz_n/2))
    kz = np.reshape(np.vstack([kz_plus, kz_minus]),[-1,1],order='F')
    kz[1:-1,:] = -kz[1:-1,:]

    coord[:,:,2] = np.tile(kz, [traj_dim[3], traj_dim[1]])

    #% dcf [npe, nfe]
    dcf = np.sqrt(coord[:,:,0]**2 + coord[:,:,1]**2)
    dcf = dcf / np.max(dcf)
    dcf[:,0] = 1/lin_n

    #% gate [ngate]
    nav = list()
    for mdb in twix[-1]['mdb']:
        print('line: %3d; partition: %3d; flags:'%(mdb.cLin, mdb.cPar), mdb.get_active_flags(), mdb.is_image_scan())
        if 'WIP_2' in mdb.get_active_flags():
            nav.append(mdb.data)
    nav = np.asarray(nav)
    gate = np.fft.fftshift(np.fft.fft(nav))
    gate = np.mean(np.abs(gate), axis=-1)
    
    return ksp, coord, dcf, gate

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
         description='Converts Siemens .dat files to npy arrays in natural time ordering.')
    
    # parser.add_argument('folder', type=str)
    parser.add_argument('--tr', type=float, default = 0.0037, help='TR in seconds.')
    parser.add_argument('--bins', type=int, default = 4, help='number of bins')
    parser.add_argument('--resp_polar', type=float, default = -1, help='Polarization of respiratory motion +1 or -1')
    args = parser.parse_args()
    
    dat_dir = '/data/larson5/Siemens_Lung/2023-01-25_FreeMax/meas_MID00206_FID03324_spiral_vibe_GRASP_1_8mmiso_fb.dat'
    traj_dir = '/data/larson5/Siemens_Lung/2023-01-25_FreeMax/wip_992_SpiralVIBE_sp2dIceKspace.log'
    folder = '/data/larson5/Siemens_Lung/2023-01-25_FreeMax/' #args.folder # output dir
    
    tr = 8.51*1e-3 #args.tr
    bins = args.bins
    resp_polar = args.resp_polar
    
    # convert h5 
    ksp, coord, dcf, gate = convert_siemens(dat_dir, traj_dir)
        
    logging.info('Saving data.')
    os.makedirs(folder, exist_ok=True)
    np.save(os.path.join(folder, 'ksp.npy'), ksp)
    np.save(os.path.join(folder, 'coord.npy'), coord)
    np.save(os.path.join(folder, 'dcf.npy'), dcf)
    np.save(os.path.join(folder, 'gate.npy'), gate)
    
    ksp = np.load(os.path.join(folder, 'ksp.npy'))
    coord = np.load(os.path.join(folder, 'coord.npy'))
    dcf = np.load(os.path.join(folder, 'dcf.npy'))
    gate = np.load(os.path.join(folder, 'gate.npy'))

    # respiratory signal
    logging.info('Extracting respiratory signal.')
    resp = resp_polar * estimate_resp(gate.T, tr*30)
    resp = np.repeat(resp, 30)
    
    # binning
    logging.info('Motion resolved binning.')
    bksp, bcoord, bdcf = mr_binning(ksp, coord, dcf, resp, bins)
    np.save(os.path.join(folder, 'bksp.npy'), bksp)
    np.save(os.path.join(folder, 'bcoord.npy'), bcoord)
    np.save(os.path.join(folder, 'bdcf.npy'), bdcf)