#!/bin/bash

#setting a master dataframe going into script that all
#data will be merged into.
#directory needs to contain crabtree_techrep_avg.r

##12-27-19 I figured out that the first set of data provided in the data catalog 
#is the man of all techreps run. I have modified the scripts to eliminate the 
#averaging, as clearly that has already been done! 

#last updated 1-14-20 - note that the file names change upon each download from glbrc

#copying the master barcode file 
cp Barcode_master_table_crabtree.tsv working_Barcode_master.tsv

for FILE in crabtree_01-06-20_g_L_2020-01-13 JFW_20190916_g_L_2020-01-13 crabtree_01-06-20_g_L_2020-01-13 crabtree_10-21-19_g_L_2020-01-13 crabtree_10-28-19_g_L_2020-01-13 crabtree_10-7-19_g_L_2020-01-13 crabtree_11-05-19_g_L_2020-01-13 crabtree_11-12-19_g_L_2020-01-13 crabtree_11-19-19_g_L_2020-01-13 crabtree_12_09_19_g_L_2020-01-13 crabtree_12_24_19_g_L_2020-01-13 crabtree_12_30_19_g_L_2020-01-13 crabtree_9-24-19_g_L_2020-01-13 crabtree_9-30-19_g_L_2020-01-13 crabtree__10-14-19_g_L_2020-01-13 crabtree_12-16-19_g_L_2020-01-13
do

echo $FILE

cp datacatalog_raw_data/$FILE\.csv ./file.csv
sed -i '' 1d file.csv
#removes 1st line "End products"
sed -i '' 1d file.csv 
#again  - colnames
sed -i '' '/^$/d' file.csv
#removes blank lines
TechRep="$(grep -n "Technical Replicate Summary" file.csv | cut -d: -f 1)"
#gives line number of where Techreps start
rep1end=$(($TechRep - 1)) #where rep 1 ends
#rep2start=$(($TechRep + 2))
#rep2end=$((($TechRep + 2) + (TechRep-2))) 
## finds line numbers of where first and second tech reps begin and end
head -n $rep1end file.csv > rep1.csv #rep 1 as its own file
#sed -n "$rep2start, $rep2end p" datacatalog_raw_data/$FILE\.csv > rep2.csv
#echo "done step 1"
#rscript to average the two replicates and provide 
#pooled std deviation of batch
rscript --vanilla ~/Desktop/crabtree_analysis/scripts/crabtree_process_batch_data.r
#echo "done step 2" 

rscript --vanilla ~/Desktop/crabtree_analysis/scripts/merge_ind_crabtree_to_master.r
#echo $FILE 

done


