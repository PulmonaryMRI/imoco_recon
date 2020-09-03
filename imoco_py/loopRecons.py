import os
cores = "1"
os.environ["OMP_NUM_THREADS"] = cores  # export OMP_NUM_THREADS=4
os.environ["OPENBLAS_NUM_THREADS"] = cores  # export OPENBLAS_NUM_THREADS=4
os.environ["MKL_NUM_THREADS"] = cores  # export MKL_NUM_THREADS=6
os.environ["VECLIB_MAXIMUM_THREADS"] = cores  # export VECLIB_MAXIMUM_THREADS=4
os.environ["NUMEXPR_NUM_THREADS"] = cores  # export NUMEXPR_NUM_THREADS=6
import numpy as np
import time
from runRecon import runRecon
import logging as logging

logging.basicConfig(level=logging.INFO)
# Directory which contains ksp.npy and others (or MRI_Raw.h5)
rawDir = <>
# Output Directory
outDir = <>

timei = time.time()
runRecon(rawDir, outDir, imoco_lambda=0.025, xdgrasp_lambda=0.025, nBins=6, dc_signal=1, postfix="", device=0)
timeF = (time.time() - timei) / 60
logging.info("Finshed Subject in {} minutes".format(timeF))
# destroy data every loop
except KeyboardInterrupt:
    print("interrupted!")
