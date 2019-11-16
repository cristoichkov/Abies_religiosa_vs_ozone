
# Load libraries

library(ggfortify)
library(corrplot)
library(lfda)

library("mice")
library("factoextra")

# Load data

metabolites<-read.delim("../../metadata/calculate_relative_abs.txt")

# Add PCA column

metabolites$PCA<-c(rep("SS15",5), rep("SS16",5), 
                    rep("SD15",5),rep("SD16",5),
                    rep("CS15",5),rep("CS16",5),
                    rep("CD15",5),rep("CD16",5))
#Exportar Data frame
exp_table<-metabolites[,c(1,8:15)]
write.csv(exp_table, file="../../metadata/exp_table.csv")
write.table(exp_table, file="../../metadata/exp_table.txt")


metabolitesSS<-metabolites[1:20,8:16]
metabolitesConti<-metabolites[21:40,8:16]


df <- metabolites[c(8:15)]
df <- metabolitosSS
df <- metabolitosConti

#Buscar datos faltantes e imputarlos
table(is.na(df))


#Para generar matriz de correlaciones de Pearson
matrizcor<-cor(df, method=c("pearson"))
matrizcov<-cov(df)

#C?lculo de componentes principales usando matriz R
CP<-princomp(df, cor=T)
summary(CP)
eigen(matrizcor)
CP$loadings

vector_sdevs<-as.vector(CP$sdev)
vector_sdevs
lambdas<-vector_sdevs*vector_sdevs
lambdas
TrazaLAMBDA<-sum(lambdas)
TrazaLAMBDA                          

screeplot(CP, main="Gr?fica de codo")
abline(h=1,col=4)

#Biplot CP1 vs CP2
biplot(CP, choices= c(1,2),cex=c(0.6,0.5), scale = 0, main="Biplot para componentes 1 y 2 con scale=0")
abline(h=0, v=0, col = "lightgray", lty = 3)
abline(h=0.2, v=0.2, col = "lightgray", lty = 3)
abline(h=-0.2,  v=-0.2, col = "lightgray", lty = 3)
abline(h=0.4, v=0.4, col = "lightgray", lty = 3)
abline(h=-0.4, v=-0.4, col = "lightgray", lty = 3)


#Base de datos originales
Nocentrada_sF<-scale(df , center = FALSE, scale = FALSE)
Nocentrada_sF[15,]


#Base de datos centrada
centrada_sF<-scale(df, center = TRUE, scale = FALSE)
centrada_sF[15,]

#Base de datos centrada y escalada
centrada_sT<-scale(df , center = TRUE, scale = TRUE)
centrada_sT[15,] 

#Calculo de scores para UNAM en CP1
sum(CP$loadings[,1]*  Nocentrada_sF[15,] )  #Usando datos originales                                 
sum(CP$loadings[,1]*  centrada_sF[15,] )   #Usando datos centrados                                           
sum(CP$loadings[,1]*  centrada_sT[15,] )   #Usando datos centrados y escalados                                


sum(CP$loadings[,2]*  Nocentrada_sF[15,] )    #Usando datos originales                                 
sum(CP$loadings[,2]*  centrada_sF[15,] )      #Usando datos centrados                                         
sum(CP$loadings[,2]*  centrada_sT[15,] )      #Usando datos centrados y escalados                                     

#C?lculo de scores UNAM para CP1 y CP2 con funci?n princomp
CP$scores[15,1]
CP$scores[15,2]


PC2<-prcomp(df,scale=TRUE)
fviz_eig(CP)
fviz_pca_ind(CP, col.ind="cos2", gradient.cols=c(#00AFBB","#E7B800","#FC4E07"),repel=TRUE)
)
)
fviz_pca_var(CP,col.var="contrib", gradient.cols=c(#00AFBB","#E7B800","#FC4E07"),repel=TRUE)
)
)
fviz_pca_biplot(CP,col.var="#2E9FDF", col.ind="#696969")

fviz_pca_biplot(CP,col.var="#2E9FDF", col.ind="#696969")

CP

autoplot(prcomp(CP$loadings), data = CP$loadings, colour = 'PCA',
         loadings = TRUE, size = 3, loadings.colour = 'black',
         loadings.label = TRUE, loadings.label.size = 4, loadings.label.colour = 'black',
         frame = TRUE, frame.type = 'norm' )


ggplot(tab, aes(x=EV1, y=EV2))+
  geom_point(aes(color=Condicion, shape=Poblacion), size =5) + 
  scale_color_manual(values = pobcol) +
  theme(legend.title = element_text(size=15))+
  theme(legend.text = element_text(size = 15))+
  xlab(paste0("Eigenvector 1 explicando ", round(pc.percent, 2)[1], "%")) +
  ylab(paste0("Eigenvector 2 explicando ", round(pc.percent, 2)[2], "%"))+
  theme(axis.title.y = element_text(size = rel(2), angle = 90))+
  theme(axis.title.x = element_text(size = rel(2), angle = 360))+
  theme(axis.text.x = element_text(hjust = .5, size=13, color="black"))+
  theme(axis.text.y = element_text(hjust = .5, size=13, color="black"))+
  geom_point(alpha = 1/20)+
  scale_shape_manual(values=c(0,1,2,3,4,5,6,7,8,11,13,15,16,17,18,35,38,43,64))



autoplot(prcomp(df))
autoplot(prcomp(df), data = metabolites, colour = 'PCA', label = TRUE, label.size = 10)
autoplot(prcomp(df), data = metabolites, colour = 'PCA', shape = FALSE, label.size = 3)
autoplot(prcomp(df), data = metabolites, colour = 'PCA', loadings = TRUE)
autoplot(prcomp(df), data = metabolites, colour = 'PCA',
         loadings = TRUE, loadings.colour = 'purple',
         loadings.label = TRUE, loadings.label.size = 3,
         frame = TRUE, frame.type = 'norm')

df2<- as.matrix(df)



M <- cor(df2) 
corrplot(M, method = "circle")
corrplot(M, method = "number") # Display the correlation coefficient

p.mat <- cor.mtest(df2)$p
head(p.mat[, 1:8])
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(M, method = "color", col = col(200),
         type = "upper", order = "hclust", number.cex = .7,
         addCoef.col = "black", # Add coefficient of correlation
         tl.col = "black", tl.srt = 90, # Text label color and rotation
         # Combine with significance
         p.mat = p.mat, sig.level = 0.01, insig = "blank", 
         # hide correlation coefficient on the principal diagonal
         diag = FALSE)

df3<-scale(df2)
autoplot(prcomp(df3), data = metabolites, colour = 'PCA',
         loadings = TRUE, loadings.colour = 'purple',
         loadings.label = TRUE, loadings.label.size = 3,
         frame = TRUE, frame.type = 'norm')

# PCA Todas

df <- metabolites[c(8:15)]
dff<- df[c(1:4,6:8)]
autoplot(prcomp(dff), data = metabolites, colour = 'PCA',
         loadings = TRUE, size = 3, loadings.colour = 'black',
         loadings.label = TRUE, loadings.label.size = 4, loadings.label.colour = 'black',
         frame = TRUE, frame.type = 'norm' )


# PCA SS
df <- metabolitosSS[c(8:15)]
dff<- df[c(1:4,6:8)]
autoplot(prcomp(dff), data = metabolitosSS, colour = 'PCA',
         loadings = TRUE, size = 3, loadings.colour = 'black',
         loadings.label = TRUE, loadings.label.size = 4, loadings.label.colour = 'black',
         frame = TRUE, frame.type = 'norm' )
dfSS<- as.matrix(df)


# PCA Conti
df <- metabolitosConti[c(8:15)]
dff<- df[c(1:4,6:8)]
autoplot(prcomp(dff), data = metabolitosConti, colour = 'PCA',
         loadings = TRUE, size = 3, loadings.colour = 'black',
         loadings.label = TRUE, loadings.label.size = 4, loadings.label.colour = 'black',
         frame = TRUE, frame.type = 'norm' )

library(klaR)
partimat(Species ~ Sepal.Width + Sepal.Length + Petal.Length + Petal.Width,
         data = iris, method = "lda", prec = 200,
         image.colors = c("darkgoldenrod1", "snow2", "skyblue2"),
         col.mean = "firebrick")

library(klaR)
library(MASS)
partimat(PCA ~ beta.pinene + L.alfa.bornyl.acetate + beta.Caryophyllene.oxide,
         data = metabolites, method = "lda", prec = 200,
         image.colors = c("darkgoldenrod1", "snow2", "skyblue2"),
         col.mean = "firebrick")
summary(metabolites)
beta.pinene + L.alfa.bornyl.acetate + beta.Caryophyllene.oxide + alfa.Caryophyllene + beta.Cubebene + alfa.Cubenene + delta.Cadinene + alfa.Muurolene

iris

#dfConti<- as.matrix(df)
#autoplot(pam(metabolitosConti[-5], 3), frame = TRUE, frame.type = 'norm')

#PCA(df, scale.unit = TRUE, ncp = 5, graph = TRUE)

#sin correlacionadas 1:13,16,17
#sin correlacionadas 1:8,11:17
#sin NO Significativas 2, 4:8,11,12,14,15,17
# Solamente significativas *** no correlacionadas 6,9,10,11,14,15
# Solamente significativas *** no correlacionadas 6,9,10,15
# Solamente significativas *** no correlacionadas 6,14,15,11

#library(lfda)

# Local Fisher Discriminant Analysis (LFDA)
#model <- lfda(metabolitosConti[-c(1:7,25),], metabolitosConti[, 25], 4, metric="plain")
#autoplot(model, data = iris, frame = TRUE, frame.colour = 'Species')

row.names(metabolitesSS) <- paste(metabolitesSS$PCA, row.names(metabolitesSS), sep="_") 
metabolitesSS$PCA <- NULL

head(metabolitesSS)
df_pca <- prcomp(metabolitesSS)
plot(df_pca$x[,1], df_pca$x[,2])

df_out <- as.data.frame(df_pca$x)
df_out$group <- sapply( strsplit(as.character(row.names(metabolitesSS)), "_"), "[[", 1 )
head(df_out)
library(ggplot2)
library(grid)
library(gridExtra)

p<-ggplot(df_out,aes(x=PC1,y=PC2,color=group ))
p<-p+geom_point()
p
theme<-theme(panel.background = element_blank(),panel.border=element_rect(fill=NA),panel.grid.major = element_blank(),panel.grid.minor = element_blank(),strip.background=element_blank(),axis.text.x=element_text(colour="black"),axis.text.y=element_text(colour="black"),axis.ticks=element_line(colour="black"),plot.margin=unit(c(1,1,1,1),"line"))
p<-ggplot(df_out,aes(x=PC1,y=PC2,color=group ))
p<-p+geom_point()+theme
p
p<-ggplot(df_out,aes(x=PC1,y=PC2,color=group, label=row.names(metabolitesSS) ))
p<-p+geom_point()+ geom_text(size=3)+theme
p

percentage <- round(df_pca$sdev / sum(df_pca$sdev) * 100, 2)
percentage <- paste( colnames(df_out), "(", paste( as.character(percentage), "%", ")", sep="") )

p<-ggplot(df_out,aes(x=PC1,y=PC2,color=group ))
p<-p+geom_point()+theme + xlab(percentage[1]) + ylab(percentage[2])
p

df_out$group <- factor(df_out$group, levels = c("SD15", "SD16", "SS15", "SS16"))

p<-ggplot(df_out,aes(x=PC1,y=PC2,color=group ))
p<-p+geom_point()+theme + xlab(percentage[1]) + ylab(percentage[2]) + scale_color_manual(values=c("#c65999",
                                                                                                  "#7aa456",
                                                                                                  "#777acd",
                                                                                                  "#c96d44"))
p



