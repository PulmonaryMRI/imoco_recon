import argparse 

import sigpy as sp
import scipy.ndimage as ndimage_c
import numpy as np

import sys
sys.path.append("./sigpy_mc/")
import sigpy_e.cfl as cfl

import sigpy_e.ext as ext
import sigpy_e.prox as prox
import sigpy_e.reg as reg
from sigpy_e.linop_e import NFTs,Diags,DLD,Vstacks
import sigpy.mri as mr

if __name__ == '__main__':


    ## IO parameters
    parser = argparse.ArgumentParser(description='iterative motion compensation recon.')

    parser.add_argument('--res_scale', type=float, default=1,
                        help='scale of resolution, full res == 1')
    parser.add_argument('--fov_x', type=float, default=1,
                        help='scale of FOV x, full res == 1')
    parser.add_argument('--fov_y', type=float, default=1,
                        help='scale of FOV y, full res == 1')
    parser.add_argument('--fov_z', type=float, default=1,
                        help='scale of FOV z, full res == 1')
    parser.add_argument('--n_ref', type=int, default=-1,
                        help='reference frame, default is -1.')
    parser.add_argument('--reg_flag', type=int, default=0,
                        help='derive motion field from registration')

    parser.add_argument('--lambda_TV', type=float, default=5e-2,
                        help='low rank regularization, default is 0.05')
    parser.add_argument('--iner_iter', type=int, default=15,
                        help='Num of inner iterations.')
    parser.add_argument('--outer_iter', type=int, default=20,
                        help='Num of outer iterations.')
    parser.add_argument('--device', type=int, default=0,
                        help='Computing device.')
    parser.add_argument('fname', type=str,
                        help='Prefix of raw data and output(_mocolor).')
    args = parser.parse_args()


    #
    res_scale = args.res_scale
    fname = args.fname
    lambda_TV = args.lambda_TV
    device = args.device
    outer_iter = args.outer_iter
    iner_iter = args.iner_iter
    fov_scale = (args.fov_x, args.fov_y, args.fov_z)
    n_ref = args.n_ref
    reg_flag = args.reg_flag

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

    ## calibration
    print('Calibration...')
    ksp = np.reshape(np.transpose(data,(2,1,0,3,4,5)),(nCoil,nphase*npe,nfe))
    dcf2 = np.reshape(np.transpose(dcf**2,(2,1,0,3,4,5)),(nphase*npe,nfe))
    coord = np.reshape(np.transpose(traj,(2,1,0,3,4,5)),(nphase*npe,nfe,3))

    mps = ext.jsens_calib(ksp,coord,dcf2,device = sp.Device(device),ishape = tshape)
    S = sp.linop.Multiply(tshape, mps)

    # Delete some unused arrays to save memory
    dcf2 = None
    ksp = None
    coord = None

    imgL = cfl.read_cfl(fname+'_mrL')
    imgL = np.squeeze(imgL)

    ## registration
    print('Registration...')
    M_fields = []
    iM_fields = []
    if reg_flag == 1:
        for i in range(nphase):
            M_field, iM_field = reg.ANTsReg(np.abs(imgL[n_ref]), np.abs(imgL[i]))
            M_fields.append(M_field)
            iM_fields.append(iM_field)
        M_fields = np.asarray(M_fields)
        iM_fields = np.asarray(iM_fields)
    #     np.save(fname+'_M_mr.npy',M_fields)
    #     np.save(fname+'_iM_mr.npy',iM_fields)
    # else:
    #     M_fields = np.load(fname+'_M_mr.npy')
    #     iM_fields = np.load(fname+'_iM_mr.npy')

    # Delete some unused arrays to save memory
    M_field = None
    iM_field = None
    imgL = None
    mps = None

    # numpy array to list
    iM_fields = [iM_fields[i] for i in range(iM_fields.shape[0])]
    M_fields = [M_fields[i] for i in range(M_fields.shape[0])]

    ######## TODO scale M_field
    print('Motion Field scaling...')
    M_fields = [reg.M_scale(M,tshape) for M in M_fields]
    iM_fields = [reg.M_scale(M,tshape) for M in iM_fields]

    ## low rank
    print('Prep...')
    Ms = []
    M0s = []
    for i in range(nphase):
        # M = reg.interp_op(tshape,iM_fields[i],M_fields[i])
        M = reg.interp_op(tshape,M_fields[i])
        M0 = reg.interp_op(tshape,np.zeros(tshape+(3,)))
        M = DLD(M,device=sp.Device(device))
        M0 = DLD(M0,device=sp.Device(device))
        Ms.append(M)
        M0s.append(M0)
    Ms = Diags(Ms,oshape=(nphase,)+tshape,ishape=(nphase,)+tshape)
    M0s = Diags(M0s,oshape=(nphase,)+tshape,ishape=(nphase,)+tshape)

    PFTSMs = []
    Is = []
    for i in range(nphase):
        Is.append(sp.linop.Identity(tshape))
        FTs = NFTs((nCoil,)+tshape,traj[i,0,0,...],device=sp.Device(device))
        M = reg.interp_op(tshape,M_fields[i])
        M = DLD(M,device=sp.Device(device))
        W = sp.linop.Multiply((nCoil,npe,nfe,),dcf[i,0,0,:,:,0]) 
        FTSM = W*FTs*S*M
        PFTSMs.append(FTSM)
    PFTSMs = Diags(PFTSMs,oshape=(nphase,nCoil,npe,nfe,),ishape=(nphase,)+tshape)*Vstacks(Is,ishape=tshape,oshape=(nphase,)+tshape)
    
    ## precondition
    print('Preconditioner calculation...')
    tmp = PFTSMs.H*PFTSMs*np.complex64(np.ones(tshape))
    L=np.mean(np.abs(tmp))
    wdata = data[:,0,:,:,:,0]*dcf[:,0,:,:,:,0]*1e4
    
    TV = sp.linop.FiniteDifference(PFTSMs.ishape,axes = (0,1,2))
    ####### debug
    print('TV dim:{}'.format(TV.oshape))
    #proxg = sp.prox.UnitaryTransform(sp.prox.L1Reg(TV.oshape, lambda_TV), TV)
    
    # Delete some unused arrays to save memory
    dcf = None
    traj = None
    tmp = None
    S = None
    Is = None
    Ms = None
    M0s = None
    M = None
    W = None
    FTs = None
    FTSM = None
    M_fields = None
    iM_fields = None

    # ADMM
    print('Recon...')
    alpha = np.max(np.abs(PFTSMs.H*wdata))
    ###### debug
    print('alpha:{}'.format(alpha))
    sigma = 0.4
    tau = 0.4
    X = np.zeros(tshape,dtype=np.complex64)
    p = np.zeros_like(wdata)
    X0 = np.zeros_like(X)
    q = np.zeros((3,)+tshape,dtype=np.complex64)
    for i in range(outer_iter):
        p = (p + sigma*(PFTSMs*X-wdata))/(1+sigma)
        q = (q + sigma*TV*X)
        q = q/(np.maximum(np.abs(q),alpha)/alpha)
        X0 = X
        X = X-tau*(1/L*PFTSMs.H*p + lambda_TV*TV.H*q)
        print('outer iter:{}, res:{}'.format(i,np.linalg.norm(X-X0)/np.linalg.norm(X)))
        
        cfl.write_cfl(fname+'_imoco', X)
    


