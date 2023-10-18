#delete existing Tcongo_genome
rm -rf Tcongo_genome
#copy the data of Trypanosoma congolense IL3000 genome to my ICA1
cp -r /localdisk/data/BPSM/ICA1/Tcongo_genome .

#decompress the file into its present directory
gunzip Tcongo_genome/TriTrypDB-46_TcongolenseIL3000_2019_Genome.fasta.gz -dfq

rm -rf Tco_1_fastq
mkdir -p Tco_1_fastq

rm -rf Tco_2_fastq
mkdir -p Tco_2_fastq

mv fastq/*_1.fq.gz Tco_1_fastq/
mv fastq/*_2.fq.gz Tco_2_fastq/
#buid a bowtie2 index file
rm -rf *.bt2
bowtie2-build Tcongo_genome/TriTrypDB-46_TcongolenseIL3000_2019_Genome.fasta Tco_example_index
