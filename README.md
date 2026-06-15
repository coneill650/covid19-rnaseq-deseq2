# covid19-rnaseq-deseq2

## Objective
The goal of this project is to...

# Differential Expression Analysis

A reproducible RNA-seq analysis pipeline using...

## Dataset

## Methods

## Key Results

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
