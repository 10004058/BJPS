# BJPS
This repository contains input and output data for a large-scale concept analysis of ANCESTRY in scientific literature. The workflow combines corpus creation, collocation analysis, KG extraction, and LLM–based categorization to analyze 17,469 sentences extracted from 1,373 articles published in PLoS Genetics and PLoS Biology (2003–2025).

## Data

### CSV

**Corpus_subset\*.csv**<br>
The corpus of 17469 sentences, split into 6 subsets

**Subset3000.csv**<br>
The 3000-sentences subset

**Subset500.csv**<br>
The 500-sentences subset

### Data

**article_counts.xlsx**<br>
Various statistics on the corpus for ancestry, race and ethnicity

**corpus_categorization.xlsx**<br>
The reformatted output of the categorization task for the consensus run

**explicit_definitions.txt**<br>
Various statistics on the corpus for ancestry, race and ethnicity

### Embeddings

**\*_embeddings.csv**<br>
The embeddings for the validated sentences, split by category

### JSON

**Subset\*_Run\*.json**<br>
The outputs of the category identification analysis based on 2474 KG

**Run\*.json**<br>
The outputs of the category identification analysis based on 404 KG

**Run\*_*.json**<br>
The corpus categorization outputs

### KG

**\*KG.txt**<br>
The cleaned and filtered KG, based on 500 and 3000 sentences (cf. CSV).

### Prompts

**CategoriesIdentificationPrompt.ipynb**<br>
The prompt used to identify definitional categories

**CategorizationPrompt.ipynb**<br>
The prompt used to categorize a set of sentences

**EmbeddingsPrompt.ipynb**<br>
The prompt used to obtain the embeddings from a set of sentences

### Python scripts

**extract_sentences.py**<br>
The script used to extract the sentences from the PDF

**kg_generation.py**<br>
The script used to obtain the KG

**plos_download_pdf**<br>
The script used to download the PDF

### R scripts

**KG.R**<br>
The script used to create the 500- and 3000-sentences subsets and analyse the KG extracted from these subsets

**categorization_analysis.R**<br>
The script used to retrieve the categorization outputs and analyse then

**centroids_from_all_sentences.R**<br>
The script used to compute the centroids from the embeddings of all sentences, create the category subsets and compare them to the centroids

**centroids_from_validated_sentences.R**<br>
The script used to compute the centroids from the embeddings of validated sentences, create the category subsets and compare them to 
the centroids

**collocations.R**<br>
The script used to compute the collocations found in the corpus

**explicit_definitions.R**<br>
The script used to look for explicit definition in the corpus

**filter_sentences.R**<br>
The script used to load the CSV with all the sentences and filter them to retain only those containing ancest-

**permanova.R**<br>
The script used to perform the PERMANOVA using the embeddings

**statistical_testing_from_all_sentences**<br>
The script used to test for statistical significance in the cosine similarities between a category subset and the competing 
centroids (computed from all sentences)

**statistical_testing_from_validated_sentences**<br>
The script used to test for statistical significance in the cosine similarities between a category subset and the competing 
centroids (computed from validated sentences)

