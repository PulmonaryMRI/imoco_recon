import sigpy as sp
import numpy as np

# restore image in list structure


def nufft_adj1(
    data, traj, dcf, device=sp.Device(-1), smap=None, batch=40000, id_channel=False, ishape=None
):
    xp = device.xp
    N_phase = data.shape[0]
    img = []
    for num_ph in range(N_phase):
        ksp_t = data[num_ph]
        coord_t = traj[num_ph]
        dcf_t = dcf[num_ph]

        if smap is not None:
            img_shape = list(smap.shape[-3:])
        elif ishape is not None:
            img_shape = ishape
        else:
            img_shape = sp.estimate_shape(coord_t)

        num_coils, num_tr, num_ro = ksp_t.shape
        ndim = coord_t.shape[-1]
        if id_channel is True:
            img_t = np.zeros((num_coils,) + tuple(img_shape), dtype=np.complex64)
        else:
            img_t = 0

        with device:
            for c in range(num_coils):
                img_tt = 0
                for seg in range((num_tr - 1) // batch + 1):
                    ksp_ttc = sp.to_device(
                        ksp_t[c, seg * batch : np.minimum((seg + 1) * batch, num_tr), ...], device
                    )
                    coord_tt = sp.to_device(
                        coord_t[seg * batch : np.minimum((seg + 1) * batch, num_tr), ...], device
                    )
                    dcf_tt = sp.to_device(
                        dcf_t[seg * batch : np.minimum((seg + 1) * batch, num_tr), ...], device
                    )
                    img_tt += sp.nufft_adjoint(ksp_ttc * dcf_tt, coord_tt, img_shape)
                # TODO smap
                if id_channel is True:
                    img_t[c, ...] = sp.to_device(img_tt)
                else:
                    if smap is None:
                        img_t += xp.abs(img_tt) ** 2
                    else:
                        img_t += sp.to_device(img_tt * xp.conj(sp.to_device(smap[c, ...], device)))

            img_t = sp.to_device(img_t)
        img.append(img_t)

    return np.asarray(img)


def nufft1(img, traj, device=sp.Device(-1), smap=None, dcf=None, batch=40000, id_channel=False):
    xp = device.xp
    N_phase = img.shape[0]
    ksp = []
    for num_ph in range(N_phase):
        img_t = img[num_ph]
        coord_t = traj[num_ph]
        if dcf is not None:
            dcf_t = dcf[num_ph]
        img_shape = sp.estimate_shape(coord_t)
        num_tr, num_ro, ndim = coord_t.shape
        if id_channel is True:
            num_coils = img_t.shape[0]
        else:
            if smap is None:
                smap = np.array([1])
                num_coils = 1
            else:
                num_coils = smap.shape[0]

        with device:
            ksp_t = np.zeros((num_coils, num_tr, num_ro), dtype=np.complex64)
            for c in range(num_coils):
                if id_channel is True:
                    img_tc = sp.to_device(img_t[c, ...], device)
                else:
                    img_tc = sp.to_device(img_t * smap[c, ...], device)
                for seg in range((num_tr - 1) // batch + 1):
                    coord_tt = sp.to_device(
                        coord_t[seg * batch : np.minimum((seg + 1) * batch, num_tr), ...], device
                    )
                    ksp_tt = sp.nufft(img_tc, coord_tt)
                    if dcf is not None:
                        dcf_tt = sp.to_device(
                            dcf_t[seg * batch : np.minimum((seg + 1) * batch, num_tr), ...], device
                        )
                        ksp_tt = dcf_tt * ksp_tt

                    ksp_t[
                        c, seg * batch : np.minimum((seg + 1) * batch, num_tr), ...
                    ] = sp.to_device(ksp_tt)

        ksp.append(ksp_t)

    return np.asarray(ksp)


def nufft_adj(
    data, traj, dcf, device=sp.Device(-1), smap=None, batch=40000, id_channel=False, ishape=None
):
    xp = device.xp
    N_phase = len(data)
    img = []
    for num_ph in range(N_phase):
        ksp_t = data[num_ph]
        coord_t = traj[num_ph]
        dcf_t = dcf[num_ph]

        if smap is not None:
            img_shape = list(smap.shape[-3:])
        elif ishape is not None:
            img_shape = ishape
        else:
            img_shape = sp.estimate_shape(coord_t)

        num_coils, num_tr, num_ro = ksp_t.shape
        ndim = coord_t.shape[-1]
        if id_channel is True:
            img_t = np.zeros((num_coils,) + tuple(img_shape), dtype=np.complex64)
        else:
            img_t = 0

        with device:
            for c in range(num_coils):
                img_tt = 0
                for seg in range((num_tr - 1) // batch + 1):
                    ksp_ttc = sp.to_device(
                        ksp_t[c, seg * batch : np.minimum((seg + 1) * batch, num_tr), ...], device
                    )
                    coord_tt = sp.to_device(
                        coord_t[seg * batch : np.minimum((seg + 1) * batch, num_tr), ...], device
                    )
                    dcf_tt = sp.to_device(
                        dcf_t[seg * batch : np.minimum((seg + 1) * batch, num_tr), ...], device
                    )
                    img_tt += sp.nufft_adjoint(ksp_ttc * dcf_tt, coord_tt, img_shape)
                # TODO smap
                if id_channel is True:
                    img_t[c, ...] = sp.to_device(img_tt)
                else:
                    if smap is None:
                        img_t += xp.abs(img_tt) ** 2
                    else:
                        img_t += img_tt * xp.conj(sp.to_device(smap[c, ...], device))

            img_t = sp.to_device(img_t)
        img.append(img_t)

    return img


def nufft(img, traj, device=sp.Device(-1), smap=None, dcf=None, batch=40000, id_channel=False):
    xp = device.xp
    N_phase = len(img)
    ksp = []
    for num_ph in range(N_phase):
        img_t = img[num_ph]
        coord_t = traj[num_ph]
        if dcf is not None:
            dcf_t = dcf[num_ph]
        img_shape = sp.estimate_shape(coord_t)
        num_tr, num_ro, ndim = coord_t.shape
        if id_channel is True:
            num_coils = img_t.shape[0]
        else:
            if smap is None:
                smap = np.array([1])
                num_coils = 1
            else:
                num_coils = smap.shape[0]

        with device:
            ksp_t = np.zeros((num_coils, num_tr, num_ro), dtype=np.complex64)
            for c in range(num_coils):
                if id_channel is True:
                    img_tc = sp.to_device(img_t[c, ...], device)
                else:
                    img_tc = sp.to_device(img_t * smap[c, ...], device)
                for seg in range((num_tr - 1) // batch + 1):
                    coord_tt = sp.to_device(
                        coord_t[seg * batch : np.minimum((seg + 1) * batch, num_tr), ...], device
                    )
                    ksp_tt = sp.nufft(img_tc, coord_tt)
                    if dcf is not None:
                        dcf_tt = sp.to_device(
                            dcf_t[seg * batch : np.minimum((seg + 1) * batch, num_tr), ...], device
                        )
                        ksp_tt = dcf_tt * ksp_tt

                    ksp_t[
                        c, seg * batch : np.minimum((seg + 1) * batch, num_tr), ...
                    ] = sp.to_device(ksp_tt)

        ksp.append(ksp_t)

    return ksp
