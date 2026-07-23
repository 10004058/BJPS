# Step 4

This folder contains the data and scripts used to:

* Categorise the 3,000-sentences subset and the corpus
* Analyse the categorization outputs

## Contents

### Data

#### CSV files

**`Corpus_subset*.csv`**<br>
Contains the complete corpus of **17,469 sentences**, split into six subsets.<br>
The corpus was divided into multiple files because the full dataset was too large to upload as a single file.

**`Subset3000.csv`**<br>
Random subset of 3000 sentences used for KG extraction and categories identification.

### Prompt

**`CategorizationPrompt.ipynb`**<br>
Categorizes sentences into the identified definitional categories.

### Scripts

#### R 

**`categorization_analysis_corpus.R`**<br>
Retrieves and analyses the LLM categorization outputs of the 3,000-sentences subset (the consensus runs) to compare the categories based on 404 and 2,474 KG.

**`categorization_analysis_subsets.R`**<br>
Retrieves and analyses the LLM categorization output of the whole corpus for the consensus run.

### Outputs

#### JSON files

**`Run*_*.json`**<br>
LLM categorization outputs (3 runs) for the complete corpus, split into 6 subsets.

**`Run_based_on_*KG.json`**<br>
LLM categorization outputs (consensus run) for the 3,000-sentences subset.

#### XLSX files

**`categorization_over_time.xlsx`**<br>
Relative distribution of ancestry-related definitional categories over time in PLOS Genetics and PLOS Biology. 
