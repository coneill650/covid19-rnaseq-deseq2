# Script 5: Heatmap of the 50 most significantly different genes in normal vs. COVID-19 patients

## Packages needed:
library(pheatmap)
library(RColorBrewer)

## Workflow:

### Creating the results data frame for the top 50 genes according to most significant adjusted p-values
res_df <- as.data.frame(res) %>%
  rownames_to_column("ENSEMBLID") %>%
  filter(!is.na(padj)) %>%
  add_gene_symbols() %>%
  arrange(padj)
top50 <- res_df %>%
  slice_head(n = 50)

### Getting the heatmap matrix for the top 50 genes:
top50_genes <- top50$ENSEMBLID
top50_labels <- top50$gene_label
heatmap_matrix <- assay(vsd)[top50_genes, ]
rownames(heatmap_matrix) <- make.unique(top50_labels)

### Getting the Z-score for each gene:
heatmap_matrix_z <- t(scale(t(heatmap_matrix)))
annotation_col <- data.frame(Condition = metadata$condition)
rownames(annotation_col) <- rownames(metadata)
annotation_col <- annotation_col[colnames(heatmap_matrix_z), , drop = FALSE]

### Generating the heatmap with Z-scores:
pheatmap(heatmap_matrix_z, annotation_col = annotation_col,
         show_colnames = TRUE, show_rownames = TRUE,
         cluster_rows = TRUE, cluster_cols = TRUE,
         fontsize_row = 7, fontsize_col = 7, angle_col = 90,
         color = colorRampPalette(rev(brewer.pal(n = 11, name = "RdBu")))(100),
         main = "Top 50 Differentially Expressed Genes",
         filename = "figures/heatmap_top50.png",
         width = 11, height = 9)