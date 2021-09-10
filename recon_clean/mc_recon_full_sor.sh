#! /bin/bash
if [ $# -lt 2 ]
then
    echo "Not enough arguments"
    echo "Usage: mc_recon_full_v2.sh <h5-file-prefix> <pfile>"
    exit 113
fi

# exit when error
set -e

in=$1
pfile=$2 
h5=${in}/MRI_Raw
wd=/working/larson6/ftan/imoco_recon/recon_clean/
X=240
Y=192
Z=192

export OMP_NUM_THREADS=32

TR=3
nTE=1
nbin=6
cycle_flag=0
motion_flag=2

echo "Converting h5 ..."
matlab_2017a -nodesktop -nosplash -r "addpath('$wd');h5_convert_mTE('$h5', '$h5', $nTE, 500, [1.25,1,1]);quit;"

echo "Motion resolved recon ..."
matlab_2017a -nodesktop -nosplash -r "addpath('/working/larson6/ftan/imoco_recon/recon_clean/');motion_resolved('$h5', $motion_flag, $nbin, $TR, $cycle_flag);quit;"

nCoils=`tail -n 1 ${h5}_data.hdr | cut -d " " -f4`

if [ $nCoils -gt 16 ]
then
    bash ${wd}/mc_prep_recon_cc.sh $h5 $X $Y $Z $nCoils
    bash ${wd}/mc_mr_recon_cc.sh $h5 0.005
    echo "iMoCo recon ..."
    matlab_2017a -nodesktop -nosplash -r "addpath('/working/larson6/ftan/imoco_recon/recon_clean/');imoco_cc('$h5');quit;"

else
    bash ${wd}/mc_prep_recon.sh $h5 $X $Y $Z
    bash ${wd}/mc_mr_recon.sh $h5 0.005
    echo "iMoCo recon ..."
    matlab_2017a -nodesktop -nosplash -r "addpath('/working/larson6/ftan/imoco_recon/recon_clean/');imoco('$h5');quit;"
fi


echo "Converting to Dicom ..."
matlab_2017a -nodesktop -nosplash -r "addpath('/working/larson6/ftan/imoco_recon/recon_clean/');write_3dute_dicom_push('$h5', '$pfile', 'imoco', '$in');quit;"

rm *.hdr *.cfl
echo "Done."