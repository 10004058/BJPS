# Step 3

This folder contains the data and scripts used to:

* Create the subsets for the KG extraction.
* Run an analysis on the HPC to produce the KG.
* Clean and filter the KG.
* Use the KG to obtain definitional categories.

## Contents

### Data

#### TXT files

**`*KG_clean.txt`**<br>
The cleaned and filtered KG, ready to be used with the category identification prompt.

**`*KG_clean_subset*.txt`**<br>
As above, with the exception that the file has been divided into subsets, as it would otherwise have been too large to analyse.

#### CSV files

**`Subset3000.csv`**<br>
Random subset of 3000 sentences used for KG extraction and categories identification.

**`Subset500.csv`**<br>
Random subset of 500 sentences used for KG extraction and categories identification.

### Prompt

**`CategoriesIdentificationPrompt.ipynb`**<br>
Identifies definitional categories from the KG.<br>*Requires API access and LLM model gpt-4o*

### Scripts 

#### Bash

**`run.sh`**<br>
Calls kg-generation.py on the HPC.<br>*Requires HPC resources*

#### Python

**`kg-generation.py`**<br>
Generates knowledge graphs from a sentences subset.<br>*Requires HPC resources*

#### R

**`create_subset.R`**<br>
Randomly selects 500 or 3,000 sentences and saves them into a CSV file.

**`analysis_KG.R`**<br>
Cleans and filters the KG, counts how many have *ancest-* in the nodes and/or relationships and saves the cleaned KG into a TXT file. 

### Outputs

#### JSON files

**`Subset*_Run*.json`**<br>
Category identification outputs (3 runs) generated from the 2,474 KG containing *ancest-*.

**`Run*.json`**<br>
Category identification outputs (3runs) generated from the 404 KG containing *ancest-*.

#### TXT files

**`*KG_raw.txt`**<br>
The KG obtained through the HPC analysis, before cleaning and filtering.

**`*KG_raw.txt`**<br>
The KG obtained through the HPC analysis, before cleaning and filtering.

### XLSX files

**`KG_filter_examples.xlsx`**<br>
Examples to illustrate the filter applied to retain only the KG containing *ancest-*. 

**`ancestry_environment_interactions.xlsx`**<br>
Comparison of the categorization task outputs with and without the category “Ancestry–Environment Interactions” (n=3,000); categorization by OpenAI based on 404 KG. 

**`categories_identification_404KG.xlsx`**<br>
Definitional categories suggested by OpenAI across three runs, based on 404 knowledge graphs.

**`definitional_categories_from_2474KG.xlsx`**<br>
Definitional categories obtained from the clustering task by OpenAI based on 2,474 knowledge graphs.

**`definitional_categories_from_404KG.xlsx`**<br>
Definitional categories obtained from the clustering task by OpenAI based on 404 knowledge graphs.
