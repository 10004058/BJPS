# BJPS
This repository contains the data and analysis pipeline used to perform a large-scale concept analysis of ANCESTRY in genomics research. The workflow combines corpus linguistics, knowledge graph extraction, and LLM–based categorization to analyze 17,469 sentences extracted from 1,373 articles published in PLoS Genetics and PLoS Biology (2003–2025).

The repository includes the datasets, prompts, Python and R scripts, KG, embeddings, and JSON outputs. 

# Data

## CSV

Contains:

- **Corpus_subset\*.csv**: the corpus of 17469 sentences, split into 6 subsets
- **Subset3000.csv**: the 3000-sentences subset
- **Subset500.csv**: the 500-sentences subset

## Embeddings

- **\*_embeddings.csv**: the embeddings for the validated sentences, split by category

## JSON

Stores JSON outputs generated during:

- **Subset\*_Run\*.json**: the outputs of the category identification analysis based on 2474 KG
- **Run\*.json**: the outputs of the category identification analysis based on 404 KG
- **Run\*_*.json**: the corpus categorization outputs

## KG

Contains the cleaned and filtered KG, based on 500 and 3000 sentences (cf. CSV).

## Prompts

Contains:

- The Categories identification prompt
- The Categorization prompt
- The Embeddings prompt

## Prompts

Contains:

- extract_sentences.py: the script used to extract the sentences from the PDF
- kg_generation.py: the script used to obtain the KG
- plos_download_pdf: the script used to download the PDF

## R

Contains: 

- KG.R: the script used to create the 500- and 3000-sentences subsets and analyse the KG extracted from these subsets
- categorization_analysis.R: the script used to retrieve the categorization outputs and analyse then
- centroids_from_all_sentences.R: the script used to compute the centroids from the embeddings of all sentences, create the category subsets and compare these subsets to the centroids
- centroids_from_validated_sentences.R: the script used to compute the centroids from the embeddings of validated sentences, create the category subsets and compare these subsets to the centroids
- collocations.R: the script used to compute the collocations found in the corpus
- explicit_definitions.R: the script used to look for explicit definition in the corpus
- filter_sentences.R: the script used to load the CSV with all the sentences and filter them to retain only those containing ancest-
- permanova.R: the script used to perform the PERMANOVA using the embeddings
- statistical_testing_from_all_sentences: the script used to test for statistical significance in the cosine similarities between a category subset and the competing centroids (computed from all sentences)
- statistical_testing_from_validated_sentences: the script used to test for statistical significance in the cosine similarities between a category subset and the competing centroids (computed from validated sentences)

