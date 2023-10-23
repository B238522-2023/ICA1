#!/usr/bin/bash
rm -rf foldchange
mkdir -p foldchange


#1)different type,same time,same treatment: clone1_T0_Uninduced_g1 and WT_T0_Uninduced_g11
#if the count in WT group is 0,then change it into one to calculate
paste "group/g1_all_avg.txt" "group/g11_all_avg.txt" | awk -F "\t" '
BEGIN{ OFS = "\t" }
{
if ($6 == 0){foldchange=($3/1);}
else{foldchange=($3/$6);}
        {print $1,$2,foldchange;}
}' > foldchange/g1_g11.txt
#2)same type,different time,same treatment:CL1_T24_Uninduced_g3 and CL1_T48_Uninduced_g5
paste "group/g3_all_avg.txt" "group/g5_all_avg.txt" | awk -F "\t" '
BEGIN{ OFS = "\t" }
{
if ($6 == 0){foldchange=($3/1);}
else{foldchange=($3/$6);}
        {print $1,$2,foldchange;}
}' > foldchange/g3_g5.txt
#3)same type,same time,different treatment:WT_T48_Induced_g14 and WT_T48_Uninduced_g15
paste "group/g14_all_avg.txt" "group/g15_all_avg.txt" | awk -F "\t" '
BEGIN{ OFS = "\t" }
{
if ($6 == 0){foldchange=($3/1);}
else{foldchange=($3/$6);}
        {print $1,$2,foldchange;}
}' > foldchange/g14_g15.txt
