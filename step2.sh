#!/usr/bin/bash
#count the numbers of theoutputs of fastqc files
echo "the number of the raw sewuence data is：$(ls fastq/*fq.gz | wc -l)"

#remove any existing fastqc_unzipped and make a fastqc_unziiped directory
rm -rf fastqc_unzipped
mkdir -p fastqc_unzipped


#decompress the zipped file of the fastqc_result
for zip_file in fastqc_result/*zip;do
	unzip $zip_file -d fastqc_unzipped
done

#remove any existing directory and make a new one
rm -rf all_the_summary
mkdir -p all_the_summary

#rename the summary.txt using the sequence name and output it to all_the_summary directory
for folder in fastqc_unzipped/*fastqc;do
foldername=$(basename $folder _fastqc) #definate a foldername delete the filename (_fastqc) part
mv $folder/summary.txt all_the_summary/"$foldername"_summary.txt #add the name of every summary.txt with its sequence name and output them to a directory called all_the_summary
done
