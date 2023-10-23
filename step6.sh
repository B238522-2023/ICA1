#!/usr/bin/bash
rm -rf foldchange
mkdir -p foldchange

#1)see if doing nothing: Clone1_T0_Uninduced_g1 & WT_T0_Uninduced_g11
#if the count in WT group is 0,then change it into one to calculate
paste "group/g1_all_avg.txt" "group/g11_all_avg.txt" | awk -F "\t" '
BEGIN{ OFS = "\t" }
{
if ($6 == 0){foldchange=($3/1);}
else{foldchange=($3/$6);}
        {print $1,$2,foldchange;}
}' > foldchange/g1_g11.txt
#2)see the effect of time variation: WT_T48_Induced_g14 & WT_T24_Induced_g13
paste "group/g14_all_avg.txt" "group/g13_all_avg.txt" | awk -F "\t" '
BEGIN{ OFS = "\t" }
{
if ($6 == 0){foldchange=($3/1);}
else{foldchange=($3/$6);}
        {print $1,$2,foldchange;}
}' > foldchange/g14_g13.txt
#3)see the effect of treatment difference:WT_T48_Induced_g14 and WT_T48_Uninduced_g15
paste "group/g14_all_avg.txt" "group/g15_all_avg.txt" | awk -F "\t" '
BEGIN{ OFS = "\t" }
{
if ($6 == 0){foldchange=($3/1);}
else{foldchange=($3/$6);}
        {print $1,$2,foldchange;}
}' > foldchange/g14_g15.txt
#4)see the effect of type difference: CL1_T48_Induced_g4 & WT_T48_Induced_g14
paste "group/g4_all_avg.txt" "group/g14_all_avg.txt" | awk -F "\t" '
BEGIN{ OFS = "\t" }
{
if ($6 == 0){foldchange=($3/1);}
else{foldchange=($3/$6);}
        {print $1,$2,foldchange;}
}' > foldchange/g4_g14.txt
#5)see the difference between RNAi (Clone1 and Clone2): CL1_T24_Induced_g2 & CL2_T24_Induced_g8
paste "group/g2_all_avg.txt" "group/g8_all_avg.txt" | awk -F "\t" '
BEGIN{ OFS = "\t" }
{
if ($6 == 0){foldchange=($3/1);}
else{foldchange=($3/$6);}
        {print $1,$2,foldchange;}
}' > foldchange/g2_g8.txt
