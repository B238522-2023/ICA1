#!/usr/bin/bash
#count the numbers of theoutputs of fastqc files
echo "the number of the raw sewuence data is：$(ls fastq/*fq.gz | wc -l)"

#remove any existing assesment files
rm -rf assesment 
mkdir -p assesment

#decompress the zipped file of the fastqc_result
for zip_file in fastqc_result/*zip;do
	unzip $zip_file -d assesment
done
