################################################################################

# This R script:
# Loads the CSV containing the sentences from the PDF files 
# Cleans and filters them

################################################################################

library(dplyr)
library(stringr)
library(readr)

################################################################################

#Read the CSV with all the sentences
articles_sentences_ancestry <- read_csv("Corpus.csv")

#Define the keyword
keyword_pattern_ancestry <- "\\bancestr\\w*"

#Clean the quotes
articles_sentences_clean_ancestry <- articles_sentences_ancestry %>%
  # Filter publisher, journal, metadata
  filter(!grepl("DOI|PLOS|University|Citation|Copyright|Springer|Elsevier|Wiley|PMC|PubMed|arXiv|BMC|Frontiers|Taylor & Francis|SAGE", sentence, ignore.case = TRUE)) %>%
  filter(!grepl("(doi|vol\\.|pp\\.|In:|ISSN|ISBN)", sentence, ignore.case = TRUE)) %>%  
  # Filter citation patterns
  filter(!grepl("\\(?\\b(19|20)\\d{2}[a-z]?\\b\\)?", sentence)) %>%  # (e.g. 1993b, (2021a))
  filter(!grepl("\\b\\d+\\s*(\\(\\d*\\))?:\\s*\\d+(?:[-–:]\\d+)?\\b", sentence)) %>%  # (e.g. 12(3): 45–56)
  filter(!grepl("et al\\.", sentence, ignore.case = TRUE)) %>%  # author citations
  # Filter contact info, URLs, or special characters
  filter(!grepl("@", sentence)) %>%                                           
  filter(!grepl("https?://", sentence, ignore.case = TRUE)) %>%  
  filter(!grepl("http?://", sentence, ignore.case = TRUE)) %>% 
  filter(!grepl(">", sentence)) %>%                                      
  # Filter section titles, figure/table captions, references, etc.
  filter(!grepl("^(Figure|Fig\\.|Table|Supplementary)\\b", sentence, ignore.case = TRUE)) %>%
  filter(!grepl("^(Introduction|Abstract|Materials|Methods|Results|Discussion|Conclusion|References|Acknowledgments)\\b", sentence, ignore.case = TRUE)) %>%
  # Remove sentences that start with lowercase (ignore quotes, spaces, or parentheses)
  filter(!grepl("^['\"(\\s]*[a-z]", sentence)) %>%
  # Filter very short or meaningless sentences
  filter(str_count(sentence, "\\S+") >= 4)

#Filter by keyword
filtered_ancestry <- articles_sentences_clean_ancestry %>%
  filter(str_detect(sentence, regex(keyword_pattern_ancestry,ignore_case=T)))

#Add a column for the year
filtered_ancestry$year <- sub(".*_(\\d{4})-.*","\\1",filtered_ancestry$filename)

#Add a column for the journal
filtered_ancestry$journal <- sub("^([^_]+)_.*", "\\1", filtered_ancestry$filename)
