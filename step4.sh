#!/usr/bin/bash
#copy the bed file to ICA1
rm -rf TriTrypDB-46_TcongolenseIL3000_2019.bed
cp -r /localdisk/data/BPSM/ICA1/TriTrypDB-46_TcongolenseIL3000_2019.bed .



#generate the counts data
rm -rf Tco_sort/*.txt
for bamfile in Tco_sort/*.bam;do
output=${bamfile/.bam/*.txt}
bedtools multicov -bams $bamfile -bed TriTrypDB-46_TcongolenseIL3000_2019.bed >> $output 
done 


for file in Tco_sort/*txt;do
