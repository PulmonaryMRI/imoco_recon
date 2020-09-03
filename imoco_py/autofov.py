import argparse
import numpy as np
import sigpy as sp
from scipy import ndimage
from skimage import measure
import logging
from normalize import normalize
import os
from PIL import Image


def getLargestCC(mask):
    labels = measure.label(mask)
    assert labels.max() != 0  # assume at least 1 CC
    largestCC = labels == np.argmax(np.bincount(labels.flat)[1:]) + 1
    return largestCC


def autofov(ksp, coord, dcf, diagPath, num_ro=100, device=-1, thresh=0.4, radial=False):
    """Automatic estimation of FOV.

    FOV is estimated by thresholding a low resolution gridded image.
    coord will be modified in-place.

    Args:
        ksp (array): k-space measurements of shape (C, num_tr, num_ro, D).
            where C is the number of channels,
            num_tr is the number of TRs, num_ro is the readout points,
            and D is the number of spatial dimensions.
        coord (array): k-space coordinates of shape (num_tr, num_ro, D).
        dcf (array): density compensation factor of shape (num_tr, num_ro).
        num_ro (int): number of read-out points.
        device (Device): computing device.
        thresh (float): threshold between 0 and 1.

    """
    device = sp.Device(device)
    xp = device.xp
    with device:
        if radial is True:
            ro_center = ksp.shape[2] // 2
            ro_range = slice(ro_center - num_ro // 2, ro_center + num_ro // 2, 1)
        else:
            ro_range = slice(0, num_ro, 1)
        logging.info("AutoFov Input Shape: {}".format(sp.estimate_shape(coord)))

        kspc = ksp[:, :, ro_range]
        coordc = coord[:, ro_range, :]
        dcfc = dcf[:, ro_range]
        # Multiply by two so we can encompass entire FOV.
        coordc2 = sp.to_device(coordc * 2, device)
        num_coils = len(kspc)
        imgc_shape = np.array(sp.estimate_shape(coordc))
        imgc2_shape = sp.estimate_shape(coordc2)
        imgc2_center = [i // 2 for i in imgc2_shape]
        logging.info("Adjoint Nufft 1")
        imgc2 = sp.nufft_adjoint(
            sp.to_device(dcfc * kspc, device), coordc2, [num_coils] + imgc2_shape
        )
        imgc2 = xp.sum(xp.abs(imgc2) ** 2, axis=0) ** 0.5
        imgc2 = sp.to_device(imgc2)
        # Filter image?-----------------------
        # filt = sp.to_device(sp.hanning((16, 16, 16)), device)
        # filt = sp.resize(filt, imgc2.shape)
        # imgc2 = sp.convolve(imgc2, filt)
        # imgc2 = sp.ifft(sp.fft(sp.to_device(imgc2, device), norm=None) * filt, norm=None)
        imgc2 = ndimage.median_filter(imgc2, (3, 3, 3))
        # -----------------------------------
        imgc2 /= imgc2.max()
        # plt.ImagePlot(imgc2)
        imc = normalize(imgc2[:, imgc2.shape[1] // 2, :], 0, 255)
        imc = Image.fromarray(imc)
        imc = imc.convert("L")
        imc.save(diagPath + "/d_lowResCoronal.jpg")

        ims = normalize(imgc2[:, :, imgc2.shape[2] // 2], 0, 255)
        ims = Image.fromarray(ims)
        ims = ims.convert("L")
        ims.save(diagPath + "/d_lowResSaggital.jpg")

        ima = normalize(imgc2[imgc2.shape[0] // 2, :, :], 0, 255)
        ima = Image.fromarray(ima)
        ima = ima.convert("L")
        ima.save(diagPath + "/d_lowResAxial.jpg")

        # if imgc2.ndim == 3:
        #     imgc2_cor = imgc2[:, imgc2.shape[1] // 2, :]
        #     thresh *= imgc2_cor.max()
        # else:
        thresh *= imgc2.max()
        boxc = imgc2 > thresh
        boxc = getLargestCC(boxc)
        imc = boxc[:, boxc.shape[1] // 2, :]
        imc = Image.fromarray(imc)
        imc = imc.convert("L")
        imc.save(diagPath + "/d_maskCoronal.jpg")

        ims = boxc[:, :, boxc.shape[2] // 2]
        ims = Image.fromarray(ims)
        ims = ims.convert("L")
        ims.save(diagPath + "/d_maskSaggital.jpg")

        ima = boxc[boxc.shape[0] // 2, :, :]
        ima = Image.fromarray(ima)
        ima = ima.convert("L")
        ima.save(diagPath + "/d_maskAxial.jpg")
        boxc_idx = np.nonzero(boxc)
        boxc_shape = np.array(
            [int(np.abs(boxc_idx[i] - imgc2_center[i]).max()) * 2 for i in range(imgc2.ndim)]
        )
        img_scale = boxc_shape / imgc_shape
        if radial:
            img_scale *= 2
        coord *= img_scale
        # --------------------
        coordc = coord[:, ro_range, :]
        coordc = sp.to_device(coordc, device)
        num_coils = len(kspc)
        imgc_shape = sp.estimate_shape(coordc)
        logging.info("Adjoint Nufft 2")
        imgc = sp.nufft_adjoint(sp.to_device(dcfc * kspc, device), coordc, [num_coils] + imgc_shape)
        imgc = xp.sum(xp.abs(imgc) ** 2, axis=0) ** 0.5
        # plt.ImagePlot(imgc)
        imgc = sp.to_device(xp.abs(imgc))
        imc = normalize(imgc[:, imgc.shape[1] // 2, :], 0, 255)
        imc = Image.fromarray(imc)
        imc = imc.convert("L")
        imc.save(diagPath + "/d_effectiveFOVCoronal.jpg")

        ims = normalize(imgc[:, :, imgc.shape[2] // 2], 0, 255)
        ims = Image.fromarray(ims)
        ims = ims.convert("L")
        ims.save(diagPath + "/d_effectiveFOVSaggital.jpg")

        ima = normalize(imgc[imgc.shape[0] // 2, :, :], 0, 255)
        ima = Image.fromarray(ima)
        ima = ima.convert("L")
        ima.save(diagPath + "/d_effectiveFOVAxial.jpg")
        logging.info("AutoFov Output Shape: {}".format(sp.estimate_shape(coord)))
        logging.info("Scaling Factors: {}".format(img_scale))
        np.save(diagPath + "/fovScaleFactors.npy", img_scale)

        # --------------------
        return coord


if __name__ == "__main__":

    logging.basicConfig(level=logging.INFO)

    parser = argparse.ArgumentParser()
    parser.add_argument("--num_ro", type=int, default=100)
    parser.add_argument("--device", type=int, default=0)
    parser.add_argument("--thresh", type=float, default=0.1)

    parser.add_argument("ksp_file", type=str)
    parser.add_argument("coord_file", type=str)
    parser.add_argument("dcf_file", type=str)
    parser.add_argument("diagnosticsDir", type=str)

    parser.add_argument("--radial", action="store_true")

    args = parser.parse_args()

    ksp = np.load(args.ksp_file)
    coord = np.load(args.coord_file)
    dcf = np.load(args.dcf_file)
    print("Kspace Shape Original: {}".format(ksp.shape))
    print("Input Image Shape: {}".format(sp.estimate_shape(coord)))

    coordOut = autofov(
        ksp,
        coord,
        dcf,
        diagPath=args.diagnosticsDir,
        num_ro=args.num_ro,
        device=args.device,
        thresh=args.thresh,
        radial=args.radial,
    )

    logging.info("Output Image shape: {}".format(sp.estimate_shape(coordOut)))

    logging.info("Saving data.")
    if os.path.isfile(args.coord_file):
        os.remove(args.coord_file)
    np.save(args.coord_file, coordOut)
