import argparse
import numpy as np
from scipy.signal import savgol_filter


def estimate_respSavitzkyGolay(dc, tr, window=2.0, order=3):
    """Estimate respiratory signal from DC. Adapted from Frank's FIR filter.

    The function performs:
    1) Filter DC with savitzky Golay Filter

    Args:
        dc (array): multi-channel DC array of shape [num_coils, num_tr].
        tr (float): TR in seconds.
        window (float): smoothing window in seconds
        order (int): polynomial order.
    Returns:
        array: respiratory signal of length num_tr.
    """
    dc = np.abs(dc)
    # fs = 1 / tr
    window_length = int(window / tr)
    if window_length % 2 == 0:
        window_length += 1
    sigma_max = 0
    for c in range(len(dc)):
        resp_c = savgol_filter(dc[c], window_length, order)
        sigma_c = 1.4826 * np.median(np.abs(resp_c - np.median(resp_c)))

        if sigma_c > sigma_max:
            resp = (resp_c - np.median(resp_c)) / sigma_c
            sigma_max = sigma_c
    return resp/resp.max()


if __name__ == "__main__":

    parser = argparse.ArgumentParser(description="Estimate respiratory signal.")

    parser.add_argument("ksp_file", type=str, help="k-space file.")
    parser.add_argument("tr", type=float, help="TR in seconds.")
    parser.add_argument("resp_file", type=str, help="Output respiratory signal file.")

    args = parser.parse_args()

    ksp = np.load(args.ksp_file)
    dc = ksp[:, :, 0]
    resp = estimate_resp(dc, args.tr)
    np.save(args.resp_file, resp)
