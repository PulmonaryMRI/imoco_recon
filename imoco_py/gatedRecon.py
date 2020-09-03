import argparse
import sigpy as sp
import numpy as np
import nibabel as nib
from tqdm import trange
import time
import logging


def gatingWeights(resp, gating_type="hard", percentile=25, decay=1, flip=False):
    sigma = 1.4628 * np.median(np.abs(resp - np.median(resp)))
    resp = (resp - np.median(resp)) / sigma
    thresh = np.percentile(resp, percentile)
    if flip:
        resp *= -1
    if gating_type == "hard":
        return np.where(resp < thresh, 1, 0)
    elif gating_type == "soft":
        return np.exp(-decay * np.maximum((resp - thresh), 0))


def gatedRecon(
    ksp,
    coord,
    dcf,
    resp,
    gating_type="none",
    gating_thresh=0.5,
    gating_weight=1.0,
    device=0,
):
    timeStart = time.time()
    sp.Device(device).use()
    xp = sp.Device(device).xp
    if device >= 0:
        logging.info("Using GPU...")
    else:
        logging.info("Using CPU...")

    logging.info("Kspace Shape: {}...".format(ksp.shape))
    logging.info("trajectory Shape: {}...".format(coord.shape))
    logging.info("DCF Shape: {}....".format(dcf.shape))

    logging.info("Image Shape Estimate: {}".format(sp.estimate_shape(coord)))
    nCoils, nSpokes, nReadouts = ksp.shape

    img_shape = sp.estimate_shape(coord)
    logging.info("Image Shape: {}....".format(img_shape))

    logging.info("Running Gated Recon")

    # Respiratory Gating
    if gating_type == "none":
        pass
    elif gating_type == "hard":
        W = gatingWeights(resp, gating_type="hard", percentile=gating_thresh, decay=gating_weight, flip=True)
        idx = W == 1
        ksp = ksp[:, idx]
        coord = coord[idx]
        dcf = dcf[idx]
        del W
    elif gating_type == "soft":
        W = gatingWeights(resp, gating_type="soft", percentile=gating_thresh, decay=gating_weight, flip=True)
        W_correct = np.broadcast_to(W[..., None], W.shape+(ksp.shape[2],))
        dcf = dcf * W_correct
        del W, W_correct

    else:
        raise ValueError('Unknown Gating Type.')
    # reconstruction
    pbarOuter = trange(nCoils, leave=True)
    coord = sp.to_device(coord, device)
    ksp = ksp * (dcf**2)
    with sp.Device(device):
        img = 0
        for c in pbarOuter:
            timeI = time.time()
            pbarOuter.set_description("Reconstructing Coil # {}".format(c))
            ksp_c = sp.to_device(ksp[c], device)
            img_c = sp.nufft_adjoint(ksp_c, coord, oshape=img_shape)
            img += sp.to_device(xp.abs(img_c**2))
            pbarOuter.set_postfix(time=(time.time() - timeI) / 60)
        img = img ** 0.5

    timeFinish = time.time()
    logging.info("Recon Finished in: {} min...".format((timeFinish - timeStart) / 60))
    del img_c, ksp_c, dcf, coord
    img = np.transpose(img, (2, 1, 0))
    img = np.flip(img, (0, 1, 2))
    return img


if __name__ == "__main__":
    # IO parameters
    parser = argparse.ArgumentParser(description="Gated recon.")
    parser.add_argument("ksp_file", type=str, help="k-space file.")
    parser.add_argument("coord_file", type=str, help="trajectory file.")
    parser.add_argument("dcf_file", type=str, help="dcf file.")
    parser.add_argument("resp_file", type=str, help="resp. waveform file.")
    parser.add_argument("img_file", type=str, help="img out filepath.")
    parser.add_argument("--device", type=int, default=-1, help="Computing device.")
    parser.add_argument("--gating_type", type=str, default="none", help="Gating Type. Options are 'none', 'hard','soft'")
    parser.add_argument("--gating_thresh", type=float, default=0.5, help="Gating Threshold. Options range from 0.0 to 1.0")
    parser.add_argument("--gating_weight", type=float, default=1.0, help="Gating weight decay for soft threshold.")
    args = parser.parse_args()

    # Read in data
    ksp = np.load(args.ksp_file)
    coord = np.load(args.coord_file)
    dcf = np.load(args.dcf_file)
    resp = np.load(args.resp_file)
    img = gatedRecon(
        ksp,
        coord,
        dcf,
        resp,
        gating_type=args.gating_type,
        gating_thresh=args.gating_thresh,
        gating_weight=args.gating_weight,
        device=args.device,
    )
    print("writing data...")
    img = sp.resize(np.abs(img), (256, 256, 256))
    img = nib.Nifti1Image(img, np.eye(4))
    nib.save(img, args.img_file)
