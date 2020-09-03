import argparse
import sigpy as sp
import numpy as np
import sigpy.mri as mr
from imoco_e import cfl, ext
from imoco_e.linop_e import NFTs, Diags
from tqdm import trange
import time
import logging


def xdgrasp(
    ksp,
    coord,
    dcf,
    res_scale=1.0,
    lambda_tv=0.05,
    inner_iter=10,
    outer_iter=20,
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

    nf_arr = np.sqrt(np.sum(coord[0, 0, :, :] ** 2, axis=1))
    nReadouts = np.sum(nf_arr < np.max(nf_arr) * res_scale)
    del nf_arr

    coord = coord[..., :nReadouts, :]
    ksp = ksp[..., :nReadouts]
    dcf = dcf[..., :nReadouts]
    logging.info("Image Shape Estimate: {}".format(sp.estimate_shape(coord)))
    nPhases, nCoils, nSpokes, nReadouts = ksp.shape

    # calibration
    logging.info("Running calibration...")
    # Map for each Motion Phase?
    mps = mr.app.JsenseRecon(
        ksp[0],
        coord=coord[0],
        weights=dcf[0]**2,
        mps_ker_width=12,
        ksp_calib_width=32,
        lamda=0,
        device=device,
        max_iter=10,
        max_inner_iter=10,
    ).run()
    mps = sp.to_device(mps)
    if nCoils <= 1:
        mps = np.ones_like(mps)
    tshape = mps.shape[1:]
    S = sp.linop.Multiply(tshape, mps)
    del mps
    logging.info("Image Shape: {}....".format(tshape))
    logging.info("Computing Linops...")
    PFTSs = []
    for ii in trange(nPhases, desc="Motion Phases"):
        FTs = NFTs((nCoils,)+tshape, coord[ii], device=sp.Device(device))
        W = sp.linop.Multiply((nCoils, nSpokes, nReadouts,), dcf[ii])
        FTSs = W*FTs*S
        PFTSs.append(FTSs)
    PFTSs = Diags(PFTSs, oshape=(nPhases, nCoils, nSpokes, nReadouts,), ishape=(nPhases,) + tshape)

    logging.info("Computing Preconditioner...")
    timeI = time.time()
    L = PFTSs.H * PFTSs * np.complex64(np.ones((nPhases,) + tshape))
    L = np.mean(np.abs(L))
    timeF = time.time()
    logging.info("Preconditioner Value: {}".format(L))
    logging.info("Time for preconditioner: {} seconds.".format(timeF - timeI))

    # reconstruction
    dcf = dcf[:, xp.newaxis, ...]
    # plt.ImagePlot(ksp)
    ksp = ksp * dcf
    # plt.ImagePlot(ksp)
    img = np.zeros((nPhases,) + tshape, dtype=np.complex64)
    Y = np.zeros_like(ksp)
    img_0 = np.zeros_like(img)
    tau = 0.4
    sigma = 0.4
    logging.info("Running XD-Grasp")
    pbarOuter = trange(outer_iter, leave=True)
    for ii in pbarOuter:
        timeI = time.time()
        pbarOuter.set_description("XD-Grasp Outer Iter {}".format(ii))
        Y = (Y + sigma*(1/L*PFTSs*img-ksp))/(1+sigma)
        img = np.complex64(ext.TVt_prox(img-tau*PFTSs.H*Y, lambda_tv))
        timeF = time.time()
        pbarOuter.set_postfix(
            loss=np.linalg.norm(img - img_0) / np.linalg.norm(img), time=timeF - timeI
        )
        img_0 = img
    timeFinish = time.time()
    logging.info("XDGrasp Recon Finished in: {} min...".format((timeFinish - timeStart) / 60))
    return sp.to_device(img)


if __name__ == "__main__":
    # IO parameters
    parser = argparse.ArgumentParser(description="XD-GRASP recon.")
    parser.add_argument("ksp_file", type=str, help="k-space file.")
    parser.add_argument("coord_file", type=str, help="trajectory file.")
    parser.add_argument("dcf_file", type=str, help="dcf file.")
    parser.add_argument("img_file", type=str, help="img out file.")
    parser.add_argument("--res_scale", type=float, default=1.0, help="scale of resolution 0-1")
    parser.add_argument("--lambda_tv", type=float, default=2e-2, help="TV regularization, 0.05")
    parser.add_argument("--inner_iter", type=int, default=10, help="Num of inner Iterations.")
    parser.add_argument("--outer_iter", type=int, default=20, help="Num of outer Iterations.")
    parser.add_argument("--device", type=int, default=0, help="Computing device.")
    args = parser.parse_args()

    # Read in data
    ksp = np.load(args.ksp_file)
    coord = np.load(args.coord_file)
    dcf = np.load(args.dcf_file)

    img = xdgrasp(
        ksp,
        coord,
        dcf,
        args.res_scale,
        args.lambda_tv,
        args.inner_iter,
        args.outer_iter,
        args.device,
    )
    print("writing data...")
    # plt.ImagePlot(img)
    cfl.write_cfl(args.img_file, img)
