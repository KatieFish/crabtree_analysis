
#function last modified 1-13-20
#purpose is to populate raw dataframes with glucose consumed, and percent yeild
populate_data_with_percent_yield<- function(individual_batch_df){
df<-individual_batch_df
gluc_col<- which(colnames(df)=="Glucose Avg(g/L)")
etoh_col<-which(colnames(df)=="Ethanol Avg(g/L)")
blank<- which(grepl("BL", df$name))
#calculate glucose consumed from blank
df$Glucose_consumed<- df[blank[1], gluc_col]-df[,gluc_col]
df$Percent_glucose_consumed<-(df$Glucose_consumed/df[blank[1], gluc_col])*100
df$Percent_yield<- NA
  for (i in 1:nrow(df)){
    df$Percent_yield[i]<-percent_yield(df$Glucose_consumed[i], df[i,etoh_col])
  }
df$Blank_glucose<-df[blank[1], gluc_col]
return(df)
}

