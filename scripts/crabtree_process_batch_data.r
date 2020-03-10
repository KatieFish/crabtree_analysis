#!/usr/bin/env Rscript

#last edited 1-13-19 KJF


source("~/Desktop/crabtree_analysis/scripts/percent_yield.R")
source("~/Desktop/crabtree_analysis/scripts/populate_data_with_percent_yield.R")

rep1<-read.csv("./rep1.csv", header=FALSE, stringsAsFactors=FALSE)

       ndf<- rep1
       
       ndf<-ndf[-3]
       
       
       colnames(ndf)<-c("name", "barcode", "Glucose Avg(g/L)", "Xylose Avg(g/L)", "Pyruvate Avg(g/L)", "Xylitol Avg(g/L)", "Succinate Avg(g/L)", "Lactate Avg(g/L)", "Glycerol Avg(g/L)", "Formate Avg(g/L)", "Acetate Avg(g/L)", "Ethanol Avg(g/L)", "Cellobiose Avg(g/L)")
       
       ########## finding glucose consumed and percent yeild etoh
       ndf<-populate_data_with_percent_yield(ndf)
       ndf<-ndf[-1]
       write.table(ndf, "processed_batch_data.tsv", sep="\t")
       