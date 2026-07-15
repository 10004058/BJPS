# BJPS

This repository contains the datasets, prompts, scripts, and outputs used to perform a large-scale concept analysis of **ANCESTRY** in the genomics literature. The analysis combines corpus creation, collocation analysis, knowledge graph (KG) extraction, Large Language Model (LLM)-based semantic categorization, embedding analysis, and statistical testing on a corpus of **17,469 sentences** extracted from **1,373** articles published in *PLoS Genetics* and *PLoS Biology* (2003–2025).

## Workflow

The analysis pipeline consists of the following steps:

1. Download the corpus and extract sentences containing the term ancest-.
2. Look for explicit definitions and compute collocations.
3. Create the subsets for the KG extraction, run an analysis on the HPC to produce the KG, clean and filter the KG, and use the KG to obtain definitional categories.
4. Categorise the 3,000-sentences subset and the corpus and analyse the categorization outputs
5. Reformate the corpus categorization output
6. Generates the embeddings, compute the centroids, compare the embeddings of a category subset to the above-computed centroids, and test for statistical significance in the cosine similarities computed between a category subset and the competing centroids
7. Perform a PERMANOVA

