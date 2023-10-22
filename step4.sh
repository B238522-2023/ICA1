#!/usr/bin/bash
#copy the bed file to ICA1
rm -rf TriTrypDB-46_TcongolenseIL3000_2019.bed
cp -r /localdisk/data/BPSM/ICA1/TriTrypDB-46_TcongolenseIL3000_2019.bed .

#generate the counts data
rm -rf Tco_sort/*.txt
for bamfile in Tco_sort/*.bam;do
	output=${bamfile/.bam/.txt}
	bedtools multicov -bams $bamfile -bed TriTrypDB-46_TcongolenseIL3000_2019.bed >> $output 
done 

rm -rf groupfile
mkdir groupfile
#sort the gene in txt for further grouping
cat fastq/Tco2.fqfiles | grep -v "SampleName" | sort -k2,2 -k4,4n -k5,5 | cut -f 1,2,4,5 >> groupfile/groupfile.txt

rm -rf groupfile/groupfile.txt
#grouping the genes in Tco_sort directory according to their type,name,time,treatment
while read -r line;do
	SampleName=$(echo "$line" | awk -F'\t' '{print$1}')
	SampleType=$(echo "$line" | awk -F'\t' '{print$2}')
	Time=$(echo "$line" | awk -F'\t' '{print$4}')
	Treatment=$(echo "$line" | awk -F'\t' '{print$5}')
	name=${SampleName/Tco/}
	echo $SampleType $Time $Treatment $SampleName $name

	if [[ "$SampleType" == "Clone1" && "$Time" == "0" && "$Treatment" == "Uninduced" ]];then
		cp Tco_sort/Tco-"$name"_sort.txt groupfile/Tco-"$name"_CL1_T0_Uninduced_g1.txt
		echo 1
	fi

	if [[ "$SampleType" == "Clone1" && "$Time" == "24" && "$Treatment" == "Induced" ]];then
		cp Tco_sort/Tco-"$name"_sort.txt groupfile/Tco-"$name"_CL1_T24_Induced_g2.txt
		echo 2
	fi

	if [[ "$SampleType" == "Clone1" && "$Time" == "24" && "$Treatment" == "Uninduced" ]];then
		cp Tco_sort/Tco-"$name"_sort.txt groupfile/Tco-"$name"_CL1_T24_Uninduced_g3.txt
		echo 3
	fi 
	
	if [[ "$SampleType" == "Clone1" && "$Time" == "48" && "$Treatment" == "Induced" ]];then
		cp Tco_sort/Tco-"$name"_sort.txt groupfile/Tco-"$name"_CL1_T48_Induced_g4.txt
		echo 4
	fi 

	if [[ "$SampleType" == "Clone1" && "$Time" == "48" && "$Treatment" == "Uninduced" ]];then
		cp Tco_sort/Tco-"$name"_sort.txt groupfile/Tco-"$name"_CL1_T48_Uninduced_g5.txt
		echo 5
	fi 

	if [[ "$SampleType" == "Clone2" && "$Time" == "0" && "$Treatment" == "Uninduced" ]];then
		cp Tco_sort/Tco-"$name"_sort.txt groupfile/Tco-"$name"_CL2_T0_Uninduced_g6.txt
		echo 6
	fi 

	if [[ "$SampleType" == "Clone2" && "$Time" == "24" && "$Treatment" == "Uninduced" ]];then
		cp Tco_sort/Tco-"$name"_sort.txt groupfile/Tco-"$name"_CL2_T24_Uninduced_g7.txt
		echo 7
	fi 

	if [[ "$SampleType" == "Clone2" && "$Time" == "24" && "$Treatment" == "Induced" ]];then
		cp Tco_sort/Tco-"$name"_sort.txt groupfile/Tco-"$name"_CL2_T24_Induced_g8.txt
		echo 8
	fi 

	if [[ "$SampleType" == "Clone2" && "$Time" == "48" && "$Treatment" == "Induced" ]];then
		cp Tco_sort/Tco-"$name"_sort.txt groupfile/Tco-"$name"_CL2_T48_Induced_g9.txt
		echo 9
	fi

	if [[ "$SampleType" == "Clone2" && "$Time" == "48" && "$Treatment" == "Uninduced" ]];then
		cp Tco_sort/Tco-"$name"_sort.txt groupfile/Tco-"$name"_CL2_T48_Uninduced_g10.txt
		echo 10
	fi
	
	if [[ "$SampleType" == "WT" && "$Time" == "0" && "$Treatment" == "Uninduced" ]];then
		cp Tco_sort/Tco-"$name"_sort.txt groupfile/Tco-"$name"_WT_T0_Uninduced_g11.txt
		echo 11
	fi

	if [[ "$SampleType" == "WT" && "$Time" == "24" && "$Treatment" == "Uninduced" ]];then
		cp Tco_sort/Tco-"$name"_sort.txt groupfile/Tco-"$name"_WT_T24_Uninduced_g12.txt
		echo 12
	fi

	if [[ "$SampleType" == "WT" && "$Time" == "24" && "$Treatment" == "Induced" ]];then
		cp Tco_sort/Tco-"$name"_sort.txt groupfile/Tco-"$name"_WT_T24_Induced_g13.txt
		echo 13
	fi

	if [[ "$SampleType" == "WT" && "$Time" == "48" && "$Treatment" == "Induced" ]];then
		cp Tco_sort/Tco-"$name"_sort.txt groupfile/Tco-"$name"_WT_T48_Induced_g14.txt
		echo 14
	fi

	if [[ "$SampleType" == "WT" && "$Time" == "48" && "$Treatment" == "Uninduced" ]];then
		cp Tco_sort/Tco-"$name"_sort.txt groupfile/Tco-"$name"_WT_T48_Uninduced_g15.txt
		echo 15
	fi

done < fastq/Tco2.fqfiles
