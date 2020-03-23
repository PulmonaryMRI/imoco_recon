#! /bin/bash
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

bart pics -C 20 -i 80 -R T:7:0:$lambda -p $in"_dcf2m" -t $in"_trajm" $in"_data1m" $in"_mapsL" $in"_mrL"


