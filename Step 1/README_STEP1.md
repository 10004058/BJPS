# Data

This folder contains the data and scripts used to:

* Download the corpus.
* Extract sentences containing the term *ancest-*.

## Contents

### CSV files

**`Corpus_subset*.csv`**<br>
Contains the complete corpus of **17,469 sentences**, split into six subsets. The corpus was divided into multiple files because the full dataset was too large to upload as a single file.

### Python scripts

**`extract_sentences.py`**<br>
Extracts sentences from downloaded PDF articles.

**`plos_download_pdf.py`**<br>
Downloads articles from *PLoS Biology* and *PLoS Genetics*.

### R scripts

**`filter_sentences.R`**<br>
Loads the complete sentence corpus and filters it to retain only sentences containing *ancestr-*.
