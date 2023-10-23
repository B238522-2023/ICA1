#!/usr/bin/bash
rm -rf foldchange
mkdir -p foldchange


#generate the foldchange of clone1_T0_Uninduced_g1 and WT_T0_Uninduced_g11
#if the count in WT group is 0,then change it into one to calculate
paste "group/g1_all_avg.txt" "group/g11_all_avg.txt" | awk -F "\t" '
BEGIN{ OFS = "\t" }
{
if ($6 == 0){foldchange=($3/1);}
else{foldchange=($3/$6);}
        {print $1,$2,foldchange;}
}' > foldchange/g1_g11.txt
