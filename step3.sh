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

for fqfile in fastq/*_1.fq.gz;do 		
	name1=$(basename $fqfile) 	
	name2=${name1/_1.fq.gz/_2.fq.gz}
	outname=${name1/_1.fq.gz/.sam}		

	bowtie2 -p 6 -x Tcongo_genome/Tcongo_genome_index -1 fastq/"$name1"  -2 fastq/"$name2"  -S Tco_alignment_sam/"$outname"
done

#change the format into "BAM"
rm -rf Tco_alignment_bam
mkdir -p Tco_alignment_bam

for samfile in Tco_alignment_sam/*.sam;do      #Tco-999.sam
	inputname=$(basename $samfile)
	outputname=${inputname/.sam/.bam}
	samtools view -S Tco_alignment_sam/"$inputname" -b -o Tco_alignment_bam/"$outputname"
done
