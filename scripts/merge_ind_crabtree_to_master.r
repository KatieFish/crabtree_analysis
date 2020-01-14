#!/usr/bin/env Rscript

#last edited 12-13-19 KJF

#read in tables and merge

masterdf<- read.delim("./working_Barcode_master.tsv", header=TRUE, stringsAsFactors=FALSE)
inddf<- read.delim("./processed_batch_data.tsv", header=TRUE, stringsAsFactors=FALSE)

colnames(inddf)[2:ncol(inddf)]<-colnames(masterdf)[6:ncol(masterdf)]

masterdf<-merge(masterdf, inddf, by=c("barcode"), all=TRUE)
for(i in 6:20){
	for (j in 1:nrow(masterdf)){
	if (is.na(masterdf[j,i])){
	masterdf[j,i]<-masterdf[j, i+15]
	}
	}}

masterdf<-masterdf[1:20]

write.table(masterdf, "working_Barcode_master.tsv", sep="\t", quote=FALSE)
