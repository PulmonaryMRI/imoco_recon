# iMoCo reconstruction - python version

## Prerequisite

Generate MRI_Raw.h5 and dicom files in the same directory.

```
pcvipr_recon_binary -dat_plus_dicom -f <pfile or ScanArchive> -export_kdata
```

## For CPU

```
#!/bin/bash
file_dir=$1
echo ${file_dir}

# convert h5
echo Converting h5
python imoco_recon/imoco_py/convert_uwute.py ${file_dir}/MRI_Raw

# run xd-grasp reconstruction
echo Running XD-GRASP
python imoco_recon/imoco_py/recon_xdgrasp.py ${file_dir}/MRI_Raw --device -1

# run mocolor reconstruction
echo Running iMoCo
python imoco_recon/imoco_py/recon_imoco.py ${file_dir}/MRI_Raw --reg_flag 1 --lambda_TV 0.01 --device -1

# convert into DICOM
echo Generating DICOM
python moco_recon/imoco_py/dicom_creation.py ${file_dir}
```

## For GPU

```
#!/bin/bash
file_dir=$1
echo ${file_dir}

# convert h5
echo Converting h5
python imoco_recon/imoco_py/convert_uwute.py ${file_dir}/MRI_Raw

# run xd-grasp reconstruction
echo Running XD-GRASP
python imoco_recon/imoco_py/recon_xdgrasp.py ${file_dir}/MRI_Raw

# run mocolor reconstruction
echo Running iMoCo
python imoco_recon/imoco_py/recon_imoco.py ${file_dir}/MRI_Raw --reg_flag 1 --lambda_TV 0.01

# convert into DICOM
echo Generating DICOM
python imoco_recon/imoco_py/dicom_creation.py ${file_dir}
```
