import argparse
import numpy as np
from imoco_e import cfl, reg
from tqdm import trange
import logging
import time
import nibabel as nib


def moco(
    mrimgPath,
    fname,
    nRef=-1,
    reg_flag=1,
):
    timeStart = time.time()
    #  Load mrimg
    mrimg = nib.load(mrimgPath).get_fdata()
    mrimg = np.moveaxis(np.abs(mrimg), -1, 0)
    nPhases = mrimg.shape[0]
    tshape = mrimg.shape[1:]
    logging.info("Registration...")
    M_fields = []
    iM_fields = []
    if reg_flag is 1:
        pbar = trange(nPhases, leave=True)
        for ii in pbar:
            pbar.set_description("Registering Frame # {}...".format(ii))
            M_field, iM_field = reg.ANTsReg(np.abs(mrimg[nRef]), np.abs(mrimg[ii]))
            M_fields.append(M_field)
            iM_fields.append(iM_field)
        M_fields = np.asarray(M_fields)
        iM_fields = np.asarray(iM_fields)
        # np.save(fname + "/M_mrFull.npy", M_fields)
        # np.save(fname + "/iM_mrFull.npy", iM_fields)
    else:
        pass
        # M_fields = np.load(fname + "/M_mrFull.npy")
        # iM_fields = np.load(fname + "/iM_mrFull.npy")

    iM_fields = [iM_fields[i] for i in range(iM_fields.shape[0])]
    M_fields = [M_fields[i] for i in range(M_fields.shape[0])]

    img = 0
    pbar = trange(nPhases, leave=True)
    for ii in pbar:
        pbar.set_description("Applying Warp To Frame # {}...".format(ii))
        M = reg.interp_op(tshape, M_fields[ii])
        img += M * mrimg[ii]
    img = img / nPhases

    timeFinish = time.time()
    logging.info("Moco Registration Finished in: {} min...".format((timeFinish - timeStart) / 60))
    return img


if __name__ == "__main__":
    # IO parameters
    parser = argparse.ArgumentParser(description="imoco recon.")
    parser.add_argument("ksp_file", type=str, help="k-space file.")
    parser.add_argument("coord_file", type=str, help="coordectory file.")
    parser.add_argument("dcf_file", type=str, help="dcf file.")
    parser.add_argument("img_file", type=str, help="img out file.")
    parser.add_argument("--res_scale", type=float, default=1.0, help="scale of resolution 0-1")
    parser.add_argument("--lambda_tv", type=float, default=2e-2, help="TV regularization, 0.05")
    parser.add_argument("--inner_iter", type=int, default=10, help="Num of inner Iterations.")
    parser.add_argument("--outer_iter", type=int, default=20, help="Num of outer Iterations.")
    parser.add_argument("--device", type=int, default=0, help="Computing device.")
    args = parser.parse_args()

    # Read in ksp
    ksp = np.load(args.ksp_file)
    coord = np.load(args.coord_file)
    dcf = np.load(args.dcf_file)

    img = moco(
        ksp,
        coord,
        dcf,
        args.res_scale,
        args.lambda_tv,
        args.inner_iter,
        args.outer_iter,
        args.device,
    )
    print("writing ksp...")
    # plt.ImagePlot(img)
    cfl.write_cfl(args.img_file, img)
