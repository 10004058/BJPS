# BJPS
This repository contains the data and analysis pipeline used to perform a large-scale concept analysis of ANCESTRY in genomics research. The workflow combines corpus linguistics, knowledge graph extraction, and LLM–based categorization to analyze 17,469 sentences extracted from 1,373 articles published in PLoS Genetics and PLoS Biology (2003–2025).

The repository includes the datasets, prompts, Python and R scripts, KG, embeddings, and JSON outputs. 

# Repository Structure

```text
BJPS/
│
├── CSV/
│   ├── Corpus_subset*.csv
│   ├── Subset3000.csv
│   └── Subset500.csv
│
├── Embeddings/
│   ├── embeddings_*.csv
│   └── split_embeddings_corpus.R
│
├── JSON/
│   ├── CategoriesIdentification/
|       ├── From404KG/
|           └── Run*.json
|       └── From2474KG/
|           └── Subset*_Run*.json
│   └── Categorization/
|       └── Run*_*.json
│
├── KG/
│   └── Knowledge graph outputs
│
├── Prompts/
│   └── Prompt templates used for LLM inference
│
├── PythonScripts/
│   ├── extract_sentences.py
│   ├── kg-generation.py
│   └── plos_download_pdf.py
│
└── RScripts/
    ├── Analysis scripts
    └── Visualization scripts
```

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
