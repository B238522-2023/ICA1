#!/usr/bin/bash
#incase there is already a same ICA1 directory and avoid to execute it for many times
rm -rf fastq
cp -r /localdisk/data/BPSM/ICA1/fastq .

rm -rf fastqc_result
mkdir -p fastqc_result

for file in fastq/*fq.gz;do
	fastqc $file -o fastqc_result
done
