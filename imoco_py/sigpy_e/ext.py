import sigpy as sp
import numpy as np
import sigpy.mri as mr
import sigpy_e.nft as nft

def jsens_calib(ksp, coord, dcf, ishape, device = sp.Device(-1)):
    img_s = nft.nufft_adj([ksp],[coord],[dcf],device = device,ishape = ishape,id_channel =True)
    ksp = sp.fft(input=np.asarray(img_s[0]),axes=(1,2,3))
    mps = mr.app.JsenseRecon(ksp,
                             mps_ker_width=12,
                             ksp_calib_width=32,
                             lamda=0,
                             device=device,
                             comm=sp.Communicator(),
                             max_iter=10,
                             max_inner_iter=10).run()
    return mps

def FD(ishape, axes=None):
    """Linear operator that computes finite difference gradient.
    Args:
       ishape (tuple of ints): Input shape.
    """
    I = sp.linop.Identity(ishape)
    axes = sp.util._normalize_axes(axes, len(ishape))
    ndim = len(ishape)
    linops = []
    for i in axes:
        D = I - sp.linop.Circshift(ishape, [0] * i + [1] + [0] * (ndim - i - 1))
        R = sp.linop.Reshape([1] + list(ishape), ishape)
        linops.append(R * D)

    G = sp.linop.Vstack(linops, axis=0)

    return G

def TVt_prox(X, lamda, iter_max = 10):
    scale = np.max(np.abs(X))
    X = X/scale
    TVt = FD(X.shape,axes=(0,))
    X_b = X
    Y = TVt*X
    Y = Y/(np.abs(Y)+1e-9)*np.minimum(np.abs(Y)+1e-9,1)
    for _ in range(iter_max):
        X_b = X_b - ((X_b-X)+lamda*TVt.H*Y)
        Y = Y + lamda*TVt*X_b
        Y = Y/(np.abs(Y)+1e-9)*np.minimum(np.abs(Y)+1e-9,1)
        
    X_b = X_b * scale
    return X_b
    
