#!/usr/bin/bash
#remove the fastq incase it is in the directory
rm -rf fastq
#copy the data to my ICA1
cp -r /localdisk/data/BPSM/ICA1/fastq .

#remove fastqc_result to make sure there has no such file before
rm -rf fastqc_result
mkdir -p fastqc_result

#use fastq to uncompress the *fq.gz file and output to fastqc_result
#use for loop to escape the Tco2.ffiles which is not a compressed file 
for file in fastq/*fq.gz;do
	fastqc $file -o fastqc_result
done
