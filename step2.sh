#extract the zipped file of the fastqc_result
for zip_file in fastqc_result/*zip;do
	unzip $zip_file -d fastqc_unzip
done


#remove any existing directory and make a new one
rm -rf all_the_summary
mkdir -p all_the_summary

#rename the summary.txt using the sequence name and output it to all_the_summary directory
for folder in fastqc_unzipped/*fastqc;do
	foldername=$(basename $folder _fastqc) #definate a foldername delete the filename (_fastqc) part
mv $folder/summary.txt all_the_summary/"$foldername"_summary.txt #add the name of every summary.txt with its sequence name and output them to a directory called all_the_summary
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
