#! /bin/bash
if [ $# -lt 5 ]
then
    echo "Not enough arguments supplied"
    echo "Usage: recon.sh input X Y Z nCoil"
    exit 113
fi

in=$1
X=$2
Y=$3
Z=$4
nCoil=$5

bash mc_prep_recon_cc.sh $in $X $Y $Z $nCoil
bash mc_mr_recon_cc.sh $in 1000
matlab_2017a -nodesktop -nosplash -nodisplay -r "imoco_cc('"$in"');quit;"
