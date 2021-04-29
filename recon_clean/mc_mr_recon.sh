*#! /bin/bash
if [ $# -lt 2 ]
then
    echo "Not enough arguments supplied"
    echo "Usage: recon.sh input lambda"
    exit 113
fi

in=$1
lambda=$2
sg=$3
export OMP_NUM_THREADS=32

bart pics -C 20 -i 80 -R T:7:0:$lambda -p $in"_dcf2m" -t $in"_trajm" $in"_datam" $in"_mapsL" $in"_mrL"
#if [$sg -ne 1]
#then
#    bart pics -m -C 20 -i 80 -u 1 -R T:7:0:$lambda -p $in"_dcf2_sg" -t $in"_traj" $in"_data" $in"_maps" $in"_sg"
#else
#    bash mc_sg_nufft.sh $in
#fi
