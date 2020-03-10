

tube_flask_difference<-function(masterdf_results){
  df<-masterdf_results
  df$tube_PC_less_flask_PC<-NA
  strains<-as.vector(na.omit(df$strain.int))
  for (i in 1:length(strains)){
    strdat<-df[which(df$strain.int==strains[i]), ]
    tube<-strdat$Percent_yield[which(strdat$condition=="t")]
    flask<-strdat$Percent_yield[which(strdat$condition=="f")]
    df$tube_PC_less_flask_PC[which(df$strain.int==strains[i])]<-tube-flask
  }
return(df)
}