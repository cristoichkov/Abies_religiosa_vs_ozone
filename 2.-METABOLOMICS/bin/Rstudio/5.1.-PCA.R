
library(ggfortify)
library(corrplot)



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


metabolitosSS<-metabolites[1:20,]
metabolitosConti<-metabolites[21:40,]


df <- metabolites[c(8:15)]
autoplot(prcomp(df))
autoplot(prcomp(df), data = metabolites, colour = 'PCA', label = TRUE, label.size = 10)
autoplot(prcomp(df), data = metabolites, colour = 'PCA', shape = FALSE, label.size = 3)
autoplot(prcomp(df), data = metabolites, colour = 'PCA', loadings = TRUE)
autoplot(prcomp(df), data = metabolites, colour = 'PCA',
         loadings = TRUE, loadings.colour = 'purple',
         loadings.label = TRUE, loadings.label.size = 3)


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
         loadings.label = TRUE, loadings.label.size = 3)

# PCA Todas

df <- metabolites[c(8:15)]
dff<- df[c(1:4,6:8)]
autoplot(prcomp(dff), data = metabolites, colour = 'PCA',
         loadings = TRUE, size = 3, loadings.colour = 'black',
         loadings.label = TRUE, loadings.label.size = 4, loadings.label.colour = 'black' )


# PCA SS
df <- metabolitosSS[c(8:15)]
dff<- df[c(1:4,6:8)]
autoplot(prcomp(dff), data = metabolitosSS, colour = 'PCA',
         loadings = TRUE, size = 3, loadings.colour = 'black',
         loadings.label = TRUE, loadings.label.size = 4, loadings.label.colour = 'black' )
dfSS<- as.matrix(df)


# PCA Conti
df <- metabolitosConti[c(8:15)]
dff<- df[c(1:4,6:8)]
autoplot(prcomp(dff), data = metabolitosConti, colour = 'PCA',
         loadings = TRUE, size = 3, loadings.colour = 'black',
         loadings.label = TRUE, loadings.label.size = 4, loadings.label.colour = 'black' )

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



