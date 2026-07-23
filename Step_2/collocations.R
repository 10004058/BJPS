################################################################################

# This R script:
# Computes collocations in the corpus

################################################################################

library(stringr)
library(tokenizers)
library(textstem)
library(quanteda)
library(quanteda.textstats)

################################################################################

#Remove stop words and additional custom words to remove 
data(stop_words)
custom_remove <- c("1","2","3","4","5","10","fig","figure","table","")

#Create a copy of the data and isolate the sentences
data <- filtered_ancestry
text <- paste(data[,2],collapse=" ")

#Clean the dataset
text_sentences <- text %>%
  stringr::str_squish() %>%
  tokenizers::tokenize_sentences(.) %>%
  unlist() %>%
  stringr::str_remove_all("- ") %>%
  stringr::str_replace_all("\\W"," ") %>%
  stringr::str_squish()
subsetclean <- text_sentences %>%
  stringr::str_to_title()

#Lemmatize each sentence
subsetclean_lemma <- lemmatize_strings(subsetclean)

#Tokenize
subsettokzd <- quanteda::tokens(subsetclean_lemma)

#Extract the collocations
subsetbigrams <- subsettokzd |>
  tokens_remove(stopwords("en")) |>
  textstat_collocations(
    size = 2,
    min_count = 5,
    tolower = TRUE
  )

#Filter to keep only collocations with ancestr-
subsetbigrams_ancestry <- subsetbigrams[grepl("\\bancestr\\w*", subsetbigrams$collocation),]


