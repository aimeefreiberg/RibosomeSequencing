#organize genome counts table 

######## BASH PART : add module R
module add R/3.6.1
R
######## BASH PART END

#set work directive
setwd ("/data/users/afreiberg/Ribosome_sequencing/differential_expression_analysis")

original_count = read.table("genome_counts.txt", header = TRUE)

counts = original_count[, c("Geneid", "SRR9596300_clipped_t10_f2_tr_no_undesiredRNA_Rnor_6_sorted.bam", "SRR9596303_clipped_t10_f2_tr_no_undesiredRNA_Rnor_6_sorted.bam", "SRR9596296_clipped_t10_f2_tr_no_undesiredRNA_Rnor_6_sorted.bam", "SRR9596295_clipped_t10_f2_tr_no_undesiredRNA_Rnor_6_sorted.bam", "SRR9596310_clipped_t10_f2_tr_no_undesiredRNA_Rnor_6_sorted.bam", "SRR9596304_clipped_t10_f2_tr_no_undesiredRNA_Rnor_6_sorted.bam")]
colnames(counts) = c("Geneid","Somata_03", "Neuropil_02", "Somata_02","Somata_01","Neuropil_01","Neuropil_03")

counts_org = counts[c("Somata_01","Somata_02","Somata_03","Neuropil_01","Neuropil_02","Neuropil_03")]
rownames(counts_org) = counts[, "Geneid"]

##########deseq analysis
#install packages
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("DESeq2")

#load packages
library("DESeq2")

#prepare metadata
samples = c("Somata_01","Somata_02","Somata_03","Neuropil_01","Neuropil_02","Neuropil_03")
condition = c("Somata","Somata","Somata","Neuropil", "Neuropil","Neuropil")
replicant = c("1","2","3","1","2","3")
coldata = cbind(condition, replicant)
rownames(coldata) = samples


#generate metadata + counts table
ddsFullCountTable <- DESeqDataSetFromMatrix(countData = counts_org, colData = coldata, design= ~ condition)

#select only counts larger than 10
checked_rows <- rowSums(counts(ddsFullCountTable)) > 10
all <- cbind(rownames(counts_org), checked_rows, 1:length(checked_rows))

all_wanted = c()
for(i in 1:length(checked_rows)){
	if( checked_rows[i] == TRUE){
	wanted = i
	all_wanted = c(all_wanted, wanted)
	}}
all_wanted <- as.numeric(all_wanted)

dds_larger10 = ddsFullCountTable[c(all_wanted), ]

#set the somata as the wildtype

dds_larger10$condition <- relevel(dds_larger10$condition, "Somata" )

#test differential expression for raw expression data
analyzed_raw <- DESeq(dds_larger10)
results_raw <- results(analyzed_raw)

#test which genes are significantly interesting
sum( results_raw$padj < 0.05, na.rm=TRUE ) #4207
Raw_signif <- results_raw[ which(results_raw$padj < 0.05 ), ]

# export data for GOrilla
	#export all genes
	all_genes = rownames(results_raw)
	write.table(all_genes, "all_genes.txt", sep= " ", row.names = FALSE, col.names = FALSE)
	
	#upregulated genes
	positive_fold = rownames(Raw_signif[which(Raw_signif$log2FoldChange > 0), ])
	write.table(positive_fold, "positivechange_genes.txt", sep=" ", row.names = FALSE, col.names = FALSE)
	
	#downregulated genes
	negative_fold = rownames(Raw_signif[which(Raw_signif$log2FoldChange < 0), ])
	write.table(negative_fold, "negativechange_genes.txt", sep=" ", row.names = FALSE, col.names = FALSE)


###### Generating Plots



##log transform for plots
#plotting
pdf("PlotMA.pdf")
plotMA( results_raw, ylim = c(-1, 1) )
dev.off()

pdf("plotdispEst.pdf")
plotDispEsts( analyzed_raw, ylim = c(1e-6, 1e1) )
dev.off()

#results significant pvals
pdf("hist_pval_sig.pdf")
hist(Raw_signif$padj,breaks = 50, col="grey" )
dev.off()

#results raw pvals
pdf("hist_pval_all.pdf")
hist(results_raw$padj,breaks = 50, col="grey" )
dev.off()

##mayyybe for changed data

#normalize test data
norm <- estimateSizeFactors(results_raw)
analyzed_norm <- DESeq(norm)
results_norm <- results(analyzed_norm)
size_factors_norm <- sizeFactors(analyzed_norm)

#log transform results
 log <- rlog(results_raw) 
analyzed_log <- DESeq(log)
results_log <- results(analyzed_log)

#### works until here


#####################################
#check how deseq has evolved over time


dds$condition <- relevel (dds$condition, ref = "WT”) 


 dds <- DESeq(dds)  
norm <- estimateSizeFactors(dds)
  write.table(counts(norm, normalized=TRUE), paste(project,"RPF_normalized.csv", sep="_"), col.names = T, sep = ",") 


 rld <- rlog(dds) 
pdf(paste(project,"RPF_PCA.pdf", sep="_"))
 plotPCA(rld, intgroup = c("condition", "rep")) 
data <- plotPCA(rld, intgroup=c("condition", "rep"), returnData=TRUE) 
percentVar <- round(100 * attr(data, "percentVar"))
 ggplot(data, aes(PC1, PC2, color = condition, shape = rep)) +   geom_point(size=3) +   coord_fixed(ratio = 1) +   xlim (-10, 10) +   ylim (-10, 10) +   xlab(paste0("PC1: ",percentVar[1],"% variance")) +   ylab(paste0("PC2: ",percentVar[2],"% variance")) 
dev.off () 


