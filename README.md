# COVID-19 Differential Expression Analysis

## Objective
The goal of this project is to identify the genes and pathways that are altered in COVID-19 patients compared with healthy controls.

## Workflow
Data Acquisition
→ QC
→ DESeq2
→ Visualization
→ Enrichment Analysis

## Progress
✓ Downloaded GEO data
✓ Parsed count matrix
✓ Built metadata
✓ Filtered genes
✓ Ran DESeq2
✓ Generated PCA

## Results

## Repository Structure

covid19-rnaseq-deseq2/

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
│   ├── 01_download_data.R
│   ├── 02_qc_and_preprocessing.R
│   ├── 03_deseq2_analysis.R
│   ├── 04_visualization.R
│   └── 05_enrichment_analysis.R
│
├── figures/
│
├── results/
│
├── report/
│   └── covid_analysis.Rmd
│
└── docs/
    └── dataset_notes.md

## Reproducibility

```r
renv::restore()
