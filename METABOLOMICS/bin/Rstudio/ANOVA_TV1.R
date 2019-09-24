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
metabolitos2$X2_alfa.Cubenene  <- metabolitos2$x1*metabolitos$alfa.Cubenene /metabolitos$P.Area.estandar 
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


# ANOVA por metabolito

beta.pinene<- metabolitos3[,c(3:5,8)]
L.alfa.bornyl.acetate<- metabolitos3[,c(3:5,9)]
beta.Caryophyllene.oxide<- metabolitos3[,c(3:5,10)]
alfa.Caryophyllene<- metabolitos3[,c(3:5,11)]
beta.Cubebene<- metabolitos3[,c(3:5,12)]
alfa.Cubenene<- metabolitos3[,c(3:5,13)]
delta.Cadinene<- metabolitos3[,c(3:5,14)]
alfa.Muurolene<- metabolitos3[,c(3:5,15)]


# Efecto univariado 1 Factor

plot.design(beta.pinene ~ ., data = beta.pinene)
plot.design(L.alfa.bornyl.acetate ~ ., data = L.alfa.bornyl.acetate)
plot.design(beta.Caryophyllene.oxide ~ ., data = beta.Caryophyllene.oxide)
plot.design(alfa.Caryophyllene ~ ., data = alfa.Caryophyllene)
plot.design(beta.Cubebene~ ., data = beta.Cubebene)
plot.design(alfa.Cubenene ~ ., data = alfa.Cubenene)
plot.design(delta.Cadinene ~ ., data =delta.Cadinene)
plot.design(alfa.Muurolene ~ ., data = alfa.Muurolene)



# Comparación de medias 2 Factores

op <- par(mfrow = c(4, 1))
with(beta.pinene, {
  interaction.plot(Temporada, Condicion, beta.pinene)
  interaction.plot(Temporada, A.exposicion, beta.pinene)
  interaction.plot(A.exposicion, Condicion, beta.pinene)
}
)
par(op)

# Comparación de medias 3 Factores

fm <- aov(beta.pinene ~ Temporada * Condicion * A.exposicion, data = beta.pinene)

# Notice that this is equivalent to writing:

# fm <- aov(Bornil_Acetato ~ Temporada + Condicion + Tiempo_exposicion + Temporada:Condicion + Temporada:Tiempo_exposicion + Condicion:Tiempo_exposicion
#          + Temporada:Condicion:Tiempo_exposicion, data = Bornil_Acetato)
summary(fm)

# Datos completos
fmbeta.pinene <- aov(beta.pinene ~ Temporada * Condicion * A.exposicion, data = beta.pinene)
fmL.alfa.bornyl.acetate <- aov(L.alfa.bornyl.acetate ~ Temporada * Condicion * A.exposicion, data = L.alfa.bornyl.acetate)
fmbeta.Caryophyllene.oxide<- aov(beta.Caryophyllene.oxide ~ Temporada * Condicion * A.exposicion, data = beta.Caryophyllene.oxide)
fmalfa.Caryophyllene <- aov(alfa.Caryophyllene ~ Temporada * Condicion * A.exposicion, data = alfa.Caryophyllene)
fmbeta.Cubebene<- aov(beta.Cubebene ~ Temporada * Condicion * A.exposicion, data = beta.Cubebene)
fmalfa.Cubenene <- aov(alfa.Cubenene ~ Temporada * Condicion * A.exposicion, data = alfa.Cubenene)
fmdelta.Cadinene<- aov(delta.Cadinene ~ Temporada * Condicion * A.exposicion, data = delta.Cadinene)
fmalfa.Muurolene <- aov(alfa.Muurolene ~ Temporada * Condicion * A.exposicion, data = alfa.Muurolene)


summary(fmbeta.pinene)
summary(fmL.alfa.bornyl.acetate)
summary(fmbeta.Caryophyllene.oxide)
summary(fmalfa.Caryophyllene)
summary(fmbeta.Cubebene)
summary(fmalfa.Cubenene)
summary(fmdelta.Cadinene)
summary(fmalfa.Muurolene)

