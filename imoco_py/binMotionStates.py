import argparse
import numpy as np
import os
import logging


def binMotionStates(ksp, coord, dcf, resp, n):
    """Bin kspace, coordinates, and dcf by respiratory motion.

    Args:
        ksp (array): kspace
        coord (array): coordinates.
        dcf (array): density weights.
        resp (array): waveform.
        n (int): number of bins.

    Returns:
        kspB
        coordB
        dcfB
    """
    nSpokes = dcf.shape[0]
    count = 0
    while nSpokes % n is not 0:
        count += 1
        nSpokes -= 1
    logging.info("Count is {}".format(count))
    logging.info("nSpokes is {}".format(nSpokes))

    ksp = ksp[:, :nSpokes]
    coord = coord[:nSpokes]
    dcf = dcf[:nSpokes]
    resp = resp[:nSpokes]
    nSpokesB = int(nSpokes // n)
    respOrder = np.argsort(resp)

    kspB = []
    coordB = []
    dcfB = []
    for b in range(n):
        idx = respOrder[b * nSpokesB : (b + 1) * nSpokesB]
        kspB.append(ksp[:, idx])
        coordB.append(coord[idx])
        dcfB.append(dcf[idx])
    kspB = np.stack(kspB)
    coordB = np.stack(coordB)
    dcfB = np.stack(dcfB)
    return kspB, coordB, dcfB


if __name__ == "__main__":

    parser = argparse.ArgumentParser(description="Bin data based on Respiratory Motion.")

    parser.add_argument("ksp_file", type=str, help="k-space file.")
    parser.add_argument("coord_file", type=str, help="trajectory file.")
    parser.add_argument("dcf_file", type=str, help="dcf file.")
    parser.add_argument("resp_file", type=str, help="Output respiratory signal file.")
    parser.add_argument("ksp_ofile", type=str, help="binned k-space file.")
    parser.add_argument("coord_ofile", type=str, help="binned trajectory file.")
    parser.add_argument("dcf_ofile", type=str, help="binned dcf file.")
    parser.add_argument("--n_bins", type=int, default=6, help="Number of bins")

    args = parser.parse_args()

    ksp = np.load(args.ksp_file)
    coord = np.load(args.coord_file)
    dcf = np.load(args.dcf_file)
    resp = np.load(args.resp_file)

    kspB, coordB, dcfB = binMotionStates(ksp, coord, dcf, resp, args.n_bins)
    print("kspace shape: {}".format(kspB.shape))
    print("trajectory shape: {}".format(coordB.shape))
    print("dcf shape: {}".format(dcfB.shape))

    if os.path.isfile(args.ksp_ofile):
        os.remove(args.ksp_ofile)
        os.remove(args.coord_ofile)
        os.remove(args.dcf_ofile)
    np.save(args.ksp_ofile, kspB)
    np.save(args.coord_ofile, coordB)
    np.save(args.dcf_ofile, dcfB)
