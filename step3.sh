#delete existing Tcongo_genome
rm -rf Tcongo_genome
#copy the data of Trypanosoma congolense IL3000 genome to my ICA1
cp -r /localdisk/data/BPSM/ICA1/Tcongo_genome .

#decompress the file into its present directory
gunzip Tcongo_genome/TriTrypDB-46_TcongolenseIL3000_2019_Genome.fasta.gz -dfq
