#! /bin/bash
if [ $# -lt 5 ]
then
    echo "Not enough arguments supplied"
    echo "Usage: recon.sh input,X,Y,Z,coil"
    exit 113
fi

in=$1
X=$2
Y=$3
Z=$4
coil=$5
export DEBUG_LEVEL=5
set -x

bart fmac $in"_data" $in"_dcf" $in"_datac"
# low res calib
# bart nufft -a -d 240:192:192 $in"_traj" $in"_datac" $in"_imgL"
bart nufft -a -d $2:$3:$4 $in"_traj" $in"_datac" $in"_imgL"
bart fft  7 $in"_imgL" $in"_ksp"
bart cc -M $in"_ksp" $in"_ccMatrix"
bart ccapply -p $coil $in"_ksp" $in"_ccMatrix" $in"_ksp1"
bart ccapply -p $coil $in"_data" $in"_ccMatrix" $in"_data1" 
bart ccapply -p $coil $in"_datam" $in"_ccMatrix" $in"_data1m"
bart fmac $in"_data1" $in"_dcf" $in"_datac"

bart caldir 24:24:24 $in"_ksp1" $in"_mapsL"
# bart nufft -a -d $2:$3:$4 $in"_traj" $in"_datac" $in"_imgL"
# bart fmac -s 8 -A $in"_imgL" $in"_mapsL" $in"_test"
# high res calib
bart nufft -a $in"_traj" $in"_datac" $in"_img"
bart rss 8 $in"_img" $in"_nufft"
bart fft  7 $in"_img" $in"_ksp"
bart caldir 24:24:24 $in"_ksp" $in"_maps"
rm $in"_datac".*
rm $in"_img".*
