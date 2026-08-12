# Script 3: Differential Expression

## Packages needed:
library(DESeq2)

## Workflow:

### Building the metadata:
metadata <- data.frame(sample = pheno$title,
                       condition = pheno$`disease state:ch1`,
                       stringsAsFactors = FALSE)
rownames(metadata) <- metadata$sample

### Removing the one Convalescent sample from our metadata:
keep_samples <- metadata$condition != "Convalescent"
metadata <- metadata[keep_samples, ]
count_matrix <- count_matrix[, keep_samples]
table(metadata$condition)

### Removing genes with very little expression from our data:
keep_genes <- rowSums(count_matrix >= 10) >= 3
filtered_counts <- count_matrix[keep_genes, ]
dim(filtered_counts)

### Building the DESeq2 object:
metadata$condition <- factor(metadata$condition,
                             levels = c("Healthy", "COVID-19"))
dds <- DESeqDataSetFromMatrix(countData = filtered_counts,
                              colData = metadata,
                              design = ~ condition)

### Running DESeq2:
dds <- DESeq(dds)
res <- results(dds)
summary(res)

### Generating the plot from DESeq2 analysis:
vsd <- vst(dds, blind = FALSE)
png("figures/pca_plot.png", width = 1200, height = 900)
plotPCA(vsd, intgroup = "condition")
dev.off()

### Getting the dimensions of the filtered counts:
dim(filtered_counts)