import numpy as np


def normalize(I_in, minv, maxv):
    out = (maxv - minv) * (I_in - np.min(I_in[:])) / (np.max(I_in[:]) - np.min(I_in[:])) + minv
    return out
