#!/usr/bin/bash
#count the numbers of theoutputs of fastqc files
echo "the number of the raw sequence data is：$(ls fastq/*fq.gz | wc -l)"

#remove any existing fastqc_unzipped and make a fastqc_unziiped directory
rm -rf fastqc_unzip
mkdir -p fastqc_unzip


#extract the zipped file of the fastqc_result
for zip_file in fastqc_result/*zip;do
	unzip $zip_file -d fastqc_unzip
done


#remove any existing directory and make a new one
rm -rf all_the_summary
mkdir -p all_the_summary

#rename the summary.txt using the sequence name and output it to all_the_summary directory
for file in fastqc_unzip/*fastqc;do
	outputfile=${file##*/}
	outputfile=${outputfile/_fastqc/_summary.txt} 
	mkdir -p all_the_summary
	mv "$file/summary.txt" "all_the_summary/$outputfile"
done


#asses the quality of summary.txt,echo the number of 'PASS' of each file
count=0
for file in all_the_summary/*.txt
do
	count=$(grep -c "PASS" $file)
if test $count -gt 7
	then
	echo -e "The number of PASS in $file is $count,and the quality of raw sequence data is good"
	fi
done 
