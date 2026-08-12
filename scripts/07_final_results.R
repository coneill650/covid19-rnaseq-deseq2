# Script 7: Final Results

## Workflow:

### Getting the summary of the results:
summary(res)

### Defining significance for what constitutes a significant gene:
sig_genes <- subset(as.data.frame(res), padj < 0.05 & abs(log2FoldChange) > 1)
nrow(sig_genes)

### Exploratory analysis:
head(sig_genes[order(sig_genes$padj),], 20)
head(as.data.frame(ego_bp), 20)

### Obtaining the top 20 genes by differential expression:
top_genes_readme <- res_df %>%
  filter(padj < 0.05, abs(log2FoldChange) >= 1) %>%
  arrange(padj) %>%
  select(SYMBOL, ENSEMBLID, baseMean, log2FoldChange, padj) %>%
  slice_head(n = 20)
write.csv(top_genes_readme,
          "results/top_20_genes_diff_expression.csv",
          row.names = FALSE)