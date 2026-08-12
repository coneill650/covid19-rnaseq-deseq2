# Script 4: Volcano Plot

## Packages needed:
library(ggrepel)
library(AnnotationDbi)
library(org.Hs.eg.db)

## Workflow:

### Creating a function to add the gene symbols to the volcano plot:
add_gene_symbols <- function(res_df) {
  res_df$ENSEMBLID_clean <- gsub("\\..*", "", res_df$ENSEMBLID)
  
  gene_symbols <- AnnotationDbi::mapIds(
    org.Hs.eg.db,
    keys = res_df$ENSEMBLID_clean,
    column = "SYMBOL",
    keytype = "ENSEMBL",
    multiVals = "first"
  )
  
  res_df$SYMBOL <- gene_symbols[res_df$ENSEMBLID_clean]
  
  res_df$gene_label <- ifelse(
    is.na(res_df$SYMBOL) | res_df$SYMBOL == "",
    res_df$ENSEMBLID,
    res_df$SYMBOL
  )
  
  res_df
}

### Creating a data frame from the DESeq2 results:
res_df <- as.data.frame(res) %>%
  rownames_to_column("ENSEMBLID") %>%
  filter(!is.na(padj), !is.na(log2FoldChange)) %>%
  add_gene_symbols() %>%
  mutate(neg_log10_padj = -log10(padj),
         significance = case_when(
           padj < 0.05 & log2FoldChange >= 1  ~ "Up in COVID-19",
           padj < 0.05 & log2FoldChange <= -1 ~ "Down in COVID-19",
           TRUE ~ "Not significant"))

### Getting the top genes for change in expression between patients with and without COVID-19
top_genes <- res_df %>%
  filter(significance != "Not significant") %>%
  arrange(padj) %>%
  slice_head(n = 15)

### Creating the volcano plot:
volcano_plot <- ggplot(res_df,aes(x = log2FoldChange, y = neg_log10_padj)) +
  geom_point(aes(color = significance), alpha = 0.65, size = 1.4) +
  geom_vline(xintercept = c(-1, 1), linetype = "dashed") +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed") +
  geom_text_repel(data = top_genes, aes(label = gene_label),
                  size = 3, max.overlaps = 20,
                  box.padding = 0.4, point.padding = 0.3) +
  scale_color_manual(values = c(
      "Up in COVID-19" = "#4CBB17",
      "Down in COVID-19" = "red",
      "Not significant" = "gray70")) +
  labs(
    title = "Differential Gene Expression in COVID-19 vs Healthy Controls",
    subtitle = "GSE152418 bulk RNA-seq analysis using DESeq2",
    x = "log2 fold change",
    y = "-log10 adjusted p-value",
    color = "Expression status") +
  theme_classic(base_size = 14) +
  theme(plot.title = element_text(face = "bold"), legend.position = "right")

volcano_plot

### Saving the volcano plot:
ggsave(filename = "figures/volcano_plot_w_gene_symbols.png",
       plot = volcano_plot, width = 9, height = 7, dpi = 300)

### Writing a symbol-annotated results table:
write.csv(res_df,
          "results/deseq2_results_with_gene_symbols.csv",row.names = FALSE)