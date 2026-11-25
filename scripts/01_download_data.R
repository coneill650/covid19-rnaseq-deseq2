# Script 1: Download and Inspect Data

## Packages needed:
library(GEOquery)
library(tidyverse)

## Workflow:

### Downloading the raw counts and storing them into usable objects:
gse <- getGEO("GSE152418", GSEMatrix = TRUE)
eset <- gse[[1]]
expr_matrix <- exprs(eset)
dim(expr_matrix)
summary(as.vector(expr_matrix))
head(expr_matrix[,1:5])
pheno <- pData(eset)
colnames(pheno)

### Obtaining the supplementary files for this project:
dir.create("data/raw", recursive = TRUE, showWarnings = FALSE)
getGEOSuppFiles("GSE152418", makeDirectory = TRUE, baseDir = "data/raw")
list.files("data/raw/GSE152418", recursive = TRUE)

### Getting a count matrix from the raw counts:
counts <- read.delim(file.path("data",
                               "raw",
                               "GSE152418",
                               "GSE152418_p20047_Study1_RawCounts.txt.gz"),
                     check.names = FALSE)

dim(counts)
head(counts)
colnames(counts)[1:10]
