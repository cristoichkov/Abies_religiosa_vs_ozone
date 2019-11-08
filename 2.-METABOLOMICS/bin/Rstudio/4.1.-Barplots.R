# Barplot abundance per sample
# Septiembre 2019
# Verónica Reyes

# Load data

metabolites<-read.delim("../../metadata/calculate_relative_abs.txt")

# Plotear
library(ggplot2)
library(reshape2)

metabolites_mean <- aggregate(metabolites[,8:15], by=list(Factores=metabolites$C.A.T), FUN=mean)
metabolites_sd <- aggregate(metabolites[,8:15], by=list(Factores=metabolites$C.A.T), FUN=sd)
df_mean <- melt(metabolites_mean, id.vars=c("Factores"), variable.name = "metabolito", value.name="value")
df_sd <- melt(metabolites_sd, id.vars=c("Factores"), variable.name = "metabolito", value.name="value")


#SS
levels(df_mean$Factores)
levels(df_mean$Factores)<- c("Contingencia Dañada 2015","Concentración moderada Dañada 2015",
                             "Contingencia Dañada 2016","Concentración moderada Dañada 2016",
                             "Contingencia Sana 2015","Concentración moderada Sana 2015",
                             "Contingencia Sana 2016","Concentración moderada Sana 2016")


metabolites4<-data.frame(metabolites)[1:20,]

metabolites_mean <- aggregate(metabolites4[,8:15], by=list(Factores=metabolites4$C.A.T), FUN=mean)
metabolites_sd <- aggregate(metabolites4[,8:15], by=list(Factores=metabolites4$C.A.T), FUN=sd)
df_mean <- melt(metabolites_mean, id.vars=c("Factores"), variable.name = "metabolito", value.name="value")
df_sd <- melt(metabolites_sd, id.vars=c("Factores"), variable.name = "metabolito", value.name="value")


limits <- aes(ymax = df_mean[,"value"] + df_sd[,"value"], ymin=df_mean[,"value"] - df_sd[,"value"])

p <- ggplot(df_mean, aes(metabolito, value, fill = Factores)) +
  geom_bar(position="dodge", stat="identity") + geom_errorbar(limits, position="dodge")
print(p)
p + coord_flip() + facet_wrap(~ Factores) +
  scale_fill_manual(breaks = c("Concentración moderada Dañada 2015", "Concentración moderada Dañada 2016",
                               "Concentración moderada Sana 2015", "Concentración moderada Sana 2016"),
                    values= c( "#c6003a", "#e98382", "#00901e","#b1e787"))+
  scale_x_discrete (labels = c('beta.pinene' = expression(beta~'-Pineno'),
                               'L.alfa.bornyl.acetate' = expression('L-'~ alpha ~'-Acetato de Bornilo'),
                               'beta.Caryophyllene.oxide'= expression(beta~'-Óxido de Cariofileno'),
                               'alfa.Caryophyllene' = expression(alpha~'-Cariofileno'),
                               'beta.Cubebene'= expression(beta~'-Cubebeno'),
                               'alfa.Cubenene'= expression(alpha~'-Cubeneno'),
                               'delta.Cadinene' = expression(delta~'-Cadineno'),
                               'alfa.Muurolene' = expression(alpha~'-Muuroleno')))
ggsave("../../outputs/4.1_barplot_images_SS.png")

#CONTINGENCIA

metabolites4<-data.frame(metabolites)[21:40,]

metabolites_mean <- aggregate(metabolites4[,8:15], by=list(Factores=metabolites4$C.A.T), FUN=mean)
metabolites_sd <- aggregate(metabolites4[,8:15], by=list(Factores=metabolites4$C.A.T), FUN=sd)
df_mean <- melt(metabolites_mean, id.vars=c("Factores"), variable.name = "metabolito", value.name="value")
df_sd <- melt(metabolites_sd, id.vars=c("Factores"), variable.name = "metabolito", value.name="value")


limits <- aes(ymax = df_mean[,"value"] + df_sd[,"value"], ymin=df_mean[,"value"] - df_sd[,"value"])
p <- ggplot(df_mean, aes(metabolito, value, fill = Factores)) +
  geom_bar(position="dodge", stat="identity") + geom_errorbar(limits, position="dodge")
print(p)
p + coord_flip() + facet_wrap(~ Factores) +
  scale_fill_manual(breaks = c("Concentración moderada Dañada 2015", "Concentración moderada Dañada 2016",
                               "Concentración moderada Sana 2015", "Concentración moderada Sana 2016"),
                    values= c( "#c6003a", "#e98382", "#00901e","#b1e787"))+
  scale_x_discrete (labels = c('beta.pinene' = expression(beta~'-Pineno'),
                                     'L.alfa.bornyl.acetate' = expression('L-'~ alpha ~'-Acetato de Bornilo'),
                                     'beta.Caryophyllene.oxide'= expression(beta~'-Óxido de Cariofileno'),
                                     'alfa.Caryophyllene' = expression(alpha~'-Cariofileno'),
                                     'beta.Cubebene'= expression(beta~'-Cubebeno'),
                                     'alfa.Cubenene'= expression(alpha~'-Cubeneno'),
                                     'delta.Cadinene' = expression(delta~'-Cadineno'),
                                     'alfa.Muurolene' = expression(alpha~'-Muuroleno')))
ggsave("../../outputs/4.1_barplot_images_conti.png")
