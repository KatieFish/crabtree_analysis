

library(plyr)
dat<- df[which(df$Percent_glucose_consumed>=50), ]
flaskdat<-dat[which(dat$condition=="f"), ]
tubedat<-dat[which(dat$condition=="t"), ]
bothdat<-df[which(df$Percent_glucose_consumed>=50), ]
    x<-count(bothdat$strain.int)
    notboth<-x$x[which(x$freq==1)]
    bothdat<-bothdat[-which(bothdat$strain.int %in% notboth), ]
    bothdatflaskfermenters<- bothdat$strain.int[which(bothdat$condition=="f" & bothdat$Percent_yield>5)]
    bothdatflaskferm<- bothdat[which(bothdat$strain.int %in% bothdatflaskfermenters), ]
    bothdattubefermenters<- bothdat[which(bothdat$condition=="t"), ]
    bothdattubeferm<- bothdattubefermenters[which(bothdattubefermenters$Percent_yield>10), ]
    bothdat<-tube_flask_difference(bothdat)
    bothdat<-bothdat[c(5,21)]
    bothdatflaskferm<-bothdatflaskferm[c(5,21)]
    bothdat<-unique(bothdat)
    bothdatflaskferm<-unique(bothdatflaskferm)
    bothdattubeferm<-bothdattubeferm[c(5,21)]
    bothdattubeferm<-unique(bothdattubeferm)

  tubeflaskclustdf<- bothdat[c(5,4,19)]


#histogram of percent yeild for TUBE cultures that CONSUMED AT LEAST HALF OF AVAILABLE GLUCOSE
library(ggplot2)
a<-ggplot(tubedat, aes(Percent_yield))+
  geom_histogram(fill="skyblue4", col="grey")+
  ylab("count")+
  xlab("EtOH % yield")+
  ggtitle("culture tube \n n= 212 spp.")+
  ylim(0,110)+
  #xlim(-10,80)+
  theme_bw()

#histogram of percent yeild for FLASK cultures that CONSUMED AT LEAST HALF OF AVAILABLE GLUCOSEggplot(dat, aes(Percent_yield))+
b<-ggplot(flaskdat, aes(Percent_yield))+  
  geom_histogram(fill="firebrick3", col="grey", bins=50)+
  ylab("count")+
  xlab("EtOH % yield")+
  ggtitle("baffled flask \n n=225 spp.")+
  ylim(0,110)+
  #xlim(-10,90)+
  theme_bw()

#histogram of TUBE PY MINUS FLASK PY for cultures that CONSUMED AT LEAST HALF OF AVAILABLE GLUCOSE IN BOTH CONDITIONS
c<-ggplot(bothdat, aes(tube_PC_less_flask_PC))+  
  geom_histogram(fill="tan2", col="grey", bins=20)+
  ylab("count")+
  xlab("tube EtOH % yield minus flask EtOH % yield")+
  ggtitle(expression(paste("difference in EtOH % yield in low vs high ", O[2], "\n n= 197 spp.")))+
  #ylim(0,20)+
  #xlim(-35,80)+
  theme_bw()

library(gridExtra)
grid.arrange(arrangeGrob(a, b, ncol=2), c , nrow=2)



bothdat<- bothdat[order(bothdat$tube_PC_less_flask_PC), ]
bothdat$strain.int<- reorder(bothdat$strain, bothdat$tube_PC_less_flask_PC)
which(levels(bothdat$strain.int)=="10")-> Scer1
which(levels(bothdat$strain.int)=="11")-> Klac1
d<-ggplot(bothdat, aes(x=strain.int, y=tube_PC_less_flask_PC))+
  geom_col(fill="tan", col="grey")+
  xlab("strain")+
  ylab("tube EtOH % yield minus flask EtOH % yield")+
  theme_bw()+
  ggtitle("Difference in EtOH production between conditions \n all 197 spp. that consumed >50% glucose") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 3))+
  geom_vline(aes(xintercept=Scer1))+
  geom_text(aes(fontface=3, x=Scer1-2, label="S. cerevisiae", y=-15), colour="black", angle=90, size=4)+
  geom_vline(aes(xintercept=Klac1))+
  geom_text(aes(fontface=3, x=Klac1-2, label="K. lactis", y=-15), colour="black", angle=90, size=4)+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())


bothdattubeferm<- bothdattubeferm[order(bothdattubeferm$tube_PC_less_flask_PC), ]
bothdattubeferm$strain.int<- reorder(bothdattubeferm$strain, bothdattubeferm$tube_PC_less_flask_PC)
which(levels(bothdattubeferm$strain.int)=="10")-> Scer
which(levels(bothdattubeferm$strain.int)=="11")-> Klac
e<- ggplot(bothdattubeferm, aes(x=strain.int, y=tube_PC_less_flask_PC))+
  geom_col(fill="tan", col="grey")+
  xlab("strain")+
  ylab("tube EtOH % yield minus flask EtOH % yield")+
  theme_bw()+
  ggtitle("Difference in EtOH production between conditions
all 122 spp. that consumed >50% glucose in both conditions
and produced >10% yield EtOH in tubes") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 3))+
  geom_vline(aes(xintercept=Scer))+
  geom_text(aes(fontface=3, x=Scer-2, label="S. cerevisiae", y=-15), colour="black", angle=90, size=4)+
  geom_vline(aes(xintercept=Klac))+
  geom_text(aes(fontface=3, x=Klac-2, label="K. lactis", y=-15), colour="black", angle=90, size=4)+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())

grid.arrange(d, e, nrow=2)


plotJenks(bothdattubeferm$tube_PC_less_flask_PC, n=5, brks.cex=.70, top.margin=10, dist=5)
legend(x=41, y=80, legend="facultative fermenters", cex=.75)
legend(x=20, y=80, legend="respiro-fermenters", cex=.75)
legend(x=8, y=20, legend="quasi-crabtree +", cex=.75)
legend(x=-18, y=20, legend="robustly crabtree +", cex=.75)
legend(x=-32, y=80, legend="oxidative fermenters", cex=.75)
quartz.save("jenks_breaks_1-14-20.pdf", type="pdf")
