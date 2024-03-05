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
parser.add_argument('--outer_iter', type=int, default=20,
                    help='Num of Iterations.')

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

## data loading
data = cfl.read_cfl(fname+'_datam')
traj = np.real(cfl.read_cfl(fname+'_trajm'))
dcf = cfl.read_cfl(fname+'_dcf2m')
nf_scale = res_scale
nf_arr = np.sqrt(np.sum(traj[0,0,0,0,:,:]**2,axis = 1)) 
nf_e = np.sum(nf_arr<np.max(nf_arr)*nf_scale)
scale = fov_scale
traj[...,0] = traj[...,0]*scale[0]
traj[...,1] = traj[...,1]*scale[1]
traj[...,2] = traj[...,2]*scale[2]

traj = traj[...,:nf_e,:]
data = data[...,:nf_e,:]
dcf = dcf[...,:nf_e,:]

nphase,nEcalib,nCoil,npe,nfe,_ = data.shape
tshape = (int(np.max(traj[...,0])-np.min(traj[...,0]))
          ,int(np.max(traj[...,1])-np.min(traj[...,1]))
          ,int(np.max(traj[...,2])-np.min(traj[...,2])))

### calibration
ksp = np.reshape(np.transpose(data,(2,1,0,3,4,5)),(nCoil,nphase*npe,nfe))
dcf2 = np.reshape(np.transpose(dcf**2,(2,1,0,3,4,5)),(nphase*npe,nfe))
coord = np.reshape(np.transpose(traj,(2,1,0,3,4,5)),(nphase*npe,nfe,3))

mps = ext.jsens_calib(ksp,coord,dcf2,device = sp.Device(device),ishape = tshape)
S = sp.linop.Multiply(tshape, mps)

### recon
PFTSs = []
for i in range(nphase):
    FTs = NFTs((nCoil,)+tshape,traj[i,0,0,...],device=sp.Device(device))
    W = sp.linop.Multiply((nCoil,npe,nfe,),dcf[i,0,0,:,:,0]) 
    FTSs = W*FTs*S
    PFTSs.append(FTSs)
PFTSs = Diags(PFTSs,oshape=(nphase,nCoil,npe,nfe,),ishape=(nphase,)+tshape)

## preconditioner
wdata = data[:,0,:,:,:,0]*dcf[:,0,:,:,:,0]
tmp = PFTSs.H*PFTSs*np.complex64(np.ones((nphase,)+tshape))
L=np.mean(np.abs(tmp))


## reconstruction
q2 = np.zeros((nphase,)+tshape,dtype=np.complex64)
Y = np.zeros_like(wdata)
q20 = np.zeros_like(q2)

sigma = 0.4
tau = 0.4
for i in range(outer_iter):
    Y = (Y + sigma*(1/L*PFTSs*q2-wdata))/(1+sigma)
    
    q20 = q2
    q2 = np.complex64(ext.TVt_prox(q2-tau*PFTSs.H*Y,lambda_TV))
    print('outer iter:{}, res:{}'.format(i,np.linalg.norm(q2-q20)/np.linalg.norm(q2)))

    cfl.write_cfl(fname+'_mrL', q2)
