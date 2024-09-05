# GWAS, LD, and Wright-Fisher Process Analysis

This repository contains R scripts for conducting a Genome-Wide Association Study (GWAS), Linkage Disequilibrium (LD) analysis, and a Wright-Fisher process simulation. It also includes the figures generated from these analyses.

## Table of Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Files and Directory Structure](#files-and-directory-structure)
- [Usage Instructions](#usage-instructions)
- [Results](#results)

## Overview
This project demonstrates the following:
1. Genome-Wide Association Study (GWAS) using R.
2. Linkage Disequilibrium (LD) analysis stratified by different population groups.
3. Simulation of the Wright-Fisher process for different population sizes and starting mutant frequencies.

## Dependencies
To run the scripts, you will need the following R packages:
- `snpStats`
- `hexbin`
- `ggplot2`

Install the dependencies using the following R command:
```r
install.packages(c("snpStats", "hexbin", "ggplot2"))
