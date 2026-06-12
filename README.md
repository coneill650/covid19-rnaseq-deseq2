# tcga-luad-differential-expression

## Objective
The goal of this project is to identify the genes and biological pathways that are most significantly altered in Lung Adenocarcinoma (LUAD) tumors compared to normal lung tissue.

# TCGA Lung Adenocarcinoma Differential Expression Analysis

A reproducible RNA-seq analysis pipeline using TCGA LUAD data.

## Dataset

The Cancer Genome Atlas (TCGA-LUAD)

## Methods

- TCGAbiolinks
- DESeq2
- PCA
- Volcano plot
- Heatmap
- Gene Ontology enrichment
- KEGG enrichment

## Key Results



## Repository Structure

tcga-luad-differential-expression/

├── README.md
├── LICENSE
├── .gitignore
├── renv.lock
│
├── data/
│   ├── raw/
│   └── processed/
│
├── scripts/
│   ├── 01_download_tcga_data.R
│   ├── 02_prepare_counts.R
│   ├── 03_differential_expression.R
│   ├── 04_visualizations.R
│   └── 05_pathway_analysis.R
│
├── figures/
│   ├── pca_plot.png
│   ├── volcano_plot.png
│   ├── heatmap_top50.png
│   ├── enrichment_barplot.png
│   └── enrichment_dotplot.png
│
├── results/
│   ├── deseq2_results.csv
│   ├── significant_genes.csv
│   └── enrichment_results.csv
│
└── report/
    └── luad_analysis.Rmd

## Reproducibility

```r
renv::restore()
