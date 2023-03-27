import sigpy as sp
import numpy as np
import os
from sigpy.linop import Linop
from sigpy import backend

__all__ = ['NFTs']

def Vstacks(L_Linop, oshape, ishape):
    assert oshape[0]==len(L_Linop), 'Number of Linop mismatch!'
    
    Linops = sp.linop.Vstack(L_Linop)
    i_vec_len = 1
    for tmp in ishape:
        i_vec_len = i_vec_len * tmp
    o_vec_len = 1
    for tmp in oshape:
        o_vec_len = o_vec_len * tmp
    
    R1 = sp.linop.Reshape(oshape=(o_vec_len,),ishape=oshape)
    Linops = R1.H*Linops
    
    return Linops

def Hstacks(L_Linop, oshape, ishape):
    # assert oshape[0]==len(L_Linop), 'Number of Linop mismatch!'
    
    Linops = sp.linop.Hstack(L_Linop)
    i_vec_len = 1
    for tmp in ishape:
        i_vec_len = i_vec_len * tmp
    o_vec_len = 1
    for tmp in oshape:
        o_vec_len = o_vec_len * tmp
    
    R2 = sp.linop.Reshape(oshape=(i_vec_len,),ishape=ishape)
    Linops = Linops*R2
    
    return Linops

def Diags(L_Linop, oshape, ishape):
    assert oshape[0]==ishape[0], 'First dim mismatch!'
    assert oshape[0]==len(L_Linop), 'Number of Linop mismatch!'
    Linops = sp.linop.Diag(L_Linop)
    i_vec_len = 1
    for tmp in ishape:
        i_vec_len = i_vec_len * tmp
    o_vec_len = 1
    for tmp in oshape:
        o_vec_len = o_vec_len * tmp
    
    R1 = sp.linop.Reshape(oshape=(o_vec_len,),ishape=oshape)
    R2 = sp.linop.Reshape(oshape=(i_vec_len,),ishape=ishape)
    Linops = R1.H*Linops*R2
    
    return Linops

def DLD(Linop, device = sp.Device(-1)):
    B1 = sp.linop.ToDevice(Linop.ishape,idevice=sp.Device(-1),odevice=device)
    B2 = sp.linop.ToDevice(Linop.oshape,idevice=sp.Device(-1),odevice=device)
    Linop = B2.H*Linop*B1
    return Linop
    
def NFTs(ishape, coord, device = sp.Device(-1)):
    n_Channel = ishape[0]
    oshape = list((n_Channel,)) + list(coord.shape[:-1])
    
    NFT = sp.linop.NUFFT(ishape[1:], coord=coord)
    NFTs = Diags([DLD(NFT,device=device) for i in range(n_Channel)],oshape,ishape)

#     B1 = sp.linop.ToDevice(NFT.ishape,idevice=sp.Device(-1),odevice=device)
#     B2 = sp.linop.ToDevice(NFT.oshape,idevice=sp.Device(-1),odevice=device)
#     NFTs = Diags([B2.H*NFT*B1 for i in range(n_Channel)],oshape,ishape)
#     i_vec_len = 1
#     for tmp in ishape:
#         i_vec_len = i_vec_len * tmp
#     o_vec_len = 1
#     for tmp in oshape:
#         o_vec_len = o_vec_len * tmp
    
#     NFTs = sp.linop.Diag([B2.H*NFT*B1 for i in range(n_Channel)])
#     R1 = sp.linop.Reshape(oshape=(o_vec_len,),ishape=oshape)
#     R2 = sp.linop.Reshape(oshape=(i_vec_len,),ishape=ishape)
#     NFTs = R1.H*NFTs*R2
    
    return NFTs

