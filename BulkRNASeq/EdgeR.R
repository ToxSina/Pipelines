library(edgeR)
featureTable <- read.table('FeatureCounts.txt', header = T)
row.names(featureTable) <- featureTable$Geneid
featureTable <- featureTable[, -c(1:6)] 
features <- DGEList(counts=featureTable)

#Have a quick look on how your samples cluster
plotMDS(features)

groups <- read.csv('grouping.csv', header = T)
row.names(groups) <- groups$Sample
groups <- groups[, -c(1)]
#remove any missing samples from the groups
row.names.remove <- c("NameOfMissingSample1", "NameOfMissingSample2")
groups <- groups[!(row.names(groups) %in% row.names.remove), ]

#Create subdirectory "comparisons" in the current R working directory

#X vs Y grouped analysis
XvsYFeatures <- DGEList(counts=featureTable, group=groups[,"XvsY"])
XvsYKeep <- filterByExpr(XvsYFeatures)
XvsYFeatures <- XvsYFeatures[XvsYKeep, keep.lib.sizes=FALSE]
XvsYFeatures <- calcNormFactors(XvsYFeatures)
XvsYDesign <- model.matrix(~groups[,"XvsY"]+0)
colnames(XvsYDesign) <- c("X", "Y", "other")
XvsYFeatures <- estimateDisp(XvsYFeatures, XvsYDesign)
XvsYFit <- glmQLFit(XvsYFeatures, XvsYDesign)
XvsYContrast <- makeContrasts(treatment = X-Y, levels=XvsYDesign)
XvsYQLF <- glmQLFTest(XvsYFit, contrast=XvsYContrast)
#quick plot to see significantly differentially expressed genes
plotMD(beta23PosvsNegQLF)
abline(h=c(-1, 1), col="blue")
#If there are no significant genes found, the next two steps have to be skipped 
XvsYGenes <- decideTests(XvsYQLF)
XvsYTab <- topTags(XvsYQLF, n=Inf, p=0.05)$table
#In case of skipping the last two lines, include this one instead to define significance without FDR, only by Pvalue
#XvsYTab <- XvsYQLF$table[XvsYQLF$table$PValue<0.05,]
XvsYUp <- XvsYTab[XvsYTab$logFC > 0, ]
XvsYDown <- XvsYTab[XvsYTab$logFC < 0, ]
write.csv(XvsYUp, 'comparisons/XvsYUp.csv')
write.csv(XvsYDown, 'comparisons/XvsYDown.csv')

#Plot a simple volcano plot:
#volcanotest
plot(XvsYGenes$table$logFC, -10*log10(XvsYGenes$table$PValue), main="Volcano plot", xlab="M", ylab="-10*log(P-val)")
XvsY.enriched <- XvsYGenes$table$logFC > 0 & XvsYGenes$table$padj < 0.01
points(XvsYGenes$table$logFC[XvsY.enriched], -10*log10(XvsYGenes$table$PValue[XvsY.enriched]), col="red")
XvsY.enriched <- XvsYGenes$table$logFC < 0 & XvsYGenes$table$padj < 0.01
points(XvsYGenes$table$logFC[XvsY.depleted], -10*log10(XvsYGenes$table$PValue[XvsY.depleted]), col="green")

#If you have no significant upregulated genes use the next 5 lines instead of the previous 5
#plot(XvsYQLF$table$logFC, -10*log10(XvsYQLF$table$PValue), main="Volcano plot", xlab="M", ylab="-10*log(P-val)")
#XvsY.enriched <- XvsYQLF$table$logFC > 0 & XvsYQLF$table$PValue < 0.005
#points(XvsYQLF$table$logFC[XvsY.enriched], -10*log10(XvsYQLF$table$PValue[XvsY.enriched]), col="red")
#XvsY.depleted <- XvsYQLF$table$logFC < 0 & XvsYQLF$table$PValue < 0.005
#points(XvsYQLF$table$logFC[XvsY.depleted], -10*log10(XvsYQLF$table$PValue[XvsY.depleted]), col="green")

#Biomart enrichment analysis
library(biomaRt)
library(dplyr)
library(tibble)

mart <- useMart("ensembl")
#Replace mouse with appropriate ensemble dataset, for example hsapiens_gene_ensemble
#If unsure check this list:
#datasets <- listDatasets(ensembl)
mart <- useDataset(dataset = "mmusculus_gene_ensembl", mart = mart)

upXvsY_info <- getBM(filters= "ensembl_gene_id", attributes= c("ensembl_gene_id", "external_gene_name", "description"), values = XvsYUp, mart= mart)
upXvsY_goterms <- getBM(filters= "ensembl_gene_id", attributes= c("ensembl_gene_id", "external_gene_name", "start_position", "end_position","go_id","name_1006"), values = XvsYUp, mart= mart)
downXvsY_info <- getBM(filters= "ensembl_gene_id", attributes= c("ensembl_gene_id", "external_gene_name", "description"), values = XvsYDown, mart= mart)
downXvsY_goterms <- getBM(filters= "ensembl_gene_id", attributes= c("ensembl_gene_id", "external_gene_name", "start_position", "end_position","go_id","name_1006"), values = XvsYDown, mart= mart)

#Create Venn Diagramms
library(ggVennDiagram)
library(viridis)
library(ggplot2)

sharedXYZUpVenn <- list(XvsY = XvsYUp, YvsY = ZvsYUp)
ggVennDiagram::ggVennDiagram(sharedXYZUpVenn) +  scale_fill_viridis("count", option = "plasma")

#Get shared and unique differentially expressed genes for different groups (for more involved groups add at the end of list)
sharedXYZUp <- Reduce(intersect, c(XvsYUp, YvsYUp))
sharedXYZDown <- Reduce(intersect, c(XvsYDown, YvsYDown))

XOnly_Up <- Reduce(setdiff, list(XvsYUp, ZvsYUp))
XOnly_Down <- Reduce(setdiff, list(XvsYDown, ZvsYown))

#Heatmap
XvsY.exp.data <- featureTable[XvsY.enriched | XvsY.depleted,]
heatmap(as.matrix(XvsY.exp.data), Rowv = TRUE)
