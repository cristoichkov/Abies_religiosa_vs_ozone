# Barplot abundance per sample 
# Septiembre 2019
# Verónica Reyes

# Load data
metabolites<- read.csv("../../data/Tablas_datos/metabolitos_Tesis_Vero.csv")

#Chose cols to analisys
metabolites2<- data.frame(metabolites$C.A.T,metabolites$C.A, metabolites$Temporada,metabolites$Condicion, metabolites$A.expo, metabolites$Muestra, metabolites$mmet)

colnames(metabolites2)<- c("C.A.T", "C.A", "Temporada",
                           "Condicion", "A.expo", "Muestra", "mmet") 

# Calcular X1
metabolites2$x1<-(metabolites$microlitros.de.estandar*metabolites$miligramos/metabolites$microlitros)*2/1000


#Calcular X2,X3,X4,X5 para cada metabolito

# beta.pinene
metabolites2$X2_beta.pinene <- metabolites2$x1*metabolites$beta.pinene/metabolites$P.Area.estandar 
metabolites2$X3_beta.pinene <- metabolites2$X2_beta.pinene*metabolites$microlitros.de.metabolitos/metabolites$microlitros.de.inyeccion 
metabolites2$X4_beta.pinene <- metabolites2$X3_beta.pinene*100/metabolites$Peso.acicula.gramos
metabolites2$X5_beta.pinene <- metabolites2$X4_beta.pinene*1000
# L.alfa.bornyl.acetate
metabolites2$X2_L.alfa.bornyl.acetate <- metabolites2$x1*metabolites$L.alfa.bornyl.acetate/metabolites$P.Area.estandar 
metabolites2$X3_L.alfa.bornyl.acetate <- metabolites2$X2_L.alfa.bornyl.acetate*metabolites$microlitros.de.metabolitos/metabolites$microlitros.de.inyeccion 
metabolites2$X4_L.alfa.bornyl.acetate <- metabolites2$X3_L.alfa.bornyl.acetate*100/metabolites$Peso.acicula.gramos
metabolites2$X5_L.alfa.bornyl.acetate <- metabolites2$X4_L.alfa.bornyl.acetate*1000
# beta.Caryophyllene.oxide
metabolites2$X2_beta.Caryophyllene.oxide <- metabolites2$x1*metabolites$beta.Caryophyllene.oxide/metabolites$P.Area.estandar 
metabolites2$X3_beta.Caryophyllene.oxide <- metabolites2$X2_beta.Caryophyllene.oxide*metabolites$microlitros.de.metabolitos/metabolites$microlitros.de.inyeccion 
metabolites2$X4_beta.Caryophyllene.oxide <- metabolites2$X3_beta.Caryophyllene.oxide*100/metabolites$Peso.acicula.gramos
metabolites2$X5_beta.Caryophyllene.oxide <- metabolites2$X4_beta.Caryophyllene.oxide*1000
#  alfa.Caryophyllene
metabolites2$X2_alfa.Caryophyllene <- metabolites2$x1*metabolites$alfa.Caryophyllene/metabolites$P.Area.estandar 
metabolites2$X3_alfa.Caryophyllene <- metabolites2$X2_alfa.Caryophyllene*metabolites$microlitros.de.metabolitos/metabolites$microlitros.de.inyeccion 
metabolites2$X4_alfa.Caryophyllene <- metabolites2$X3_alfa.Caryophyllene*100/metabolites$Peso.acicula.gramos
metabolites2$X5_alfa.Caryophyllene <- metabolites2$X4_alfa.Caryophyllene*1000
# beta.Cubebene
metabolites2$X2_beta.Cubebene <- metabolites2$x1*metabolites$beta.Cubebene/metabolites$P.Area.estandar 
metabolites2$X3_beta.Cubebene <- metabolites2$X2_beta.Cubebene*metabolites$microlitros.de.metabolitos/metabolites$microlitros.de.inyeccion 
metabolites2$X4_beta.Cubebene <- metabolites2$X3_beta.Cubebene*100/metabolites$Peso.acicula.gramos
metabolites2$X5_beta.Cubebene <- metabolites2$X4_beta.Cubebene*1000
# alfa.Cubenene
metabolites2$X2_alfa.Cubenene  <- metabolites2$x1*metabolites$alfa.Cubenene/metabolites$P.Area.estandar 
metabolites2$X3_alfa.Cubenene  <- metabolites2$X2_alfa.Cubenene *metabolites$microlitros.de.metabolitos/metabolites$microlitros.de.inyeccion 
metabolites2$X4_alfa.Cubenene  <- metabolites2$X3_alfa.Cubenene *100/metabolites$Peso.acicula.gramos
metabolites2$X5_alfa.Cubenene  <- metabolites2$X4_alfa.Cubenene *1000
# delta.Cadinene
metabolites2$X2_delta.Cadinene <- metabolites2$x1*metabolites$delta.Cadinene/metabolites$P.Area.estandar 
metabolites2$X3_delta.Cadinene <- metabolites2$X2_delta.Cadinene*metabolites$microlitros.de.metabolitos/metabolites$microlitros.de.inyeccion 
metabolites2$X4_delta.Cadinene <- metabolites2$X3_delta.Cadinene*100/metabolites$Peso.acicula.gramos
metabolites2$X5_delta.Cadinene <- metabolites2$X4_delta.Cadinene*1000
# alfa.Muurolene
metabolites2$X2_alfa.Muurolene <- metabolites2$x1*metabolites$alfa.Muurolene/metabolites$P.Area.estandar 
metabolites2$X3_alfa.Muurolene <- metabolites2$X2_alfa.Muurolene*metabolites$microlitros.de.metabolitos/metabolites$microlitros.de.inyeccion 
metabolites2$X4_alfa.Muurolene <- metabolites2$X3_alfa.Muurolene*100/metabolites$Peso.acicula.gramos
metabolites2$X5_alfa.Muurolene <- metabolites2$X4_alfa.Muurolene*1000

# Data frame con datos a partir de la [] del estandar 

metabolites3<- data.frame(metabolites2$C.A.T,metabolites2$C.A,metabolites2$Temporada,metabolites2$Condicion,metabolites2$A.expo, metabolites2$Muestra, metabolites2$mmet,
                          metabolites2$X4_beta.pinene, metabolites2$X4_L.alfa.bornyl.acetate , metabolites2$X4_beta.Caryophyllene.oxide, metabolites2$X4_alfa.Caryophyllene,
                          metabolites2$X4_beta.Cubebene,metabolites2$X4_alfa.Cubenene,metabolites2$X4_delta.Cadinene,metabolites2$X4_alfa.Muurolene)


# Cambiar nombres a las columnas

colnames(metabolites3)<- c("C-A-T","C-A","Temporada","Condicion", "A.exposicion", "Muestra","n.GC-MS",
                           "beta.pinene","L.alfa.bornyl.acetate","beta.Caryophyllene.oxide","alfa.Caryophyllene",
                           "beta.Cubebene","alfa.Cubenene","delta.Cadinene","alfa.Muurolene")


# Plotear
library(ggplot2)
library(reshape2)

metabolites_mean <- aggregate(metabolites3[,8:15], by=list(Factores=metabolites3$`C-A-T`), FUN=mean) 
metabolites_sd <- aggregate(metabolites3[,8:15], by=list(Factores=metabolites3$`C-A-T`), FUN=sd) 
df_mean <- melt(metabolites_mean, id.vars=c("Factores"), variable.name = "metabolito", value.name="value")
df_sd <- melt(metabolites_sd, id.vars=c("Factores"), variable.name = "metabolito", value.name="value")


#SS
levels(df_mean$Factores)
levels(df_mean$Factores)<- c("Contingencia Dañada 2015","Concentración moderada Dañada 2015",
                             "Contingencia Dañada 2016","Concentración moderada Dañada 2016",
                             "Contingencia Sana 2015","Concentración moderada Sana 2015",
                             "Contingencia Sana 2016","Concentración moderada Sana 2016")


metabolites4<-data.frame(metabolites3)[1:20,]

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

#CONTINGENCIA

metabolites4<-data.frame(metabolites3)[21:40,]

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

