#!/usr/bin/bash
rm -rf group
mkdir -p group

#interate from file group/g1.txt to group/g15.txt 
for i in {1..15};do
        touch group/g"$i"_all.txt
        outfile=group/g"$i"_all.txt
#paste colum6 of the file in same group into a midfile for further execution
        for gi in groupfile/*g"$i".txt ;do
#use midfile to store the combined data temporarily and output the outcome into outfile
                midfile=group/g"$i"_mid.txt
#take content from outfile and combine 6 field, and store the merged data in midfile
                paste $outfile <(cut -f 6 "$gi") > $midfile
                mv $midfile $outfile
        done
done

#generate the average count of the counts data in each group
#drag the first line and store in the variety $num_col
for all_file in group/* ;do
        num_col=$(awk -F '\t' '{print NF}' $all_file | head -1 )
        echo $num_col 
        awk -F "\t" -v nc=$num_col '{
        sum=0;
        for( i = 2 ; i <= nc l; i++) {
          sum += $i;
        }
        avg=sum/nc;
        { print avg }
        }' $all_file > "$all_file"_mid
done
#name the outputfile using the same group-name and paste the colum4 and 5 in the bedfile
for midfile in group/*mid ; do
        outputname=$(basename $midfile .txt_mid)"_avg.txt"
        paste <(cut TriTrypDB-46_TcongolenseIL3000_2019.bed -f 4,5) $midfile > group/$outputname
done
