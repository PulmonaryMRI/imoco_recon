"""
Conversion of numpy array output of imoco recon to DICOM series - adapted from imoco_py/dicom_creation.py
Command line inputs needed: raw data (numpy array) directory; original DICOM directory
Modified by: Neil J Stewart njstewart-eju (2023/04)
Original author: Fei Tan (ftan1)
"""
import numpy as np
import pydicom as pyd
import datetime
import os
import glob
import sys

if __name__ == '__main__':
    # set directories
    npy_dir = sys.argv[1]
    orig_dicom_dir = sys.argv[2]
    new_dicom_dir = os.path.join(npy_dir, 'imoco_dcm')

    # load data
    im = np.load(os.path.join(npy_dir, 'imoco.npy'))
    im = np.transpose(im, axes=[0, 2, 1])
    #im = np.transpose(im[:, ::-1, ::-1], axes=[0, 2, 1])

    # Uncomment this line to flipe images up-down
    #im = np.flip(im,0)

    # load original dicom
    # exam number, series number
    dcm_ls = glob.glob(orig_dicom_dir + '/*.dcm')
    series_mimic_dir = dcm_ls[0]
    ds = pyd.dcmread(series_mimic_dir)
    # parse exam number, series number
    dcm_file = os.path.basename(series_mimic_dir)
    exam_number, series_mimic, _ = dcm_file.replace('Exam', '').replace(
        'Series', '_').replace('Image', '_').replace('.dcm', '').split('_')
    exam_number = int(exam_number)
    # adding 10, this should ensure no overlap with other series numbers for Philips numbering which uses series number (in order acquired) *100
    series_write = int(series_mimic) + 10

    # modified time
    dt = datetime.datetime.now()

    ds.SeriesDescription = "3D UTE iMoCo"

    # Update SliceLocation information
    series_mimic_slices = np.double(ds.Columns)  # assume recon is isotropic
    SliceLocation_center = ds.SliceLocation - \
        (series_mimic_slices - 1) / 2 * ds.SpacingBetweenSlices
    ImagePosition_zcenter = ds.ImagePositionPatient[2] + (
        series_mimic_slices - 1) / 2 * ds.SpacingBetweenSlices

    im_shape = np.shape(im)
    ds.Columns, ds.Rows = im_shape[-2], im_shape[-1]
    spatial_resolution = ds.SliceThickness

    ds.SpacingBetweenSlices = spatial_resolution
    ds.PixelSpacing = [spatial_resolution, spatial_resolution]
    ds.SliceThickness = spatial_resolution
    ds.ReconstructionDiameter = spatial_resolution * im_shape[-1]

    SliceLocation_original = ds.SliceLocation
    ImagePositionPatient_original = ds.ImagePositionPatient

    try:
        os.mkdir(new_dicom_dir)
    except OSError as error:
        pass

    im = np.abs(im) / np.amax(np.abs(im)) * 4095  # 65535
    im = im.astype(np.uint16)

    # Window and level for the image
    ds.WindowCenter = int(np.amax(im) / 2)
    ds.WindowWidth = int(np.amax(im))

    # dicom series UID
    ds.SeriesInstanceUID = pyd.uid.generate_uid()

    # not currently accounting for oblique slices...
    for z in range(im_shape[0]):
        ds.InstanceNumber = z + 1
        ds.SeriesNumber = series_write
        ds.SOPInstanceUID = pyd.uid.generate_uid()
        # SOPInstanceUID should == MediaStorageSOPInstanceUID
        ds.file_meta.MediaStorageSOPInstanceUID = ds.SOPInstanceUID
        Filename = '{:s}/E{:d}S{:d}I{:d}.DCM'.format(
            new_dicom_dir, exam_number, series_write, z + 1)
        ds.SliceLocation = SliceLocation_original + \
            (im_shape[0] / 2 - (z + 1)) * spatial_resolution
        ds.ImagePositionPatient = pyd.multival.MultiValue(float, [float(ImagePositionPatient_original[0]), float(
            ImagePositionPatient_original[1]), ImagePositionPatient_original[2] - (im_shape[0] / 2 - (z + 1)) * spatial_resolution])
        b = im[z, :, :].astype('<u2')
        ds.PixelData = b.T.tobytes()
        #ds.is_little_endian = False
        ds.save_as(Filename)
