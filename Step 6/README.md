# Step 6

This folder contains the data and scripts used to:

* Generates the embeddings
* Compute the centroids
* Compare the embeddings of a category subset to the above-computed centroids
* Test for statistical significance in the cosine similarities computed between a category subset and the competing centroids

## Contents

### CSV files

**`embeddings_*.csv`**<br>
The embeddings for the validated sentences, split by category.

**`validated_*.csv`**<br>
The validated sentences, split by category.

### XLSX files

**`validated_all.xlsx`**<br>
The sentences selected after validation.

### Prompt

**`EmbeddingsPrompt.ipynb`**<br>
Generates sentence embeddings.

### R scripts

**`create_subset_category.R`**<br>
Creates the subsets of validated sentences and saves them into separate CSV files. 

**`centroids_from_validated_sentences.R`**<br>
Computes the category centroids using validated sentence embeddings, creates the category subsets based on the categorization and embeddings outputs, compares the embeddings of a category subset to the above-computed centroids, and tests for statistical significance in the cosine similarities computed between a category subset and the competing centroids
 
**`centroids_from_all_sentences.R`**<br>
Computes the category centroids using all sentence embeddings, creates the category subsets based on the categorization and embeddings outputs, compares the embeddings of a category subset to the above-computed centroids, and tests for statistical significance in the cosine similarities computed between a category subset and the competing centroids

