#!/usr/bin/bash
#copy the bed file to ICA1
rm -rf TriTrypDB-46_TcongolenseIL3000_2019.bed
cp -r /localdisk/data/BPSM/ICA1/TriTrypDB-46_TcongolenseIL3000_2019.bed .

#generate counts data
for bamfile in Tco_sort/*.bam;do
	inputfile=${bamfile}
	bedtools multicov -bams "$inputfile" -bed TriTrypDB-46_TcongolenseIL3000_2019.bed
 

done 
