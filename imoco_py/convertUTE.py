import logging
import sigpy.mri as mr
import h5py
import numpy as np
import argparse
import os


def convertUTE(h5_file, dsfSpokes=1.0):

    with h5py.File(h5_file, "r") as hf:

        try:
            time = np.squeeze(hf["Gating"]["time"])
            order = np.argsort(time)
        except Exception:
            time = np.squeeze(hf["Gating"]["TIME_E0"])
            order = np.argsort(time)

        try:
            resp = np.squeeze(hf["Gating"]["resp"])
            resp = resp[order]
        except Exception:
            resp = np.squeeze(hf["Gating"]["RESP_E0"])
            resp = resp[order]

        coord = []
        for i in ["Z", "Y", "X"]:
            logging.info(f"Loading {i} coords.")

            coord.append(hf["Kdata"][f"K{i}_E0"][0][order])

        coord = np.stack(coord, axis=-1)

        logging.info("Loading density compensation function")
        dcf = hf["Kdata"]["KW_E0"][0][order]

        num_coils = 0
        while f"KData_E0_C{num_coils}" in hf["Kdata"]:
            num_coils += 1
        logging.info(f"Number of coils: {num_coils}")

        ksp = []
        for c in range(num_coils):
            logging.info(f"Loading kspace, coil {c + 1} / {num_coils}.")

            # k = hf["Kdata"][f"KData_E0_C{c}"]
            ksp.append(
                hf["Kdata"][f"KData_E0_C{c}"]["real"][0][order]
                + 1j * hf["Kdata"][f"KData_E0_C{c}"]["imag"][0][order]
            )
        logging.info(f"Stacking as np array...")
        ksp = np.stack(ksp, axis=0)
        try:
            noise = hf["Kdata"]["Noise"]["real"] + 1j * hf["Kdata"]["Noise"]["imag"]
            logging.info("Whitening ksp.")
            cov = mr.util.get_cov(noise)
            ksp = mr.util.whiten(ksp, cov)
            # ksp /= np.abs(ksp).max()
        except (MemoryError, Exception):
            logging.info("No noise data exists. Scaling by max value.")
            ksp /= np.abs(ksp).max()

    totalSpokes = ksp.shape[1]
    nSpokes = int(totalSpokes // dsfSpokes)
    ksp = ksp[:, :nSpokes, :]
    coord = coord[:nSpokes, :, :]
    dcf = dcf[:nSpokes, :]
    logging.info(f"Total Number of Spokes: {totalSpokes}, Requested Number of Spokes: {nSpokes}")

    return ksp, coord, dcf, resp/resp.max()


if __name__ == "__main__":

    parser = argparse.ArgumentParser(
        description="Converts UWUTE h5 files to npy arrays in natural time ordering."
    )
    parser.add_argument("h5_file", type=str)
    parser.add_argument("ksp_file", type=str)
    parser.add_argument("coord_file", type=str)
    parser.add_argument("dcf_file", type=str)
    parser.add_argument("resp_file", type=str)
    parser.add_argument("--dsfSpokes", type=float, default=1.0)
    args = parser.parse_args()
    logging.basicConfig(level=logging.INFO)

    ksp, coord, dcf, resp = convertUTE(args.h5_file, args.dsfSpokes)
    logging.info("Saving data.")
    if os.path.isfile(args.ksp_file):
        os.remove(args.ksp_file)
        os.remove(args.coord_file)
        os.remove(args.dcf_file)
        os.remove(args.resp_file)
    np.save(args.ksp_file, ksp)
    np.save(args.coord_file, coord)
    np.save(args.dcf_file, dcf)
    np.save(args.resp_file, resp)
