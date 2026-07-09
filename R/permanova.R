################################################################################

# This R script:
# Performs a PERMANOVA

################################################################################

library(dplyr)
library(purrr)
library(jsonlite)
library(tidyr)
library(lsa)
library(ggplot2)
library(tidyverse)
library(writexl)
library(readxl)
library(openxlsx)
library(vegan)
library(proxy)

################################################################################

#Retrieve sentences + categorization
corpus_categorization_mapping <- read_excel("corpus_categorization.xlsx")
#Keep only the columns corresponding to the sentences and the category
corpus_categorization_mapping <- corpus_categorization_mapping[,-c(2,4)]

#Retrieve sentences + embeddings
input_corpus_occurrences <- read_csv("embeddings_corpus_occurrences.csv")

#Rename the columns
names(corpus_categorization_mapping) <- c("Occurrences","Category")
names(input_corpus_occurrences) <- c("Occurrences","Embeddings")

#Split the embeddings to separate columns
corpus_list <- map(input_corpus_occurrences$Embeddings,fromJSON)
corpus_matrix <- do.call(rbind,corpus_list)
corpus_df <- as.data.frame(corpus_matrix)
colnames(corpus_df) <- paste0("dim_",seq_len(ncol(corpus_df)))

#Combine
combined_corpus <- cbind(corpus_categorization_mapping,corpus_df)
#Remove rows with "Error", NA and "Unclear"
combined_corpus <- combined_corpus[complete.cases(combined_corpus) & !is.na(combined_corpus$Category) & combined_corpus$Category != "Error"  & combined_corpus$Category != "Unclear",]

##Order by category
category_order <- c(
  "Ancestry in Evolution and Lineage Relationships",
  "Genetic Ancestry and Health",
  "Human Ancestry, Identity, Geography, and Demography",
  "Ancestry-Inference Tools, Markers, and Analytic Approaches",
  "Ancestry in Population Structure and Genetic Variation"
)

#Create a matrix with the embeddings
combined_corpus <- combined_corpus %>%
  mutate(Category = factor(Category, levels = category_order)) %>%
  arrange(Category)
embedding_matrix <- as.matrix(combined_corpus[,3:1538])

#Compute the matrix of cosine distance
dist_mat <- proxy::dist(embedding_matrix, method = "cosine")

#Perform the PERMANOVA
adonis2(
  dist_mat ~ Category,
  data = combined_corpus,
  permutations = 500
)