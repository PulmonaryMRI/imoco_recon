import argparse 
import sigpy as sp
import scipy.ndimage as ndimage_c
import numpy as np

import sys
sys.path.append("./sigpy_e/")
import sigpy_e.cfl as cfl 

import sigpy_e.ext as ext
import sigpy_e.reg as reg
from sigpy_e.linop_e import NFTs,Diags,DLD,Vstacks
import sigpy.mri as mr
import os
import logging

## IO parameters
parser = argparse.ArgumentParser(description='XD-GRASP recon.')

parser.add_argument('--res_scale', type=float, default=.75,
                    help='scale of resolution, full res == .75')
parser.add_argument('--fov_x', type=float, default=1,
                    help='scale of FOV x, full res == 1')
parser.add_argument('--fov_y', type=float, default=1,
                    help='scale of FOV y, full res == 1')
parser.add_argument('--fov_z', type=float, default=1,
                    help='scale of FOV z, full res == 1')

parser.add_argument('--lambda_TV', type=float, default=5e-2,
                    help='TV regularization, default is 0.05')
parser.add_argument('--outer_iter', type=int, default=25,
                    help='Num of Iterations.')

parser.add_argument('--vent_flag', type=int, default=0,
                        help='output jacobian determinant and specific ventilation')
parser.add_argument('--n_ref_vent', type=int, default=0,
                        help='reference frame for ventilation')

parser.add_argument('--device', type=int, default=0,
                    help='Computing device.')

parser.add_argument('fname', type=str,
                    help='Prefix of raw data and output(_mrL).')
args = parser.parse_args()

#
res_scale = args.res_scale
fname = args.fname
lambda_TV = args.lambda_TV
device = args.device
outer_iter = args.outer_iter
fov_scale = (args.fov_x, args.fov_y, args.fov_z)
vent_flag = args.vent_flag
n_ref_vent = args.n_ref_vent

## data loading
data = np.load(os.path.join(fname, 'bksp.npy'))
traj = np.real(np.load(os.path.join(fname, 'bcoord.npy')))
dcf = np.sqrt(np.load(os.path.join(fname,'bdcf.npy')))

nf_scale = res_scale
nf_arr = np.sqrt(np.sum(traj[0,0,:,:]**2,axis = 1)) 
nf_e = np.sum(nf_arr<np.max(nf_arr)*nf_scale)
scale = fov_scale
traj[...,0] = traj[...,0]*scale[0]
traj[...,1] = traj[...,1]*scale[1]
traj[...,2] = traj[...,2]*scale[2]

traj = traj[...,:nf_e,:]
data = data[...,:nf_e]
dcf = dcf[...,:nf_e]

nphase,nCoil,npe,nfe = data.shape
tshape = (int(np.max(traj[...,0])-np.min(traj[...,0]))
          ,int(np.max(traj[...,1])-np.min(traj[...,1]))
          ,int(np.max(traj[...,2])-np.min(traj[...,2])))

### calibration
ksp = np.reshape(np.transpose(data,(1,0,2,3)),(nCoil,nphase*npe,nfe))
dcf2 = np.reshape(dcf**2,(nphase*npe,nfe))
coord = np.reshape(traj,(nphase*npe,nfe,3))

mps = ext.jsens_calib(ksp,coord,dcf2,device = sp.Device(0),ishape = tshape)
S = sp.linop.Multiply(tshape, mps)

### recon
PFTSs = []
for i in range(nphase):
    FTs = NFTs((nCoil,)+tshape,traj[i,...],device=sp.Device(device))
    W = sp.linop.Multiply((nCoil,npe,nfe,),dcf[i,:,:]) 
    FTSs = W*FTs*S
    PFTSs.append(FTSs)
PFTSs = Diags(PFTSs,oshape=(nphase,nCoil,npe,nfe,),ishape=(nphase,)+tshape)

## preconditioner
wdata = data*dcf[:,np.newaxis,:,:]
tmp = PFTSs.H*PFTSs*np.complex64(np.ones((nphase,)+tshape))
L=np.mean(np.abs(tmp))


## reconstruction
q2 = np.zeros((nphase,)+tshape,dtype=np.complex64)
Y = np.zeros_like(wdata)
q20 = np.zeros_like(q2)
res_norm = np.zeros((outer_iter,1))

logging.basicConfig(level=logging.INFO)

sigma = 0.4
tau = 0.4
for i in range(outer_iter):
    Y = (Y + sigma*(1/L*PFTSs*q2-wdata))/(1+sigma)
    
    q20 = q2
    q2 = np.complex64(ext.TVt_prox(q2-tau*PFTSs.H*Y,lambda_TV))
    res_norm[i] = np.linalg.norm(q2-q20)/np.linalg.norm(q2)
    logging.info('outer iter:{}, res:{}'.format(i,res_norm[i]))
    
    np.save(os.path.join(fname, 'prL.npy'), q2)
    #np.save(os.path.join(fname, 'prL_residual_{}.npy'.format(lambda_TV)), res_norm)
#q2 = np.load(os.path.join(fname, 'prL.npy'))
# jacobian determinant & specific ventilation
if vent_flag==1:
    print('Jacobian Determinant and Specific Ventilation...')
    jacs = []
    svs = []
    q2 = np.abs(np.squeeze(q2))
    q2 = q2/np.max(q2)
    for i in range(nphase):
        jac, sv = reg.ANTsJac(np.abs(q2[n_ref_vent]), np.abs(q2[i]))
        jacs.append(jac)
        svs.append(sv)
    jacs = np.asarray(jacs)
    svs = np.asarray(svs)
    np.save(os.path.join(fname, 'jac_prl.npy'), jacs)
    np.save(os.path.join(fname, 'sv_prl.npy'), svs)