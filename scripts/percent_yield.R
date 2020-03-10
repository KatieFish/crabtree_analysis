
percent_yield<-function(grams_glucose_consumed, grams_etoh_produced){
  gMol_glucose <- 180.18
  gMol_EtOH <- 46.08
  mols_gluc<- grams_glucose_consumed/gMol_glucose
  th_yeild<- (mols_gluc*2)*gMol_EtOH
  percent_yeild<- (grams_etoh_produced/th_yeild)*100
  return(percent_yeild)
}