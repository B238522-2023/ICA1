#!/usr/bin/bash
rm -rf Tco_sort/*_average.txt
#cut the genename,gene expression and count field to a new file
for file in Tco_sort/*.txt;do
	output=${file/.txt/_average.txt}
	input=$(cut -f 4,5,6 $file | uniq -c |sort -k1,1nr)
	average=$(cut -f6 $file | awk '{sum+=$1} END {print "Average=" sum/NR}')
	echo -e "###The average of the count is:$average\t$input" >> $output
done
