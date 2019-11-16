
# Load libraries
library (ggplot2)
library("devtools")
library("ggbiplot")

# Load data
#Dar nombre a la base de datos y adjuntarla
metabolites<-read.delim("../../metadata/calculate_relative_abs.txt")

rownames(metabolites)<-c("SS15_1", "SS15_2", "SS15_3", "SS15_4", "SS15_5",
                         "SS16_1", "SS16_2", "SS16_3", "SS16_4", "SS16_5", 
                         "SD15_1", "SD15_2", "SD15_3", "SD15_4", "SD15_5",
                         "SD16_1", "SD16_2", "SD16_3", "SD16_4", "SD16_5",
                         "CS15_1", "CS15_2", "CS15_3", "CS15_4", "CS15_5",
                         "CS16_1", "CS16_2", "CS16_3", "CS16_4", "CS16_5",
                         "CD15_1", "CD15_2", "CD15_3", "CD15_4", "CD15_5",
                         "CD16_1", "CD16_2", "CD16_3", "CD16_4" ,"CD16_5")

beta <- intToUtf8(946)
alfa <-intToUtf8(945)
delta<-intToUtf8(948)
beta.pinene <- paste0(beta,"-Pineno") 
L.alfa.bornyl.acetate <- paste0("L-",alfa,"-Acetato de Bornilo") 
beta.Caryophyllene.oxide <- paste0("Óxido de ",beta,"-Cariofileno") 
alfa.Caryophyllene <- paste0(alfa,"-Cariofileno") 
beta.Cubebene <- paste0(beta,"-Cubebeno") 
alfa.Cubebene <- paste0(alfa,"-Cubebeno") 
delta.Cadinene <- paste0(delta,"-Cadineno") 
alfa.Muurolene <- paste0(alfa,"-Muuroleno") 

#moderated period HvsD

metabolitesSS<-metabolites[1:20,8:14]
colnames(metabolitesSS)<-c(beta.pinene,L.alfa.bornyl.acetate,beta.Caryophyllene.oxide,
                           alfa.Caryophyllene,beta.Cubebene,alfa.Cubebene,delta.Cadinene)

metabol_SS.pca <- prcomp(metabolitesSS ,scale.=TRUE)
summary(metabol_SS.pca)
str(metabol_SS.pca)
summary(metabol_SS.pca)
sum<-summary(metabol_SS.pca)
metabolites.PCA<-c(rep("SS15",5), rep("SS16",5), 
                   rep("SD15",5),rep("SD16",5))
metabolites.condition<-c(rep("sana",10), rep("dañada",10))

ggbiplot(metabol_SS.pca,ellipse=TRUE,obs.scale = 1, var.scale = 1,var.axes=FALSE,   labels=rownames(metabolitesSS), groups=metabolites.PCA)+
  scale_color_manual(name="temporada/condición/año", values=c("#c6003a", "#e98382", "#00901e","#b1e787"))
ggbiplot(metabol_SS.pca,ellipse=TRUE,obs.scale = 1, var.scale = 1,  labels=rownames(metabolitesSS), groups=metabolites.PCA)+
  scale_color_manual(name="temporada/condición/año", values=c("#c6003a", "#e98382", "#00901e","#b1e787"))

ggbiplot(metabol_SS.pca,choices = c(1,2),ellipse=TRUE,obs.scale = 1, var.scale = 1,  groups=metabolites.PCA)+
  scale_color_manual(name="Año de exposición",labels = c("2015", "2016", "2015", "2016"), values=c("#c6003a", "#e98382", "#00901e","#b1e787"))+
  scale_shape_manual(name="Condición", values=c(15,16)) +
  geom_point(aes(colour=metabolites.PCA, shape=metabolites.condition), size = 3)+
  xlab(paste0("Eigenvector 1 explicando ", sum$importance[2,1]*100, "%")) +
  ylab(paste0("Eigenvector 2 explicando ", sum$importance[2,2]*100, "%"))

ggsave("../../outputs/5.1_PCA_moderated_HvsD.png")

# #Contingency period HvsD

metabolitesConti<-metabolites[21:40,8:14]
colnames(metabolitesConti)<-c(beta.pinene,L.alfa.bornyl.acetate,beta.Caryophyllene.oxide,
                           alfa.Caryophyllene,beta.Cubebene,alfa.Cubebene,delta.Cadinene)

metabol_Conti.pca <- prcomp(metabolitesConti ,scale.=TRUE)
summary(metabol_Conti.pca)
str(metabol_Conti.pca)
summary(metabol_Conti.pca)
sum<-summary(metabol_Conti.pca)
metabolites.PCA<-c(rep("CS15",5), rep("CS16",5), 
                   rep("CD15",5),rep("CD16",5))
metabolites.condition<-c(rep("sana",10), rep("dañada",10))

ggbiplot(metabol_Conti.pca,ellipse=TRUE,obs.scale = 1, var.scale = 1,  labels=rownames(metabolitesConti), groups=metabolites.PCA)+
  scale_color_manual(name="metabolites.PCA", values=c("#c6003a", "#e98382", "#00901e","#b1e787"))
ggbiplot(metabol_Conti.pca,ellipse=TRUE,obs.scale = 1, var.scale = 1,var.axes=FALSE,   labels=rownames(metabolitesConti), groups=metabolites.PCA)+
  scale_color_manual(name="metabolites.PCA", values=c("#c6003a", "#e98382", "#00901e","#b1e787"))

ggbiplot(metabol_Conti.pca,choices = c(1,2),ellipse=TRUE,obs.scale = 1, var.scale = 1,  groups=metabolites.PCA)+
  scale_color_manual(name="Año de exposición",labels = c("2015", "2016", "2015", "2016"), values=c("#c6003a", "#e98382", "#00901e","#b1e787"))+
  scale_shape_manual(name="Condición", values=c(15,16)) +
  geom_point(aes(colour=metabolites.PCA, shape=metabolites.condition), size = 3)+
  xlab(paste0("Eigenvector 1 explicando ", sum$importance[2,1]*100, "%")) +
  ylab(paste0("Eigenvector 2 explicando ", sum$importance[2,2]*100, "%"))

ggsave("../../outputs/5.1_PCA_conti_HvsD.png")

#Healthy moderated period vs contingency period

metaboliteshelthy<-metabolites[c(1:10, 21:30),8:14]
colnames(metabolitesConti)<-c(beta.pinene,L.alfa.bornyl.acetate,beta.Caryophyllene.oxide,
                              alfa.Caryophyllene,beta.Cubebene,alfa.Cubebene,delta.Cadinene)

metabolhelthy.pca <- prcomp(metaboliteshelthy ,scale.=TRUE)
summary(metabolhelthy.pca)
str(metabolhelthy.pca)
summary(metabolhelthy.pca)
sum<-summary(metabolhelthy.pca)
metabolites.PCA<-c(rep("SS15",5), rep("SS16",5), 
                   rep("CS15",5),rep("CS16",5))
metabolites.condition<-c(rep("C. moderada",10), rep("Contingencia",10))

ggbiplot(metabolhelthy.pca,ellipse=TRUE,obs.scale = 1, var.scale = 1,  labels=rownames(metaboliteshelthy), groups=metabolites.PCA)+
  scale_color_manual(name="metabolites.PCA", values=c("#b8cf5c","#5f7f40","#64cb6a","#a6d09e"))
ggbiplot(metabolhelthy.pca,ellipse=TRUE,obs.scale = 1, var.scale = 1,var.axes=FALSE,   labels=rownames(metaboliteshelthy), groups=metabolites.PCA)+
  scale_color_manual(name="metabolites.PCA", values=c("#b8cf5c","#5f7f40","#64cb6a","#a6d09e"))

ggbiplot(metabolhelthy.pca,choices = c(1,2),ellipse=TRUE,obs.scale = 1, var.scale = 1,  groups=metabolites.PCA)+
  scale_color_manual(name="Año de exposición",labels = c("2015", "2016", "2015", "2016"), values=c("#6cb643","#b4a945","#53b483","#617835"))+
  scale_shape_manual(name="Temporada", values=c(15,16)) +
  geom_point(aes(colour=metabolites.PCA, shape=metabolites.condition), size = 3)+
  xlab(paste0("Eigenvector 1 explicando ", sum$importance[2,1]*100, "%")) +
  ylab(paste0("Eigenvector 2 explicando ", sum$importance[2,2]*100, "%"))

ggsave("../../outputs/5.1_PCA_healthy_modevscont.png")

#Damaged moderated period vs contingency period

metabolitesdamaged<-metabolites[c(11:20, 31:40),8:14]
colnames(metabolitesdamaged)<-c(beta.pinene,L.alfa.bornyl.acetate,beta.Caryophyllene.oxide,
                              alfa.Caryophyllene,beta.Cubebene,alfa.Cubebene,delta.Cadinene)
metaboldamaged.pca <- prcomp(metabolitesdamaged ,scale.=TRUE)
summary(metaboldamaged.pca)
str(metaboldamaged.pca)
summary(metaboldamaged.pca)
sum<-summary(metaboldamaged.pca)
metabolites.PCA<-c(rep("SD15",5), rep("SD16",5), 
                   rep("CD15",5),rep("CD16",5))
metabolites.condition<-c(rep("C. moderada",10), rep("Contingencia",10))

ggbiplot(metaboldamaged.pca,ellipse=TRUE,obs.scale = 1, var.scale = 1,  labels=rownames(metabolitesdamaged), groups=metabolites.PCA)+
  scale_color_manual(name="metabolites.PCA", values=c("#dd5035","#d7ac43","#c2455e","#a95f2e"))
 
ggbiplot(metaboldamaged.pca,ellipse=TRUE,obs.scale = 1, var.scale = 1,  labels=rownames(metabolitesdamaged), groups=metabolites.PCA)+
  scale_color_manual(name="metabolites.PCA", values=c("#dd5035","#d7ac43","#c2455e","#a95f2e"))

ggbiplot(metaboldamaged.pca,choices = c(1,2),ellipse=TRUE,obs.scale = 1, var.scale = 1,  groups=metabolites.PCA)+
  scale_color_manual(name="Año de exposición",labels = c("2015", "2016", "2015", "2016"), values=c("#dd5035","#d7ac43","#c2455e","#a95f2e"))+
  scale_shape_manual(name="Temporada", values=c(15,16)) +
  geom_point(aes(colour=metabolites.PCA, shape=metabolites.condition), size = 3)+
  xlab(paste0("Eigenvector 1 explicando ", sum$importance[2,1]*100, "%")) +
  ylab(paste0("Eigenvector 2 explicando ", sum$importance[2,2]*100, "%"))

ggsave("../../outputs/5.1_PCA_damaged_modevscont.png")
