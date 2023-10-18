#!/usr/bin/bash
#delete existing Tcongo_genome
rm -rf Tcongo_genome
#copy the data of Trypanosoma congolense IL3000 genome to my ICA1
cp -r /localdisk/data/BPSM/ICA1/Tcongo_genome .


#buid a bowtie2 index
rm -rf *index*
bowtie2-build Tcongo_genome Tco_example_index


rm -rf Tco_1_fastq
mkdir -p Tco_1_fastq
cp fastq/*_1.fq.gz Tco_1_fastq

rm -rf Tco_2_fastq
mkdir -p Tco_2_fastq
cp fastq/*_2.fq.gz Tco_2_fastq










for example_1_fastq in Tco_1_fastq/*_1.fq.gz;do
example_2_fastq="Tco_2_fastq/*_2.fq.gz"
bowtie2 --end-to-end -p 6 -x Tco_example_index -1 $example_1_fastq -2 $example_2_fastq -S Tco_alignment.sam
done

rm -rf Tco_alignment.sam
mkdir Tco_alignment.sam

for example_1_fastq in Tco_1_fastq/*_1.fq.gz;do
example_2_fastq=${example_1_fastq/_1.fq.gz/_2.fq.gz}
bowtie2 --end-to-end -p 6 -x Tco_example_index -1 $example_1_fastq -2 $example_2_fastq -S Tco_alignment.sam
done


for file in Tco_1_fastq；do
bowtie














#change the format into "BAM"
samtools sort example.sam > example.bam







