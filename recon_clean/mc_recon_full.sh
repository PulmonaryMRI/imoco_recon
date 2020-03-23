#! /bin/bash
if [ $# -lt 4 ]
then
    echo "Not enough arguments supplied"
    echo "Usage: recon.sh input X Y Z"
    exit 113
fi

in=$1
X=$2
Y=$3
Z=$4

bash mc_prep_recon.sh $in $X $Y $Z
bash mc_mr_recon.sh $in 1000
matlab_2017a -nodesktop -nosplash -nodisplay -r "imoco('"$in"');quit;"
