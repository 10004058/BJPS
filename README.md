# BJPS

This repository contains the datasets, prompts, scripts, and outputs used to perform a large-scale concept analysis of **ANCESTRY** in the genomics literature. The analysis combines corpus creation, collocation analysis, knowledge graph (KG) extraction, Large Language Model (LLM)-based semantic categorization, embedding analysis, and statistical testing on a corpus of **17,469 sentences** extracted from **1,373** articles published in *PLoS Genetics* and *PLoS Biology* (2003–2025).

## Workflow

The analysis pipeline consists of the following steps:

1. Download the article corpus
2. Extract sentences containing the root *ancestr-*
3. Search for explicit definitions and compute collocations
4. Generate KG from representative sentence subsets
5. Identify definitional categories using an LLM
6. Categorize the corpus
7. Generate sentence embeddings
8. Perform statistical analyses

## Repository Structure

```text
BJPS/
├── CSV/                  # Corpora and sentence subsets
├── Embeddings/           # Sentence embeddings
├── JSON/                 # LLM outputs
├── KG/                   # KG
├── Prompts/              # Prompt notebooks
├── Python/               # Data extraction and KG generation
├── R/                    # Corpus and subsets creation, explicit definition extraction, collocation, categorization, and embeddings analyses
└── Supplementary Data/   # Supplementary material
```

## Data

### CSV

**Corpus_subset\*.csv**<br>
Complete corpus (17,469 sentences), split into 6 subsets.

**Subset3000.csv**<br>
Random subset of 3000 sentences used for knowledge graph extraction and categories identification.

**Subset500.csv**<br>
Random subset of 500 sentences used for knowledge graph extraction and categories identification.

### Data

**article_counts.xlsx**<br>
Corpus statistics for the concepts ANCESTRY, RACE, and ETHNICITY.

**corpus_categorization.xlsx**<br>
Reformatted output of the categorization task for the consensus run.

**explicit_definitions.txt**<br>
Explicit definitions of ANCESTRY identified in the corpus.

### Embeddings

**\*_embeddings.csv**<br>
The embeddings for the validated sentences, split by category.

### JSON

**Subset\*_Run\*.json**<br>
Category identification outputs (3 runs) generated from the 2,474 KG containing *ancest-*.

**Run\*.json**<br>
Category identification outputs (3runs) generated from the 404 KG containing *ancest-*.

**Run\*_*.json**<br>
LLM categorization outputs (3 runs) for the complete corpus, split into 6 subsets.

### KG

**\*KG.txt**<br>
Cleaned and filtered KG generated from the 500- and 3,000-sentence subsets.

### Prompts

**CategoriesIdentificationPrompt.ipynb**<br>
Identifies definitional categories from the KG.

**CategorizationPrompt.ipynb**<br>
Categorizes sentences into the identified definitional categories.

**EmbeddingsPrompt.ipynb**<br>
Generates sentence embeddings.

### Python scripts

**extract_sentences.py**<br>
Extracts sentences from downloaded PDFs.

**kg_generation.py**<br>
Generates knowledge graphs from sentence subsets.

**plos_download_pdf**<br>
Downloads articles from the *PLoS Biology* and *PLoS Genetics*.

### R scripts

**KG.R**<br>
Creates the 500- and 3,000-sentence subsets, cleans and analyses the resulting knowledge graphs.

**categorization_analysis.R**<br>
Retrieves and analyses the LLM categorization outputs.

**centroids_from_all_sentences.R**<br>
Computes embedding centroids from all sentences and compares category subsets with each centroid.

**centroids_from_validated_sentences.R**<br>
Computes embedding centroids from the manually validated sentences and compares category subsets with each centroid.

**collocations.R**<br>
Computes collocations for occurrences of *ancestr-* within the corpus.

**explicit_definitions.R**<br>
Identifies explicit explicit definitions of ANCESTRY in the corpus.

**filter_sentences.R**<br>
Loads the CSV with all sentences and filters them to retain only those containing *ancestr-*.

**permanova.R**<br>
Performs a PERMANOVA on the sentence embeddings.

**statistical_testing_from_all_sentences**<br>
Performs statistical tests on cosine similarities using centroids computed from all sentences.

**statistical_testing_from_validated_sentences**<br>
Performs statistical tests on cosine similarities using centroids computed from the validated sentence.

