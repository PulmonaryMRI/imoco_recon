#! /bin/bash
if [ $# -lt 4 ]
then
    echo "Not enough arguments supplied"
    echo "Usage: recon.sh input X,Y,Z"
    exit 113
fi

in=$1
X=$2
Y=$3
Z=$4

export DEBUG_LEVEL=5
set -x

bart fmac $in"_data" $in"_dcf" $in"_datac0"
bart slice 5 0 $in"_datac0" $in"_datac"
bart slice 5 0 $in"_traj" $in"_traj1"
# low res calib
# bart nufft -a -d 240:192:192 $in"_traj" $in"_datac" $in"_imgL"
bart nufft -a -d $2:$3:$4 $in"_traj1" $in"_datac" $in"_imgL"
bart fft  7 $in"_imgL" $in"_ksp"
bart caldir 32:32:32 $in"_ksp" $in"_mapsL"
# high res calib
bart nufft -a $in"_traj1" $in"_datac" $in"_img"
# bart rss 8 $in"_img" $in"_nufft"
bart fft  7 $in"_img" $in"_ksp"
bart caldir 32:32:32 $in"_ksp" $in"_maps"
bart fmac -C -s 8 $in"_img" $in"_maps" $in"_nufft"
rm $in"_nufft_t"*
rm $in"_datac"*
rm $in"_traj1."*
rm $in"_img".*
