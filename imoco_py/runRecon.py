import os
cores = "1"
os.environ["OMP_NUM_THREADS"] = cores  # export OMP_NUM_THREADS=4
os.environ["OPENBLAS_NUM_THREADS"] = cores  # export OPENBLAS_NUM_THREADS=4
os.environ["MKL_NUM_THREADS"] = cores  # export MKL_NUM_THREADS=6
os.environ["VECLIB_MAXIMUM_THREADS"] = cores  # export VECLIB_MAXIMUM_THREADS=4
os.environ["NUMEXPR_NUM_THREADS"] = cores  # export NUMEXPR_NUM_THREADS=6
import nibabel as nib
from convertUTE import convertUTE
from estimate_respSavitzkyGolay import estimate_respSavitzkyGolay
from binMotionStates import binMotionStates
from xdgrasp import xdgrasp
from imoco import imoco
from moco import moco
from gatedRecon import gatedRecon
import logging
from pathlib import Path
import sigpy as sp
import numpy as np
import time


def runRecon(rawDir, outDir, imoco_lambda=0.025, xdgrasp_lambda=0.025, nBins=6, dc_signal=1, postfix="", device=0):
    try:
        timei = time.time()
        prefix = "Pre"
        tr = 0.0034  # repetition time in s

        overWriteNoGating = False
        overWriteHardGating = False
        overWriteSoftGating = False
        overWriteLowRes = False
        overWriteiMoCoExp = False
        overWriteiMoCoInsp = False
        overWriteHighRes = False
        overWriteMoCoExp = False
        overWriteMoCoInsp = False

        register = 1
        nRef = -1  # Reference Frame (last ie expiratory)

        # Set up data paths
        motionResolvedDir = os.path.join(outDir, prefix+"ContrastMotionResolved")
        iterativeMocoDir = os.path.join(outDir, prefix+"ContrastIterativeMoCo")
        iterativeMocoInspDir = os.path.join(outDir, prefix+"ContrastIterativeMoCoInsp")
        mocoDir = os.path.join(outDir, prefix+"ContrastMoCo")
        mocoInspDir = os.path.join(outDir, prefix + "ContrastMoCoInsp")
        noGateDir = os.path.join(outDir, prefix + "ContrastNoGate")
        hardGateDir = os.path.join(outDir, prefix + "ContrastHardGate")
        softGateDir = os.path.join(outDir, prefix + "ContrastSoftGate")

        h5Path = os.path.join(rawDir, "MRI_Raw.h5")
        kspPath = os.path.join(rawDir, "ksp.npy")
        coordPath = os.path.join(rawDir, "coord.npy")
        dcfPath = os.path.join(rawDir, "dcf.npy")
        respPath = os.path.join(rawDir, "resp.npy")
        h5Path = os.path.join(rawDir, "MRI_Raw.h5")
        diagnosticsDir = os.path.join(motionResolvedDir, "diagnostics")
        mrimgPath = os.path.join(motionResolvedDir, "MotionResolved.nii.gz")
        mrimgLPath = os.path.join(motionResolvedDir, "MotionResolvedLowRes.nii.gz")
        mrimgLRawPath = os.path.join(diagnosticsDir, "MotionResolvedLowRes.npy")
        imgMocoPath = os.path.join(mocoDir, "MoCo.nii.gz")
        imgPath = os.path.join(iterativeMocoDir, "iMoCo_" + str(postfix) + ".nii.gz")
        imgInspPath = os.path.join(iterativeMocoInspDir, "iMoCo.nii.gz")
        imgMocoInspPath = os.path.join(mocoInspDir, "MoCo.nii.gz")
        imgNoGatePath = os.path.join(noGateDir, "noGate.nii.gz")
        imgHardGatePath = os.path.join(hardGateDir, "hardGate.nii.gz")
        imgSoftGatePath = os.path.join(softGateDir, "softGate.nii.gz")

        # Create outpath if doesn't exist.
        Path(motionResolvedDir).mkdir(parents=True, exist_ok=True)
        Path(iterativeMocoDir).mkdir(parents=True, exist_ok=True)
        Path(diagnosticsDir).mkdir(parents=True, exist_ok=True)
        Path(mocoDir).mkdir(parents=True, exist_ok=True)
        Path(iterativeMocoInspDir).mkdir(parents=True, exist_ok=True)
        Path(mocoInspDir).mkdir(parents=True, exist_ok=True)
        Path(noGateDir).mkdir(parents=True, exist_ok=True)
        Path(hardGateDir).mkdir(parents=True, exist_ok=True)
        Path(softGateDir).mkdir(parents=True, exist_ok=True)

        # 1) Convert MRI_Raw.h5 to cfl and read resp waveform. OR READ converted data
        if os.path.exists(kspPath) is False:
            logging.info("Running File Conversion...")
            ksp, coord, dcf, resp = convertUTE(h5Path)
            dcf **= 0.5
            np.save(kspPath, ksp)
            np.save(coordPath, coord)
            np.save(dcfPath, dcf)
        else:
            ksp = np.load(kspPath)
            coord = np.load(coordPath)
            dcf = np.load(dcfPath)

        logging.info("Kspace Shape: {}...".format(ksp.shape))
        logging.info("trajectory Shape: {}...".format(coord.shape))
        logging.info("DCF Shape: {}....".format(dcf.shape))

        # Estimate Respiratory Waveform
        if dc_signal is True:
            resp = estimate_respSavitzkyGolay(ksp[:, :, 0], tr, 2.0, 2)

        # 3) noGating Recon
        if os.path.exists(imgNoGatePath) is False or overWriteNoGating is True:
            imgNoGate = gatedRecon(ksp, coord, dcf, resp, gating_type="none", device=device)
            imgNoGate = sp.resize(np.abs(imgNoGate), (256, 256, 256))
            imgNoGate = nib.Nifti1Image(imgNoGate, np.eye(4))
            nib.save(imgNoGate, imgNoGatePath)
            del imgNoGate

        # 4) hardGating Recon
        if os.path.exists(imgHardGatePath) is False or overWriteHardGating is True:
            imgHardGate = gatedRecon(ksp, coord, dcf, resp, gating_type="hard", gating_thresh=0.5, device=device)
            imgHardGate = sp.resize(np.abs(imgHardGate), (256, 256, 256))
            imgHardGate = nib.Nifti1Image(imgHardGate, np.eye(4))
            nib.save(imgHardGate, imgHardGatePath)
            del imgHardGate

        # 5) softGating Recon
        if os.path.exists(imgSoftGatePath) is False or overWriteSoftGating is True:
            imgSoftGate = gatedRecon(ksp, coord, dcf, resp, gating_type="soft", gating_thresh=0.25, gating_weight=3, device=device)
            imgSoftGate = sp.resize(np.abs(imgSoftGate), (256, 256, 256))
            imgSoftGate = nib.Nifti1Image(imgSoftGate, np.eye(4))
            nib.save(imgSoftGate, imgSoftGatePath)
            del imgSoftGate

        # 6) Bin Motion States
        logging.info("Running BinMotionStates...")
        ksp, coord, dcf = binMotionStates(ksp, coord, dcf, resp, nBins)
        del resp  # not needed anymore

        # 7) Low Res xdgrasp recon
        if os.path.exists(mrimgLPath) is False or os.path.exists(mrimgLRawPath) is False or overWriteLowRes is True:
            logging.info("Running Low Res XDGrasp Reconstruction...")
            mrimg = xdgrasp(ksp, coord, dcf, res_scale=0.75, lambda_tv=xdgrasp_lambda, device=device)
            np.save(mrimgLRawPath, mrimg)
            mrimgL = sp.resize(mrimg, (nBins, 192, 192, 192))
            mrimgL = np.moveaxis(np.abs(mrimgL), 0, -1)
            mrimgL = np.transpose(mrimgL, (2, 1, 0, 3))
            mrimgL = np.flip(mrimgL, (0, 1, 2))
            mrimgL = nib.Nifti1Image(mrimgL, np.eye(4))
            nib.save(mrimgL, mrimgLPath)
            del mrimgL

        # 8) iMoCo recon expir
        if os.path.exists(imgPath) is False or overWriteiMoCoExp is True:
            if overWriteLowRes is False:
                mrimg = np.load(mrimgLRawPath)
            logging.info("Running iMoCo Reconstruction...")
            img = imoco(ksp, coord, dcf, mrimg, diagnosticsDir, res_scale=1.0, lambda_tv=imoco_lambda, inner_iter=15, outer_iter=20, device=device, nRef=nRef, reg_flag=register)
            img = sp.resize(np.abs(img), (256, 256, 256))
            img = nib.Nifti1Image(img, np.eye(4))
            nib.save(img, imgPath)
            del img

        # 9) iMoCo recon Insp
        if os.path.exists(imgInspPath) is False or overWriteiMoCoInsp is True:
            logging.info("Running iMoCo Inspiratory Reconstruction...")
            imgInsp = imoco(ksp, coord, dcf, mrimg, diagnosticsDir, res_scale=1.0, lambda_tv=imoco_lambda, inner_iter=15, outer_iter=20, device=device, nRef=0, reg_flag=register)
            imgInsp = sp.resize(np.abs(imgInsp), (256, 256, 256))
            imgInsp = nib.Nifti1Image(imgInsp, np.eye(4))
            nib.save(imgInsp, imgInspPath)
            del imgInsp, mrimg

        # 10) Full Res xdgrasp recon
        if os.path.exists(mrimgPath) is False or overWriteHighRes is True:
            logging.info("Running Full Res XDGrasp Reconstruction...")
            mrimg = xdgrasp(ksp, coord, dcf, res_scale=1.0, lambda_tv=xdgrasp_lambda, device=device)
            mrimg = sp.resize(mrimg, (nBins, 256, 256, 256))
            mrimg = np.moveaxis(np.abs(mrimg), 0, -1)
            mrimg = np.transpose(mrimg, (2, 1, 0, 3))
            mrimg = np.flip(mrimg, (0, 1, 2))
            mrimg = nib.Nifti1Image(mrimg, np.eye(4))
            nib.save(mrimg, mrimgPath)
            del ksp, coord, dcf, mrimg

        # 11) Full Res MoCo Expiratory
        if os.path.exists(imgMocoPath) is False or overWriteMoCoExp is True:
            imgMoco = moco(mrimgPath, diagnosticsDir, nRef=nRef)
            imgMoco = nib.Nifti1Image(imgMoco, np.eye(4))
            nib.save(imgMoco, imgMocoPath)
            del imgMoco

        # 12) Full Res MoCo Inspiratory
        if os.path.exists(imgMocoInspPath) is False or overWriteMoCoInsp is True:
            imgMocoInsp = moco(mrimgPath, diagnosticsDir, nRef=0)
            imgMocoInsp = nib.Nifti1Image(imgMocoInsp, np.eye(4))
            nib.save(imgMocoInsp, imgMocoInspPath)
            del imgMocoInsp

        timeF = (time.time() - timei) / 60
        logging.info("Finshed Subject {} in {} minutes".format(subject, timeF))
        # destroy data every loop
    except KeyboardInterrupt:
        print("interrupted!")
