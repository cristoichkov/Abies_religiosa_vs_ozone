##############Analisis discriminante###################
#######################################################

################TODAS###################################

datos<- read.csv("../../metadata/exp_table_2.csv", header = T)
table(is.na(datos))
library("mice")
library(MASS)
disc<-lda(X~.,data=datos, method="moment",tol=0.001)
disc
plot(disc)
adp<-predict(disc)
adp
table(predict(disc)$class,datos$X)
tbc=(25+30+30)/99
tmc=1-tbc
tbc*100
tmc*100
plot(adp$x)
text(adp$x[,1],  cex = 0.7, pos = 4, col = "red")


newdata <- data.frame(type = datos[,1], lda = adp$x)
library(ggplot2)
ggplot(newdata) + geom_point(aes(lda.LD1, lda.LD2, colour = type), size = 4) +
  labs(x="FunciÛn discriminante 1 (72.28%)", y = "FunciÛn discriminante 2 (14.88%)")


################ Contingencia ###################################
datos<- datos[1:20,]
datos<- datos[21:40,1:8]

table(is.na(datos))
library("mice")
library(MASS)
disc<-lda(X~.,data=datos, method="moment",tol=0.001)
disc
plot(disc)
adp<-predict(disc)
adp
table(predict(disc)$class,datos$X)
tbc=(25+30+30)/99
tmc=1-tbc
tbc*100
tmc*100
plot(adp$x)
text(adp$x[,1],  cex = 0.7, pos = 4, col = "red")


newdata <- data.frame(type = datos[,1], lda = adp$x)
library(ggplot2)
ggplot(newdata) + geom_point(aes(lda.LD1, lda.LD2, colour = type), size = 4) +
  labs(x="FunciÛn discriminante 1 (72.28%)", y = "FunciÛn discriminante 2 (14.88%)")

