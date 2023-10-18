#delete existing Tcongo_genome
rm -rf Tcongo_genome
#copy the data of Trypanosoma congolense IL3000 genome to my ICA1
cp -r /localdisk/data/BPSM/ICA1/Tcongo_genome .

#decompress the file into its present directory
gunzip Tcongo_genome/TriTrypDB-46_TcongolenseIL3000_2019_Genome.fasta.gz -dfq

rm -rf Tco_1_fastqc
mkdir -p Tco_1_fastqc

rm -rf Tco_2_fastqc
mkdir -p Tco_2_fastqc

mv fastqc_unzipped/*_1_fastqc Tco_1_fastqc/
mv fastqc_unzipped/*_2_fastqc Tco_2_fastqc/
#buid a bowtie2 index file
rm -rf *.bt2
bowtie2-build Tcongo_genome/TriTrypDB-46_TcongolenseIL3000_2019_Genome.fasta TriTrypDB-46_TcongolenseIL3000_2019_Genome


#using bowtie2 to get "SAM" format output
bowtie2 -p 6 -3 5 --local -x TriTrypDB-46_TcongolenseIL3000_2019_Genome -1 Tco_1_fastqc/*_1_fastqc -2 Tco_2_fastqc/*_2_fastqc -S example.sam
#change the format into "BAM"
samtools sort example.sam > example.bam
