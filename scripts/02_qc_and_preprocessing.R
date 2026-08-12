# Script 2: Quality Control

## Workflow:

### Converting the counts from Script 1 to a DESeq2-compatible matrix:
rownames(counts) <- counts$ENSEMBLID
counts <- counts[, -1]
count_matrix <- as.matrix(counts)
dim(count_matrix)

### Connecting the sample names to conditions:
colnames(pheno)
head(pheno[, 1:10])

### Filtering out low-count genes
keep <- rowSums(count_matrix >= 10) >= 3
filtered_counts <- count_matrix[keep, ]
dim(filtered_counts)

### Building a QC plot
log_counts <- log2(filtered_counts + 1)
png("figures/qc_boxplot.png", width = 1400, height = 800)
boxplot(log_counts, las = 2, outline = FALSE)
dev.off()