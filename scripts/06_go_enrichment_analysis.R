# Script 6: GO Enrichment Analysis

## Packages needed:
library(clusterProfiler)
library(org.Hs.eg.db)
library(enrichplot)

## Workflow:

### Filtering out genes that are missing adjusted p-value and/or log2-fold change
dir.create("results", showWarnings = FALSE)
dir.create("figures", showWarnings = FALSE)
res_df <- as.data.frame(res) %>%
  rownames_to_column("ENSEMBLID") %>%
  filter(!is.na(padj), !is.na(log2FoldChange))

### Keeping only genes that have a significant adjusted p-value and a log2-fold change of at least 1 in either direction:
sig_genes <- res_df %>%
  filter(padj < 0.05, abs(log2FoldChange) >= 1)

### Removing ENSEMBL version numbers if present:
sig_ensembl <- gsub("\\..*", "", sig_genes$ENSEMBLID)

### Performing the GO enrichment analysis:
gene_map <- bitr(sig_ensembl,
                 fromType = "ENSEMBL", toType = c("ENTREZID", "SYMBOL"),
                 OrgDb = org.Hs.eg.db)
ego_bp <- enrichGO(gene = gene_map$ENTREZID, OrgDb = org.Hs.eg.db,
                   keyType = "ENTREZID", ont = "BP", pAdjustMethod = "BH",
                   pvalueCutoff = 0.05, qvalueCutoff = 0.05, readable = TRUE)
go_results <- as.data.frame(ego_bp)
write.csv(go_results, "results/go_bp_enrichment_results.csv", row.names = FALSE)

### Creating a dotplot of the results:
dotplot_go <- dotplot(ego_bp, showCategory = 20) +
  labs(title = "GO Biological Process Enrichment",
       subtitle = "COVID-19 vs Healthy Controls") +
  theme_classic(base_size = 13)
ggsave("figures/go_bp_dotplot.png",
       dotplot_go, width = 18, height = 14, dpi = 300)

### Creating a barplot of the results:
barplot_go <- barplot(ego_bp, showCategory = 20) +
  labs(title = "Top Enriched GO Biological Processes",
       subtitle = "COVID-19 vs Healthy Controls") +
  theme_classic(base_size = 13)
ggsave("figures/go_bp_barplot.png", barplot_go,
       width = 18, height = 14, dpi = 300)