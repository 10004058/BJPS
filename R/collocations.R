################################################################################

# This R script:
# Computes collocations in the corpus

################################################################################

library(FactoMineR)
library(factoextra)
library(flextable)
library(GGally)
library(ggdendro)
library(igraph)
library(Matrix)
library(quanteda)
library(dplyr)
library(stringr)
library(tm)
library(tidyr)
library(SnowballC)
library(ggplot2)
library(cluster)
library(network)
library(sna)
library(tidyverse)
library(tokenizers)
library(tidytext)
library(widyr)
library(textstem)
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

#Tokenize the dataset 
subsettokzd <- quanteda::tokens(subsetclean)

#Extract the bigrams
subsetbigrams <- subsettokzd %>% 
  quanteda::tokens_remove(stopwords("en")) %>% 
  quanteda::tokens_select(pattern = "^[A-Z]", 
                          valuetype = "regex",
                          case_insensitive=F, 
                          padding=T) %>% 
  quanteda.textstats::textstat_collocations(min_count=5,tolower=F)

#Select only the bigrams containing "Ancestr"
subsetbigrams_ancestry <- subsetbigrams[grepl("\\bAncestr\\w*", subsetbigrams$collocation),]