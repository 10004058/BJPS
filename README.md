# BJPS
This repository contains the data and analysis pipeline used to perform a large-scale concept analysis of ANCESTRY in genomics research. The workflow combines corpus linguistics, knowledge graph extraction, and LLM–based categorization to analyze 17,469 sentences extracted from 1,373 articles published in PLoS Genetics and PLoS Biology (2003–2025).

The repository includes the datasets, prompts, Python and R scripts, KG, embeddings, and JSON outputs. 

# Data

## CSV

Contains:

- The corpus of 17469 sentences, split into 6 subsets
- The 3000-sentences subset
- The 500-sentences subset

## JSON

Stores structured outputs generated during:

category identification
document categorization
repeated experimental runs

## Embeddings

Contains semantic embeddings used for downstream analyses.
