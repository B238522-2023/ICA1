#!/usr/bin/bash
#delete existing Tcongo_genome
rm -rf Tcongo_genome
#copy the data of Trypanosoma congolense IL3000 genome to my ICA1
cp -r /localdisk/data/BPSM/ICA1/Tcongo_genome .


#buid a bowtie2 index
rm -rf *index*
bowtie2-build Tcongo_genome/*fasta.gz Tcongo_genome/Tcongo_genome_index


rm -rf Tco_alignment_sam
mkdir Tco_alignment_sam

for fqfile in fastq/*_1.fq.gz;do 		#fqfile = fastq/Tco-999_1.fq.gz
	name1=$(basename $fqfile) 			#Tco-999_1.fq.gz
	name2=${name1/_1.fq.gz/_2.fq.gz}	#Tco-999_2.fq.gz
	outname=${name1/_1.fq.gz/.sam}		#Tco-999.sam

	bowtie2 -x Tcongo_genome/Tcongo_genome_index -1 fastq/"$name1"  -2 fastq/"$name2"  -S Tco_alignment_sam/"$outname"
	#echo "1" #debugging
done
