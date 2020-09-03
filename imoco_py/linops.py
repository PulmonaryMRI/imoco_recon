import sigpy as sp


def Vstacks(L_Linop, oshape, ishape):
    assert oshape[0] == len(L_Linop), "Number of Linop mismatch!"

    Linops = sp.linop.Vstack(L_Linop)
    i_vec_len = 1
    for tmp in ishape:
        i_vec_len = i_vec_len * tmp
    o_vec_len = 1
    for tmp in oshape:
        o_vec_len = o_vec_len * tmp

    R1 = sp.linop.Reshape(oshape=(o_vec_len,), ishape=oshape)
    Linops = R1.H * Linops

    return Linops


def Diags(L_Linop, oshape, ishape):
    assert oshape[0] == ishape[0], "First dim mismatch!"
    assert oshape[0] == len(L_Linop), "Number of Linop mismatch!"
    Linops = sp.linop.Diag(L_Linop)
    i_vec_len = 1
    for tmp in ishape:
        i_vec_len = i_vec_len * tmp
    o_vec_len = 1
    for tmp in oshape:
        o_vec_len = o_vec_len * tmp

    R1 = sp.linop.Reshape(oshape=(o_vec_len,), ishape=oshape)
    R2 = sp.linop.Reshape(oshape=(i_vec_len,), ishape=ishape)
    Linops = R1.H * Linops * R2

    return Linops


def DLD(Linop, idevice, odevice):
    B1 = sp.linop.ToDevice(Linop.ishape, odevice, idevice)
    B2 = sp.linop.ToDevice(Linop.oshape, odevice, idevice)
    Linop = B2.H * Linop * B1
    return Linop


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


def TVt_prox(X, lamda, iter_max=10, device=-1):
    X = sp.to_device(X, device)
    xp = sp.get_array_module(X)
    scale = xp.max(xp.abs(X))
    X = X / scale
    TVt = FD(X.shape, axes=(0,))
    X_b = X
    Y = TVt * X
    Y = Y / (xp.abs(Y) + 1e-9) * xp.minimum(xp.abs(Y) + 1e-9, 1)
    for _ in range(iter_max):
        X_b = X_b - ((X_b - X) + lamda * TVt.H * Y)
        Y = Y + lamda * TVt * X_b
        Y = Y / (xp.abs(Y) + 1e-9) * xp.minimum(xp.abs(Y) + 1e-9, 1)

    X_b = X_b * scale
    return X_b


def NFTs(ishape, coord, odevice):
    idevice = sp.get_device(coord)
    n_Channel = ishape[0]
    oshape = list((n_Channel,)) + list(coord.shape[:-1])

    NFT = sp.linop.NUFFT(ishape[1:], coord=coord)
    NFTs = Diags([DLD(NFT, idevice, odevice) for i in range(n_Channel)], oshape, ishape)

    return NFTs
