
# Load libraries
library (ggplot2)
library(ggfortify)
library(corrplot)
library(lfda)

library("mice")
library("factoextra")

# Load data
#Dar nombre a la base de datos y adjuntarla
metabolites<-read.delim("../../metadata/calculate_relative_abs.txt")

metabolites$PCA<-c(rep("SS15",5), rep("SS16",5), 
                   rep("SD15",5),rep("SD16",5),
                   rep("CS15",5),rep("CS16",5),
                   rep("CD15",5),rep("CD16",5))

rownames(metabolites)<-c("SS15_1", "SS15_2", "SS15_3", "SS15_4", "SS15_5",
                         "SS16_1", "SS16_2", "SS16_3", "SS16_4", "SS16_5", 
                         "SD15_1", "SD15_2", "SD15_3", "SD15_4", "SD15_5",
                         "SD16_1", "SD16_2", "SD16_3", "SD16_4", "SD16_5",
                         "CS15_1", "CS15_2", "CS15_3", "CS15_4", "CS15_5",
                         "CS16_1", "CS16_2", "CS16_3", "CS16_4", "CS16_5",
                         "CD15_1", "CD15_2", "CD15_3", "CD15_4", "CD15_5",
                         "CD16_1", "CD16_2", "CD16_3", "CD16_4" ,"CD16_5")

metabolitesSS<-metabolites[1:20,8:15]

attach(metabolitesSS)
str(metabolitesSS)

metabolitesConti<-metabolites[21:40,8:15]

attach(metabolitesConti)
str(metabolitesConti)


#Exportar Data frame
exp_table<-metabolites[,c(1,8:15)]
write.csv(exp_table, file="../../metadata/exp_table.csv")
write.table(exp_table, file="../../metadata/exp_table.txt")


#Para generar matriz de correlaciones de Pearson
matrizcorSS<-cor(metabolitesSS, method=c("pearson"))
matrizcovSS<-cov(metabolitesSS)

matrizcorConti<-cor(metabolitesConti, method=c("pearson"))
matrizcovConti<-cov(metabolitesConti)


#C?lculo de componentes principales usando matriz R
CP_SS<-princomp(metabolitesSS, cor=T)
summary(CP_SS)
eigen(matrizcorSS)
CP_SS$loadings

vector_sdevs_SS<-as.vector(CP_SS$sdev)
vector_sdevs_SS
lambdas_SS<-vector_sdevs_SS*vector_sdevs_SS
lambdas_SS
TrazaLAMBDA_SS<-sum(lambdas_SS)
TrazaLAMBDA_SS                          

screeplot(CP_SS, main="Gr?fica de codo")
abline(h=1,col=4)



CP_Conti<-princomp(metabolitesConti, cor=T)
summary(CP_Conti)
eigen(matrizcorConti)
CP_Conti$loadings

vector_sdevs_Conti<-as.vector(CP_Conti$sdev)
vector_sdevs_Conti
lambdas_Conti<-vector_sdevs_Conti*vector_sdevs_Conti
lambdas_Conti
TrazaLAMBDA_Conti<-sum(lambdas_Conti)
TrazaLAMBDA_Conti                          

screeplot(CP_Conti, main="Gr?fica de codo")
abline(h=1,col=4)



#Biplot CP1 vs CP2
biplot(CP_SS, choices= c(1,2),cex=c(0.6,0.5), scale = 0, main="Biplot para componentes 1 y 2 con scale=0")
abline(h=0, v=0, col = "lightgray", lty = 3)
abline(h=0.2, v=0.2, col = "lightgray", lty = 3)
abline(h=-0.2,  v=-0.2, col = "lightgray", lty = 3)
abline(h=0.4, v=0.4, col = "lightgray", lty = 3)
abline(h=-0.4, v=-0.4, col = "lightgray", lty = 3)


PC2<-prcomp(metabolitesSS,scale=TRUE)
fviz_eig(CP_SS)
fviz_pca_ind(CP_SS, col.ind="cos2", gradient.cols=c(#00AFBB","#E7B800","#FC4E07"),repel=TRUE)
)
)
fviz_pca_var(CP_SS,col.var="contrib", gradient.cols=c(#00AFBB","#E7B800","#FC4E07"),repel=TRUE)
)
)
fviz_pca_biplot(CP_SS,col.var="#2E9FDF", col.ind="#696969")

fviz_pca_biplot(CP_SS,col.var="#2E9FDF", col.ind="#696969")




biplot(CP_Conti, choices= c(1,2),cex=c(0.6,0.5), scale = 0, main="Biplot para componentes 1 y 2 con scale=0")
abline(h=0, v=0, col = "lightgray", lty = 3)
abline(h=0.2, v=0.2, col = "lightgray", lty = 3)
abline(h=-0.2,  v=-0.2, col = "lightgray", lty = 3)
abline(h=0.4, v=0.4, col = "lightgray", lty = 3)
abline(h=-0.4, v=-0.4, col = "lightgray", lty = 3)


PC2<-prcomp(metabolitesConti,scale=TRUE)
fviz_eig(CP_Conti)
fviz_pca_ind(CP_Conti, col.ind="cos2", gradient.cols=c(#00AFBB","#E7B800","#FC4E07"),repel=TRUE)
)
)
fviz_pca_var(CP_Conti,col.var="contrib", gradient.cols=c(#00AFBB","#E7B800","#FC4E07"),repel=TRUE)
)
)
fviz_pca_biplot(CP_Conti,col.var="#2E9FDF", col.ind="#696969")

fviz_pca_biplot(CP_Conti,col.var="#2E9FDF", col.ind="#696969")


# Local Fisher Discriminant Analysis (LFDA)

metabolitesSS<-metabolites[1:20,8:15]

metabolitesConti<-metabolites[21:40,8:15]

metabolites_2_SS<-metabolites[1:20,8:16]
  
metabolites_2_Conti<-metabolites[21:40,8:16]

model <- lfda(metabolites_2_SS[-9], metabolites_2_SS[, 9], 4, metric="plain")
autoplot(model, data = metabolites_2_SS, frame = TRUE, frame.colour = 'PCA')

X <- metabolites_2_SS[,-9]
y <- metabolites_2_SS[, 9]

X$xnew <- (metabolites_2_SS[, 9]=="SS15")

result <- lfda(X, y, r=3, metric="plain")


library(lfda)

# Local Fisher Discriminant Analysis (LFDA)
model <- lfda(iris[-5], iris[, 5], 4, metric="plain")
autoplot(model, data = iris, frame = TRUE, frame.colour = 'Species')


