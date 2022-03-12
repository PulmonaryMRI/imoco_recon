import argparse 

import sigpy as sp
import scipy.ndimage as ndimage_c
import numpy as np

import sys
sys.path.append("./sigpy_mc/")
import cfl 
import ext

import sigpy_e.prox as prox
import sigpy_e.reg as reg
from sigpy_e.linop_e import NFTs,Diags,DLD,Vstacks
import sigpy.mri as mr

if __name__ == '__main__':


    ## IO parameters
    parser = argparse.ArgumentParser(description='motion compensated low rank constrained recon for cone DCE.')

    parser.add_argument('--res_scale', type=float, default=1,
                        help='scale of resolution, full res == 1')
    parser.add_argument('--fov_x', type=float, default=1,
                        help='scale of FOV x, full res == 1')
    parser.add_argument('--fov_y', type=float, default=1,
                        help='scale of FOV y, full res == 1')
    parser.add_argument('--fov_z', type=float, default=1,
                        help='scale of FOV z, full res == 1')
    parser.add_argument('--n_ref', type=float, default=3,
                        help='reference frame')
    parser.add_argument('--reg_flag', type=int, default=0,
                        help='derive motion field from registration')
    parser.add_argument('--aff_flag', type=int, default=0,
                        help='add aff transform')
    parser.add_argument('--mr_cflag', type=int, default=1,
                        help='Resp motion compensation')
    parser.add_argument('--aff_cflag', type=int, default=1,
                        help='Affine motion compensation')

    parser.add_argument('--m_states', type=int, default=5,
                        help='number of motion states')
    parser.add_argument('--lambda_TV', type=float, default=5e-2,
                        help='TV regularization, default is 0.05')
    parser.add_argument('--lambda_lr', type=float, default=5e-3,
                        help='low rank regularization, default is 0.005')       
    parser.add_argument('--pd_step', type=float, default=0.25,
                        help='PDHG step size, default is 0.25')
    parser.add_argument('--outer_iter', type=int, default=30,
                        help='Num of outer iterations.')
    parser.add_argument('--device', type=int, default=0,
                        help='Computing device.')
    parser.add_argument('fname', type=str,
                        help='Prefix of raw data and output(_nframe).')
    # a set of CFL files, including(kspace, trajectory, density_compensation_weighting, and resp signal)

    args = parser.parse_args()


    #
    res_scale = args.res_scale
    fname = args.fname
    lambda_TV = args.lambda_TV
    device = args.device
    outer_iter = args.outer_iter
    fov_scale = (args.fov_x, args.fov_y, args.fov_z)
    n_ref = args.n_ref
    reg_flag = args.reg_flag
    aff_flag = args.aff_flag
    mr_cflag = args.mr_cflag
    aff_cflag = args.aff_cflag
    lambda_lr = args.lambda_lr
    pd_step = args.pd_step

    ## data loading
    data = np.load(fname+'/ksp.npy')
    traj = np.real(np.load(fname+'/coord.npy'))
    dcf = np.sqrt(np.load(fname+'/dcf.npy'))
    gating = np.real(cfl.read_cfl(fname+'/gating'))

    nf_scale = 1
    nf_arr = np.sqrt(np.sum(traj[0,:,:]**2,axis = 1)) 
    nf_e = np.sum(nf_arr<=np.floor(np.max(nf_arr)*nf_scale))
    scale = (1, 1, .8)
    traj[...,0] = traj[...,0]*scale[0]
    traj[...,1] = traj[...,1]*scale[1]
    traj[...,2] = traj[...,2]*scale[2]

    traj = traj[...,:nf_e,:]
    data = data[...,:nf_e]
    dcf = dcf[...,:nf_e]

    tshape = (np.int(np.max(traj[...,0])-np.min(traj[...,0]))
              ,np.int(np.max(traj[...,1])-np.min(traj[...,1]))
              ,np.int(np.max(traj[...,2])-np.min(traj[...,2])))
    
    nphase = 5 # motion resolved
    N_pdyn = 400
    N_dyn = 80
    N_ppdyn = int(N_pdyn/nphase)
    
    ## step 1 affine survey
    print('Affine Motion Prep...')
    # crop data
    if aff_flag > 0:
        nf_scale = .4
        nf_e = int(traj.shape[1]*nf_scale)
        traj_c = traj[...,:nf_e,:]
        data_c = data[...,:nf_e]
        dcf_c = dcf[...,:nf_e]

        nCoil,npe,nfe = data_c.shape
        tshape1 = (np.int(np.max(traj_c[...,0])-np.min(traj_c[...,0]))
                  ,np.int(np.max(traj_c[...,1])-np.min(traj_c[...,1]))
                  ,np.int(np.max(traj_c[...,2])-np.min(traj_c[...,2])))
        print('Affine transform estimation:{}'.format(tshape1))

        # smap calibration
        mps = ext.jsens_calib(data_c,traj_c,dcf_c,device = sp.Device(device0),ishape = tshape1)
        S = sp.linop.Multiply(tshape1, mps)

        # dynamic segmentation
        data_dyn = []
        traj_dyn = []
        dcf_dyn = []
        for i in range(N_dyn):
            data_t = data_c[:,i*N_pdyn:(i+1)*N_pdyn,:]
            traj_t = traj_c[i*N_pdyn:(i+1)*N_pdyn,:,:]
            dcf_t = dcf_c[i*N_pdyn:(i+1)*N_pdyn,:]

            data_dyn.append(data_t)
            traj_dyn.append(traj_t)
            dcf_dyn.append(dcf_t)
        data_dyn = np.asarray(data_dyn)
        traj_dyn = np.asarray(traj_dyn)
        dcf_dyn = np.asarray(dcf_dyn)

        # recon prep
        PFTSs = []
        for i in range(N_dyn):
            FTs = NFTs((nCoil,)+tshape1,traj_dyn[i],device=sp.Device(device))
            W = sp.linop.Multiply((nCoil,N_pdyn,nfe,),dcf_dyn[i]) 
            FTSs = W*FTs*S
            PFTSs.append(FTSs)
        PFTSs = Diags(PFTSs,oshape=(N_dyn,nCoil,N_pdyn,nfe,),ishape=(N_dyn,)+tshape1)

        # preconditioner
        tmp = FTSs.H*FTSs*np.complex64(np.ones(tshape1))
        L=np.mean(np.abs(tmp))
        print('precondition:{}'.format(L))

        # recon
        wdata = data_dyn*dcf_dyn[:,None,...]
        q1 = np.zeros((N_dyn,)+tshape1,dtype=np.complex64)
        Y = np.zeros_like(wdata)
        q10 = np.zeros_like(q1)

        sigma = 0.2
        tau = 0.2
        for i in range(outer_iter):
            Y = (Y + sigma*(1/L*PFTSs*q1-wdata))/(1+sigma)

            q10 = q1
            q1 = np.complex64(ext.TVt_prox(q1-tau*PFTSs.H*Y,lambda_TV))
            print('outer iter:{}, res:{}'.format(i,np.linalg.norm(q1-q10)/np.linalg.norm(q1)))

        q1 = np.abs(q1)/np.max(np.abs(q1))
        cfl.write_cfl(fname+'_mr_lrs', q1)
        qm = np.mean(q1,axis=0)
        aff_scale = [tshape[0]/tshape1[0],tshape[1]/tshape1[1],tshape[2]/tshape1[2]]

        # affine
        Afun = lambda x :reg.ANTsAff(qm,x,vox_res = aff_scale)
        TAs = []
        for i in range(N_dyn):
            TA = Afun(q1[i])
            TAs.append(TA)
        TAs = np.asarray(TAs)
        cfl.write_cfl(fname+'_AffMs', TAs)
    else:
        TAs = np.real(cfl.read_cfl(fname+'_AffMs'))
        
    # resp motion resolve
    print('Respiratory Motion Prep...')
    N_mstates = nphase
    n_ref = -1
    M_fields = []
    iM_fields = []
    if reg_flag > 0:
        # motion resolved recon plugin
        for i in range(nphase):
            M_field, iM_field = reg.ANTsReg(np.abs(imgL[n_ref]), np.abs(imgL[i]))
            M_fields.append(M_field)
            iM_fields.append(iM_field)
        M_fields = np.asarray(M_fields)
        iM_fields = np.asarray(iM_fields)
        np.save(fname+'_M_mr.npy',M_fields)
        np.save(fname+'_iM_mr.npy',iM_fields)
    else:
        M_fields = np.load(fname+'_M_mr.npy')
        iM_fields = np.load(fname+'_iM_mr.npy')

    iM_fields = [iM_fields[i] for i in range(iM_fields.shape[0])]
    M_fields = [M_fields[i] for i in range(M_fields.shape[0])]
    
    # final recon prep
    print('Low-rank recon Prep...')
    nCoil,npe,nfe = data.shape
    mps = ext.jsens_calib(data,traj,dcf,device = sp.Device(device),ishape = tshape)
    S = sp.linop.Multiply(tshape, mps)
    print('Image size:{}'.format(tshape))
    
    data_dyn = []
    traj_dyn = []
    dcf_dyn = []
    for i in range(N_dyn):
        data_t = data[:,i*N_pdyn:(i+1)*N_pdyn,:]
        traj_t = traj[i*N_pdyn:(i+1)*N_pdyn,:,:]
        dcf_t = dcf[i*N_pdyn:(i+1)*N_pdyn,:]
        m_index = np.zeros(N_pdyn)
        gating_s = gating[0,0,0,2,i*N_pdyn:(i+1)*N_pdyn] 
        for k in range(nphase):
            q = np.percentile(gating_s,100/nphase*k)
            m_index[gating_s>=q] = m_index[gating_s>=q] + 1
        data_dyn.append([[data_t[k][m_index==(i+1)] for k in range(nCoil)] for i in range(nphase)])
        traj_dyn.append([traj_t[m_index==(i+1)] for i in range(nphase)])
        dcf_dyn.append([dcf_t[m_index==(i+1)] for i in range(nphase)])
    data_dyn = np.asarray(data_dyn)
    traj_dyn = np.asarray(traj_dyn)
    dcf_dyn = np.asarray(dcf_dyn)
    
    print('Prep...')
    t = 0
    DPFTSMs = []
    for i in range(N_dyn):
        PFTSMs = []
        Is = []
        for k in range(nphase):
            Is.append(sp.linop.Identity(tshape))
            FTs = NFTs((nCoil,)+tshape,traj_dyn[i][k],device=sp.Device(device))
            M = reg.interp_op(tshape,M_fields[k])
            M = DLD(M,device=sp.Device(device))
            W = sp.linop.Multiply((nCoil,N_ppdyn,nfe,),dcf_dyn[i][k])
            if mr_cflag > 0:
                FTSM = W*FTs*S*M
            else:
                FTSM = W*FTs*S
            PFTSMs.append(FTSM)

        PFTSMs = Diags(PFTSMs,oshape=(nphase,nCoil,N_ppdyn,nfe,),ishape=(nphase,)+tshape)*Vstacks(Is,ishape=tshape,oshape=(nphase,)+tshape)
        # affine transform
        if aff_cflag > 0:
            aff_flag = ((np.abs(TAs[i][3,1])+np.abs(TAs[i][3,1])+np.abs(TAs[i][3,2]))/3)>5e-1
            if aff_flag:
                PFTSMs = PFTSMs*(reg.interp_affine_op(tshape,TAs[i]).H)
        DPFTSMs.append(PFTSMs)
    DPFTSMs = Diags(DPFTSMs,oshape=(N_dyn,nphase,nCoil,N_ppdyn,nfe,),ishape=(N_dyn,)+tshape)   
    
    ## preconditioner single phase calibration
    print('Preconditioner calculation...')
    tmp = PFTSMs.H*PFTSMs*np.complex64(np.ones(tshape))
    L=np.mean(np.abs(tmp))
    print('Preconditioning scale:{}'.format(L))
    ##
    
    ## recon
    wdata_dyn = data_dyn*dcf_dyn[:,:,None,:,:]
    # lambda_lr = .005
    # outer_iter = 25
    LR = prox.GLRA((N_dyn,)+tshape,lambda_lr)

    ## reconstruction
    q2 = np.zeros((N_dyn,)+tshape,dtype=np.complex64)
    Y = np.zeros_like(wdata_dyn)
    Y0 = np.zeros_like(Y)

    sigma = pd_step
    tau = pd_step
    for i in range(outer_iter):
        Y0 = Y
        Y = (Y + sigma*(1/L*DPFTSMs*q2-wdata_dyn))/(1+sigma)
        q2 = np.complex64(LR(1,q2-tau*DPFTSMs.H*Y))
        print('outer iter:{}, res:{}'.format(i,np.linalg.norm(Y-Y0)/np.linalg.norm(Y)))
        # cfl.write_cfl(fname+'_dce{}_a{}_m{}'.format(N_dyn,aff_cflag,mr_cflag),q2)
        cfl.write_cfl(fname+'_dce{}_a{}_m{}_lr{}'.format(N_dyn,aff_cflag,mr_cflag,int(lambda_lr*1000)),q2)
