# BJPS

This repository contains the datasets, prompts, scripts, and outputs used to perform a large-scale concept analysis of **ANCESTRY** in the genomics literature. The analysis combines corpus creation, collocation analysis, knowledge graph (KG) extraction, Large Language Model (LLM)-based semantic categorization, embedding analysis, and statistical testing on a corpus of **17,469 sentences** extracted from **1,373** articles published in *PLoS Genetics* and *PLoS Biology* (2003–2025).

## Workflow

The analysis pipeline consists of the following steps:

*Note: Each folder contains a corresponding README file detailing its contents.*

### Step 1

* Download the corpus.

* Extract sentences containing the term ancest-.

### Step 2

* Look for explicit definitions.

* Compute the collocations.

### Step 3 

* Create the subsets for the KG extraction.

* Run an analysis on the HPC to produce the KG.

* Clean and filter the KG.

* Use the KG to obtain definitional categories.

### Step 4

* Categorise the 3,000-sentences subset and the corpus.

* Analyse the categorization outputs.

### Step 5

* Reformate the corpus categorization output.

### Step 6

* Generates the embeddings.

* Compute the centroids.

* Compare the embeddings of a category subset to the above-computed centroids.

* Test for statistical significance in the cosine similarities computed between a category subset and the competing centroids.

### Step 7

* Perform a PERMANOVA.

