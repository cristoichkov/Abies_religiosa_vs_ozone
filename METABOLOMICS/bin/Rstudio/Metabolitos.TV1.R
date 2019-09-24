#Cargar datos
metabolitos<- read.csv("../../data/Tablas_datos/metabolitos_Tesis_Vero.csv")

metabolitos2<- data.frame(metabolitos$C.A.T,metabolitos$C.A, metabolitos$Temporada,metabolitos$Condicion, metabolitos$A.expo, metabolitos$Muestra, metabolitos$mmet)

colnames(metabolitos2)<- c("C.A.T", "C.A", "Temporada",
                           "Condicion", "A.expo", "Muestra", "mmet") 

# Calcular X1
metabolitos2$x1<-(metabolitos$microlitros.de.estandar*metabolitos$miligramos/metabolitos$microlitros)*2/1000


#Calcular X2,X3,X4,X5 para cada metabolito

# beta.pinene
metabolitos2$X2_beta.pinene <- metabolitos2$x1*metabolitos$beta.pinene/metabolitos$P.Area.estandar 
metabolitos2$X3_beta.pinene <- metabolitos2$X2_beta.pinene*metabolitos$microlitros.de.metabolitos/metabolitos$microlitros.de.inyeccion 
metabolitos2$X4_beta.pinene <- metabolitos2$X3_beta.pinene*100/metabolitos$Peso.acicula.gramos
metabolitos2$X5_beta.pinene <- metabolitos2$X4_beta.pinene*1000
# L.alfa.bornyl.acetate
metabolitos2$X2_L.alfa.bornyl.acetate <- metabolitos2$x1*metabolitos$L.alfa.bornyl.acetate/metabolitos$P.Area.estandar 
metabolitos2$X3_L.alfa.bornyl.acetate <- metabolitos2$X2_L.alfa.bornyl.acetate*metabolitos$microlitros.de.metabolitos/metabolitos$microlitros.de.inyeccion 
metabolitos2$X4_L.alfa.bornyl.acetate <- metabolitos2$X3_L.alfa.bornyl.acetate*100/metabolitos$Peso.acicula.gramos
metabolitos2$X5_L.alfa.bornyl.acetate <- metabolitos2$X4_L.alfa.bornyl.acetate*1000
# beta.Caryophyllene.oxide
metabolitos2$X2_beta.Caryophyllene.oxide <- metabolitos2$x1*metabolitos$beta.Caryophyllene.oxide/metabolitos$P.Area.estandar 
metabolitos2$X3_beta.Caryophyllene.oxide <- metabolitos2$X2_beta.Caryophyllene.oxide*metabolitos$microlitros.de.metabolitos/metabolitos$microlitros.de.inyeccion 
metabolitos2$X4_beta.Caryophyllene.oxide <- metabolitos2$X3_beta.Caryophyllene.oxide*100/metabolitos$Peso.acicula.gramos
metabolitos2$X5_beta.Caryophyllene.oxide <- metabolitos2$X4_beta.Caryophyllene.oxide*1000
#  alfa.Caryophyllene
metabolitos2$X2_alfa.Caryophyllene <- metabolitos2$x1*metabolitos$alfa.Caryophyllene/metabolitos$P.Area.estandar 
metabolitos2$X3_alfa.Caryophyllene <- metabolitos2$X2_alfa.Caryophyllene*metabolitos$microlitros.de.metabolitos/metabolitos$microlitros.de.inyeccion 
metabolitos2$X4_alfa.Caryophyllene <- metabolitos2$X3_alfa.Caryophyllene*100/metabolitos$Peso.acicula.gramos
metabolitos2$X5_alfa.Caryophyllene <- metabolitos2$X4_alfa.Caryophyllene*1000
# beta.Cubebene
metabolitos2$X2_beta.Cubebene <- metabolitos2$x1*metabolitos$beta.Cubebene/metabolitos$P.Area.estandar 
metabolitos2$X3_beta.Cubebene <- metabolitos2$X2_beta.Cubebene*metabolitos$microlitros.de.metabolitos/metabolitos$microlitros.de.inyeccion 
metabolitos2$X4_beta.Cubebene <- metabolitos2$X3_beta.Cubebene*100/metabolitos$Peso.acicula.gramos
metabolitos2$X5_beta.Cubebene <- metabolitos2$X4_beta.Cubebene*1000
# alfa.Cubenene
metabolitos2$X2_alfa.Cubenene  <- metabolitos2$x1*metabolitos$alfa.Cubenene/metabolitos$P.Area.estandar 
metabolitos2$X3_alfa.Cubenene  <- metabolitos2$X2_alfa.Cubenene *metabolitos$microlitros.de.metabolitos/metabolitos$microlitros.de.inyeccion 
metabolitos2$X4_alfa.Cubenene  <- metabolitos2$X3_alfa.Cubenene *100/metabolitos$Peso.acicula.gramos
metabolitos2$X5_alfa.Cubenene  <- metabolitos2$X4_alfa.Cubenene *1000
# delta.Cadinene
metabolitos2$X2_delta.Cadinene <- metabolitos2$x1*metabolitos$delta.Cadinene/metabolitos$P.Area.estandar 
metabolitos2$X3_delta.Cadinene <- metabolitos2$X2_delta.Cadinene*metabolitos$microlitros.de.metabolitos/metabolitos$microlitros.de.inyeccion 
metabolitos2$X4_delta.Cadinene <- metabolitos2$X3_delta.Cadinene*100/metabolitos$Peso.acicula.gramos
metabolitos2$X5_delta.Cadinene <- metabolitos2$X4_delta.Cadinene*1000
# alfa.Muurolene
metabolitos2$X2_alfa.Muurolene <- metabolitos2$x1*metabolitos$alfa.Muurolene/metabolitos$P.Area.estandar 
metabolitos2$X3_alfa.Muurolene <- metabolitos2$X2_alfa.Muurolene*metabolitos$microlitros.de.metabolitos/metabolitos$microlitros.de.inyeccion 
metabolitos2$X4_alfa.Muurolene <- metabolitos2$X3_alfa.Muurolene*100/metabolitos$Peso.acicula.gramos
metabolitos2$X5_alfa.Muurolene <- metabolitos2$X4_alfa.Muurolene*1000

# Data frame con datos a partir de la [] del estandar 

metabolitos3<- data.frame(metabolitos2$C.A.T,metabolitos2$C.A,metabolitos2$Temporada,metabolitos2$Condicion,metabolitos2$A.expo, metabolitos2$Muestra, metabolitos2$mmet,
                          metabolitos2$X4_beta.pinene, metabolitos2$X4_L.alfa.bornyl.acetate , metabolitos2$X4_beta.Caryophyllene.oxide, metabolitos2$X4_alfa.Caryophyllene,
                          metabolitos2$X4_beta.Cubebene,metabolitos2$X4_alfa.Cubenene,metabolitos2$X4_delta.Cadinene,metabolitos2$X4_alfa.Muurolene)


# Cambiar nombres a las columnas

colnames(metabolitos3)<- c("C-A-T","C-A","Temporada","Condicion", "A.exposicion", "Muestra","n.GC-MS",
                           "beta.pinene","L.alfa.bornyl.acetate","beta.Caryophyllene.oxide","alfa.Caryophyllene",
                           "beta.Cubebene","alfa.Cubenene","delta.Cadinene","alfa.Muurolene")


# Plotear
library(ggplot2)
library(reshape2)



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

p + coord_flip() + facet_wrap(~ Factores)

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
p + coord_flip() + facet_wrap(~ Factores)

