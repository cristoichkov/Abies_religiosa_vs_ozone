# Barplot abundance per sample 
# Septiembre 2019
# Verónica Reyes

# Plotear
library(ggplot2)
library(reshape2)

#Load file
metabolites<-read.delim("../../metadata/calculate_relative_abs.txt")

# TODAS

metabolites_mean <- aggregate(metabolitos3[,8:15], by=list(Factores=metabolitos3$`C-A-T`), FUN=mean) 
metabolites_sd <- aggregate(metabolitos3[,8:15], by=list(Factores=metabolitos3$`C-A-T`), FUN=sd) 
df_mean <- melt(metabolites_mean, id.vars=c("Factores"), variable.name = "metabolito", value.name="value")
df_sd <- melt(metabolites_sd, id.vars=c("Factores"), variable.name = "metabolito", value.name="value")


limits <- aes(ymax = df_mean[,"value"] + df_sd[,"value"], ymin=df_mean[,"value"] - df_sd[,"value"])

p <- ggplot(df_mean, aes(metabolito, value, fill = Factores)) + 
  geom_bar(position="dodge", stat="identity") + geom_errorbar(limits, position="dodge")
print(p) 

p <- ggplot(df_mean, aes(metabolito, value)) + geom_bar(aes(fill = Factores), stat="identity") + 
  facet_wrap(~Factores, ncol=1) + geom_errorbar(limits, position="dodge")
print(p) 

p + coord_flip() + facet_wrap(~ Factores)

#SS
levels(df_mean$Factores)
levels(df_mean$Factores)<- c("Contingencia Dañada 2015","Concentración moderada Dañada 2015",
                             "Contingencia Dañada 2016","Concentración moderada Dañada 2016",
                             "Contingencia Sana 2015","Concentración moderada Sana 2015",
                             "Contingencia Sana 2016","Concentración moderada Sana 2016")


metabolitos4<-data.frame(metabolitos3)[1:20,]

metabolites_mean <- aggregate(metabolitos4[,8:15], by=list(Factores=metabolitos4$C.A.T), FUN=mean) 
metabolites_sd <- aggregate(metabolitos4[,8:15], by=list(Factores=metabolitos4$C.A.T), FUN=sd) 
df_mean <- melt(metabolites_mean, id.vars=c("Factores"), variable.name = "metabolito", value.name="value")
df_sd <- melt(metabolites_sd, id.vars=c("Factores"), variable.name = "metabolito", value.name="value")


limits <- aes(ymax = df_mean[,"value"] + df_sd[,"value"], ymin=df_mean[,"value"] - df_sd[,"value"])

p <- ggplot(df_mean, aes(metabolito, value, fill = Factores)) + 
  geom_bar(position="dodge", stat="identity") + geom_errorbar(limits, position="dodge")
print(p) 

p <- ggplot(df_mean, aes(metabolito, value)) + geom_bar(aes(fill = Factores), stat="identity") + 
  facet_wrap(~Factores, ncol=1) + geom_errorbar(limits, position="dodge")
print(p) 

p + coord_flip() + facet_wrap(~ Factores) + 
  scale_fill_manual(breaks = c("Concentración moderada Dañada 2015", "Concentración moderada Dañada 2016",
                               "Concentración moderada Sana 2015", "Concentración moderada Sana 2016"),
                    values= c( "#c6003a", "#e98382", "#00901e","#b1e787"))

#CONTINGENCIA

metabolitos4<-data.frame(metabolitos3)[21:40,]

metabolites_mean <- aggregate(metabolitos4[,8:15], by=list(Factores=metabolitos4$C.A.T), FUN=mean) 
metabolites_sd <- aggregate(metabolitos4[,8:15], by=list(Factores=metabolitos4$C.A.T), FUN=sd) 
df_mean <- melt(metabolites_mean, id.vars=c("Factores"), variable.name = "metabolito", value.name="value")
df_sd <- melt(metabolites_sd, id.vars=c("Factores"), variable.name = "metabolito", value.name="value")


limits <- aes(ymax = df_mean[,"value"] + df_sd[,"value"], ymin=df_mean[,"value"] - df_sd[,"value"])

p <- ggplot(df_mean, aes(metabolito, value, fill = Factores)) + 
  geom_bar(position="dodge", stat="identity") + geom_errorbar(limits, position="dodge")
print(p) 

p <- ggplot(df_mean, aes(metabolito, value)) + geom_bar(aes(fill = Factores), stat="identity") + 
  facet_wrap(~Factores, ncol=1) + geom_errorbar(limits, position="dodge")
print(p) 
p + coord_flip() + facet_wrap(~ Factores)+ 
  scale_fill_manual(breaks = c("Concentración moderada Dañada 2015", "Concentración moderada Dañada 2016",
                               "Concentración moderada Sana 2015", "Concentración moderada Sana 2016"),
                    values= c( "#c6003a", "#e98382", "#00901e","#b1e787"))



