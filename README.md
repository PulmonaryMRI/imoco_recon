# iMoCo reconstruction for MRI

Description: iterative Motion Compensation reconstruction methods

![image](https://user-images.githubusercontent.com/8160868/133513918-77b1f25f-3a76-4eab-944f-679a984001e5.png)

## Reference

Zhu, X, Chan, M, Lustig, M, Johnson, KM, Larson, PEZ. Iterative motion-compensation reconstruction ultra-short TE (iMoCo UTE) for high-resolution free-breathing pulmonary MRI. Magn Reson Med. 2020; 83: 1208– 1221. https://doi.org/10.1002/mrm.27998

## Code Information

### Contents
   * ./imoco : iMoCo reconstruction in Matlab.
   * ./recon_clean : iMoCo reconstruction preparation, including coil calibration, motion resolved reconstruction, carried out by BART (https://github.com/mrirecon/bart.git).
   * ./imoco_py : python based iMoCo reconstruction. Sigpy and ANTs are required.
   * ./imoco_npy: python based iMoCo reconstruction. Sigpy and ANTs are required. Support numpy array as I/O.

### python packages version required
   * numpy==1.17.4
   * cupy==6.0.0
   * sigpy==0.1.16

## Sample dataset

https://zenodo.org/record/3733776#.XoJlNC2ZPOQ

## Support

NIH NHLBI R01HL136965

Principal Investigators: Peder Larson, PhD (UCSF), Kevin Johnson, PhD (U Wisconsin), Shreyas Vasanawala, MD, PhD (Stanford), Miki Lustig, PhD (UC Berkeley)
