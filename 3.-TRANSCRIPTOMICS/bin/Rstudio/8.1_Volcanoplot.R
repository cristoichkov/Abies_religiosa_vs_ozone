
library(VennDiagram)
library(limma)
library(edgeR)
library(DESeq2)
library(ggbiplot)
library (ggplot2)

#Load data
results_DESeq2<- read.delim("../../metadata/DGE/DESeq2_HvsD170ppb_FDR_0.1.txt")
results_Edge<- read.delim("../../metadata/DGE/EdgeR_HvsD170ppb_FDR_1.txt")

#Indicate data to plot##
results_DESeq2$sig <- -log10(results_DESeq2$padj) ##Create a column with aditional info of FDR (padj)##
cols <- densCols(results_DESeq2$log2FoldChange, results_DESeq2$pvalue)

results_Edge$sig <- -log10(results_Edge$FDR) ##Create a column with aditional info of FDR (padj)##
cols <- densCols(results_Edge$logFC, results_Edge$PValue)


##Indicate color code##

cols[results_DESeq2$log2FoldChange < -1.5] <- "#0066FF"
cols[results_DESeq2$log2FoldChange > 1.5] <- "#0033CC"
cols[results_DESeq2$pvalue == 0] <- "#000000"
cols[results_DESeq2$pvalue > 0.05] <- "#CCCCCC"


cols[results_Edge$logFC < -1.5] <- "#0066FF"
cols[results_Edge$logFC > 1.5] <- "#0033CC"
cols[results_Edge$PValue == 0] <- "#000000"
cols[results_Edge$PValue > 0.05] <- "#CCCCCC"



##Other graphical parameters##

results_DESeq2$pch <- 19
results_DESeq2$pch[results_DESeq2$pvalue ==0] <- 6
plot(results_DESeq2$log2FoldChange,
     results_DESeq2$sig,
     col=cols, panel.first=grid(),
     main="all RNA",
     xlab="log2(fold-change)",
     ylab="-log10(adjusted p-value)",
     pch=results_DESeq2$pch, cex=0.8)
abline(v=0)
abline(v=c(-1,1), col="brown")


results_Edge$pch <- 19
results_Edge$pch[results_Edge$PValue ==0] <- 6
plot(results_Edge$logFC,
     results_Edge$sig,
     col=cols, panel.first=grid(),
     main="all RNA",
     xlab="log2(fold-change)",
     ylab="-log10(adjusted p-value)",
     pch=results_Edge$pch, cex=0.8)
abline(v=0)
abline(v=c(-1,1), col="brown")




##For the new solution##

VPSol_DESeq2 <- data.frame(results_DESeq2$log2FoldChange, results_DESeq2$sig, row.names = rownames(results_DESeq2)) ##Creates a data frame with coordinates##

VPSol_edge <- data.frame(results_Edge$logFC, results_Edge$sig, row.names = rownames(results_Edge)) ##Creates a data frame with coordinates##


##Rename the columns to simplify the dataframe##

colnames(VPSol_DESeq2) <- c("FoldChange", "p_value")

colnames(VPSol_edge) <- c("FoldChange", "p_value")

##Create a column with colors depending on the value of Fold Change and p-value##  

VPSol_DESeq2$color <- ifelse((VPSol_DESeq2$FoldChange > 1) & (VPSol_DESeq2$p_value < 0.05), "Col_1",
                      ifelse((VPSol_DESeq2$FoldChange < -1) & (VPSol_DESeq2$p_value < 0.05), "Col_2",
                             ifelse((VPSol_DESeq2$FoldChange > 1) & (VPSol_DESeq2$p_value > 0.05), "Col_3",
                                    ifelse((VPSol_DESeq2$FoldChange < -1) & (VPSol_DESeq2$p_value > 0.05), "Col_4",
                                           ifelse((VPSol_DESeq2$FoldChange < 1) & (VPSol_DESeq2$p_value > 0.05), "Col_5", "Col_6")))))


VPSol_edge$color <- ifelse((VPSol_edge$FoldChange > 1) & (VPSol_edge$p_value < 0.05), "Col_1",
                      ifelse((VPSol_edge$FoldChange < -1) & (VPSol_edge$p_value < 0.05), "Col_2",
                             ifelse((VPSol_edge$FoldChange > 1) & (VPSol_edge$p_value > 0.05), "Col_3",
                                    ifelse((VPSol_edge$FoldChange < -1) & (VPSol_edge$p_value > 0.05), "Col_4",
                                           ifelse((VPSol_edge$FoldChange < 1) & (VPSol_edge$p_value > 0.05), "Col_5", "Col_6")))))


##Create plot##
ggplot(VPSol_DESeq2, aes(x=FoldChange, y=p_value)) +
  geom_point(aes(colour = color ))
ggsave("../../outputs/VPSol_DESeq2.png")

ggplot(VPSol_edge, aes(x=FoldChange, y=p_value)) +
  geom_point(aes(colour = color))
ggsave("../../outputs/VPSol_edge.png")

