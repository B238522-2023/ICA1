#!/usr/bin/bash
#delete existing Tcongo_genome
rm -rf Tcongo_genome
#copy the data of Trypanosoma congolense IL3000 genome to my ICA1
cp -r /localdisk/data/BPSM/ICA1/Tcongo_genome .


#buid a bowtie2 index
rm -rf Tcongo_genome/*index*
bowtie2-build Tcongo_genome/*fasta.gz Tcongo_genome/Tcongo_genome_index


rm -rf Tco_alignment_sam
mkdir Tco_alignment_sam

#align the same-name gene one by one and output as the sam format
for fqfile in fastq/*_1.fq.gz;do 		
	name1=$(basename $fqfile)			
	name2=${name1/_1.fq.gz/_2.fq.gz}	
	outputname=${name1/_1.fq.gz/.sam}	
	bowtie2 -p 6 -x Tcongo_genome/Tcongo_genome_index -1 fastq/"$name1"  -2 fastq/"$name2"  -S Tco_alignment_sam/"$outputname"
done

#change the format into "BAM"
rm -rf Tco_alignment_bam
mkdir -p Tco_alignment_bam

for samfile in Tco_alignment_sam/*.sam;do      #Tco-999.sam
	inputname=$(basename $samfile)
	outputname=${inputname/.sam/.bam}
	samtools view -S Tco_alignment_sam/"$inputname" -b -o Tco_alignment_bam/"$outputname"
done

#check the output bam files
samtools quickcheck Tco_alignment_bam/*.bam 

#sort the bam files and make an index
rm -rf Tco_sort
mkdir -p Tco_sort
for bamfiles in Tco_alignment_bam/*.bam;do
	file=$(basename $bamfiles)
	sortfile=${file/.bam/_sort.bam}
    samtools sort -@ 10 Tco_alignment_bam/"$file" -o Tco_sort/"$sortfile"
    samtools index Tco_sort/"$sortfile"
done
