
# Load file

metabolites<-read.delim("../../metadata/calculate_relative_abs.txt")


# ANOVA per metabolite

beta.pinene<- metabolites[,c(3:5,8)]
L.alfa.bornyl.acetate<- metabolites[,c(3:5,9)]
beta.Caryophyllene.oxide<- metabolites[,c(3:5,10)]
alfa.Caryophyllene<- metabolites[,c(3:5,11)]
beta.Cubebene<- metabolites[,c(3:5,12)]
alfa.Cubenene<- metabolites[,c(3:5,13)]
delta.Cadinene<- metabolites[,c(3:5,14)]
alfa.Muurolene<- metabolites[,c(3:5,15)]


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

beta.pinene<- summary(fmbeta.pinene)
L.alfa.bornyl.acetate<- summary(fmL.alfa.bornyl.acetate)
beta.Caryophyllene.oxide<- summary(fmbeta.Caryophyllene.oxide)
alfa.Caryophyllene<- summary(fmalfa.Caryophyllene)
beta.Cubebene<- summary(fmbeta.Cubebene)
alfa.Cubenene<- summary(fmalfa.Cubenene)
delta.Cadinene<- summary(fmdelta.Cadinene)
alfa.Muurolene<- summary(fmalfa.Muurolene)







