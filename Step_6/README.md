# Step 6

This folder contains the data and scripts used to:

* Generates the embeddings
* Compute the centroids
* Compare the embeddings of a category subset to the above-computed centroids
* Test for statistical significance in the cosine similarities computed between a category subset and the competing centroids

## Contents

### Data

#### XLSX files

**`corpus_categorization.xlsx`**<br>
Corpus categorization output, reformatted as an XLSX file. 

**`validated_all.xlsx`**<br>
The sentences selected after validation.

#### CSV files

**`validated_*.csv`**<br>
The validated sentences, split by category.

### Prompt

**`EmbeddingsPrompt.ipynb`**<br>
Generates sentence embeddings.

### Scripts

#### R

**`create_subset_category.R`**<br>
Creates the subsets of validated sentences and saves them into separate CSV files. 

**`centroids_from_validated_sentences.R`**<br>
Computes the category centroids using validated sentence embeddings, creates the category subsets based on the categorization and embeddings outputs, compares the embeddings of a category subset to the above-computed centroids, and tests for statistical significance in the cosine similarities computed between a category subset and the competing centroids
 
**`centroids_from_all_sentences.R`**<br>
Computes the category centroids using all sentence embeddings, creates the category subsets based on the categorization and embeddings outputs, compares the embeddings of a category subset to the above-computed centroids, and tests for statistical significance in the cosine similarities computed between a category subset and the competing centroids

### Outputs

#### CSV files

*Note: The file `embeddings_corpus_occurrences.csv`, which contains the embeddings for the entire corpus, could not be uploaded as it was too large.*

**`embeddings_*.csv`**<br>
The embeddings for the validated sentences, split by category.
