################################################################################

# This R script:
# Computes the category centroids using validated sentence embeddings
# Creates the category subsets based on the categorization and embeddings outputs
# Compares the embeddings of a category subset to the above-computed centroids

################################################################################

library(dplyr)
library(purrr)
library(jsonlite)
library(tidyr)
library(lsa)
library(ggplot2)
library(tidyverse)

############################# Centroid Evolution ###############################

#Load the dataset with all the sentence and the associated embedding in R
input_evolution <- read_csv("embeddings_evolution.csv")

#Compute "Evolution" centroid
emb_evolution_list <- map(input_evolution$embedding,fromJSON)
emb_evolution_matrix <- do.call(rbind,emb_evolution_list)
emb_evolution_df <- as.data.frame(emb_evolution_matrix)
colnames(emb_evolution_df) <- paste0("dim_",seq_len(ncol(emb_evolution_df)))
centroid_evolution <- colMeans(emb_evolution_df)

############################## Centroid Health #################################

#Load the dataset with all the sentence and the associated embedding in R
input_health <- read_csv("embeddings_health.csv")

#Compute "Health" centroid
emb_health_list <- map(input_health$embedding,fromJSON)
emb_health_matrix <- do.call(rbind,emb_health_list)
emb_health_df <- as.data.frame(emb_health_matrix)
colnames(emb_health_df) <- paste0("dim_",seq_len(ncol(emb_health_df)))
centroid_health <- colMeans(emb_health_df)

############################## Centroid Identity ###############################

#Load the dataset with all the sentence and the associated embedding in R
input_identity <- read_csv("embeddings_identity.csv")

#Compute "Identity" centroid
emb_identity_list <- map(input_identity$embedding,fromJSON)
emb_identity_matrix <- do.call(rbind,emb_identity_list)
emb_identity_df <- as.data.frame(emb_identity_matrix)
colnames(emb_identity_df) <- paste0("dim_",seq_len(ncol(emb_identity_df)))
centroid_identity <- colMeans(emb_identity_df)

############################# Centroid Methods #################################

#Load the dataset with all the sentence and the associated embedding in R
input_methods <- read_csv("embeddings_methods.csv")

#Compute "Methods" centroid
emb_methods_list <- map(input_methods$embedding,fromJSON)
emb_methods_matrix <- do.call(rbind,emb_methods_list)
emb_methods_df <- as.data.frame(emb_methods_matrix)
colnames(emb_methods_df) <- paste0("dim_",seq_len(ncol(emb_methods_df)))
centroid_methods <- colMeans(emb_methods_df)

######################### Centroid Population Structure ########################

#Load the dataset with all the sentence and the associated embedding in R
input_popstruct <- read_csv("embeddings_popstruct.csv")

#Compute "PopStruct" centroid
emb_popstruct_list <- map(input_popstruct$embedding,fromJSON)
emb_popstruct_matrix <- do.call(rbind,emb_popstruct_list)
emb_popstruct_df <- as.data.frame(emb_popstruct_matrix)
colnames(emb_popstruct_df) <- paste0("dim_",seq_len(ncol(emb_popstruct_df)))
centroid_popstruct <- colMeans(emb_popstruct_df)

################################################################################

#Cosine similarity function
cosine_similarity <- function(x, y) 
{
  sum(x * y) / (sqrt(sum(x^2)) * sqrt(sum(y^2)))
}

################################################################################

#Import the categorization output
corpus_categorization_mapping <- read_excel("corpus_categorization.xlsx")
#Keep only the columns corresponding to the sentences and the category
corpus_categorization_mapping <- corpus_categorization_mapping[,-c(2,4)]
#Retrieve sentences + embeddings
input_corpus_occurrences <- read_csv("embeddings_corpus_occurrences.csv")
#Rename the columns
names(corpus_categorization_mapping) <- c("Occurrences","Category")
names(input_corpus_occurrences) <- c("Occurrences","Embeddings")
#Split the embeddings to separate columns
input_corpus_list <- map(input_corpus_occurrences$Embeddings,fromJSON)
input_corpus_matrix <- do.call(rbind,input_corpus_list)
input_corpus_df <- as.data.frame(input_corpus_matrix)
colnames(input_corpus_df) <- paste0("dim_",seq_len(ncol(input_corpus_df)))
#Combine
combined_corpus <- cbind(corpus_categorization_mapping,input_corpus_df)
#Remove rows with "Error" or NA
combined_corpus <- combined_corpus[complete.cases(combined_corpus) & !is.na(combined_corpus$Category) & combined_corpus$Category != "Error",]

#Create the subsets

##Evolution
combined_evolution <- combined_corpus[combined_corpus$Category=="Ancestry in Evolution and Lineage Relationships",]
##Health
combined_health <- combined_corpus[combined_corpus$Category=="Genetic Ancestry and Health",]
##Identity
combined_identity <- combined_corpus[combined_corpus$Category=="Human Ancestry, Identity, Geography, and Demography",]
##Methods
combined_methods <- combined_corpus[combined_corpus$Category=="Ancestry-Inference Tools, Markers, and Analytic Approaches",]
##Population structure
combined_popstruct <- combined_corpus[combined_corpus$Category=="Ancestry in Population Structure and Genetic Variation",]

#Remove the sentences corresponding to the validated sentences

##Evolution
unvalidated_evolution <- combined_evolution
rownames(unvalidated_evolution) <- 1:nrow(unvalidated_evolution)
unvalidated_evolution <- unvalidated_evolution[ !(unvalidated_evolution[[1]] %in% input_evolution[[1]]), ]
##Fix formatting issues
input_evolution[[1]][ !(input_evolution[[1]] %in% combined_evolution[[1]])]
unvalidated_evolution <- unvalidated_evolution[-c(1766,3236,662,343,2463,2511,2227),] #manually remove the problematic sentences

##Health
unvalidated_health <- combined_health
rownames(unvalidated_health) <- 1:nrow(unvalidated_health)
unvalidated_health <- unvalidated_health[ !(unvalidated_health[[1]] %in% input_health[[1]]), ]
##Fix formatting issues
input_health[[1]][ !(input_health[[1]] %in% combined_health[[1]])] 
unvalidated_health <- unvalidated_health[-c(277,1038,1047,923,924,581),] #manually remove the problematic sentences

##Identity
unvalidated_identity <- combined_identity
rownames(unvalidated_identity) <- 1:nrow(unvalidated_identity)
unvalidated_identity <- unvalidated_identity[ !(unvalidated_identity[[1]] %in% input_identity[[1]]), ]
##Fix formatting issues
input_identity[[1]][ !(input_identity[[1]] %in% combined_identity[[1]])] 
unvalidated_identity <- unvalidated_identity[-c(3490,4077,4344,1176,1177),] #manually remove the problematic sentences

##Methods
unvalidated_methods <- combined_methods
rownames(unvalidated_methods) <- 1:nrow(unvalidated_methods)
unvalidated_methods <- unvalidated_methods[ !(unvalidated_methods[[1]] %in% input_methods[[1]]), ]
##Fix formatting issues
input_methods[[1]][ !(input_methods[[1]] %in% combined_methods[[1]])] 
unvalidated_methods <- unvalidated_methods[-c(3141,1650,449,450,1663),] #manually remove the problematic sentences

##Popstruct
unvalidated_popstruct <- combined_popstruct
rownames(unvalidated_popstruct) <- 1:nrow(unvalidated_popstruct)
unvalidated_popstruct <- unvalidated_popstruct[ !(unvalidated_popstruct[[1]] %in% input_popstruct[[1]]), ]
##Fix formatting issues
input_popstruct[[1]][ !(input_popstruct[[1]] %in% combined_popstruct[[1]])] 
unvalidated_popstruct <- unvalidated_popstruct[-c(5087,5088,5089,5090,721,1768,6552,6553,2916,6404,6405,97,5082,3313,3314,4257,2326,2327,4888),] #manually remove the problematic sentences

################################### Subset Evolution ###########################

#Compare with "evolution" centroid
cos_sim_evolution_evo <- apply(unvalidated_evolution[3:1538],1,function(row) cosine_similarity(row,centroid_evolution))
cos_dist_evolution_evo <- 1 - cos_sim_evolution_evo
distance_evolution_evo <- data.frame(cosine_similarity=cos_sim_evolution_evo,cosine_distance=cos_dist_evolution_evo)
summary(distance_evolution_evo)

#Compare with "health" centroid
cos_sim_evolution_health <- apply(unvalidated_evolution[3:1538],1,function(row) cosine_similarity(row,centroid_health))
cos_dist_evolution_health <- 1 - cos_sim_evolution_health
distance_evolution_health <- data.frame(cosine_similarity=cos_sim_evolution_health,cosine_distance=cos_dist_evolution_health)
summary(distance_evolution_health)

#Compare with "identity" centroid
cos_sim_evolution_identity <- apply(unvalidated_evolution[3:1538],1,function(row) cosine_similarity(row,centroid_identity))
cos_dist_evolution_identity <- 1 - cos_sim_evolution_identity
distance_evolution_identity <- data.frame(cosine_similarity=cos_sim_evolution_identity,cosine_distance=cos_dist_evolution_identity)
summary(distance_evolution_identity)

#Compare with "methods" centroid
cos_sim_evolution_methods <- apply(unvalidated_evolution[3:1538],1,function(row) cosine_similarity(row,centroid_methods))
cos_dist_evolution_methods <- 1 - cos_sim_evolution_methods
distance_evolution_methods <- data.frame(cosine_similarity=cos_sim_evolution_methods,cosine_distance=cos_dist_evolution_methods)
summary(distance_evolution_methods)

#Compare with "population structure" centroid
cos_sim_evolution_popstruct <- apply(unvalidated_evolution[3:1538],1,function(row) cosine_similarity(row,centroid_popstruct))
cos_dist_evolution_popstruct <- 1 - cos_sim_evolution_popstruct
distance_evolution_popstruct <- data.frame(cosine_similarity=cos_sim_evolution_popstruct,cosine_distance=cos_dist_evolution_popstruct)
summary(distance_evolution_popstruct)

################################### Subset Health ##############################

#Compare with "evolution" centroid
cos_sim_health_evo <- apply(unvalidated_health[3:1538],1,function(row) cosine_similarity(row,centroid_evolution))
cos_dist_health_evo <- 1 - cos_sim_health_evo
distance_health_evo <- data.frame(cosine_similarity=cos_sim_health_evo,cosine_distance=cos_dist_health_evo)
summary(distance_health_evo)

#Compare with "health" centroid
cos_sim_health_health <- apply(unvalidated_health[3:1538],1,function(row) cosine_similarity(row,centroid_health))
cos_dist_health_health <- 1 - cos_sim_health_health
distance_health_health <- data.frame(cosine_similarity=cos_sim_health_health,cosine_distance=cos_dist_health_health)
summary(distance_health_health)

#Compare with "identity" centroid
cos_sim_health_identity <- apply(unvalidated_health[3:1538],1,function(row) cosine_similarity(row,centroid_identity))
cos_dist_health_identity <- 1 - cos_sim_health_identity
distance_health_identity <- data.frame(cosine_similarity=cos_sim_health_identity,cosine_distance=cos_dist_health_identity)
summary(distance_health_identity)

#Compare with "methods" centroid
cos_sim_health_methods <- apply(unvalidated_health[3:1538],1,function(row) cosine_similarity(row,centroid_methods))
cos_dist_health_methods <- 1 - cos_sim_health_methods
distance_health_methods <- data.frame(cosine_similarity=cos_sim_health_methods,cosine_distance=cos_dist_health_methods)
summary(distance_health_methods)

#Compare with "population structure" centroid
cos_sim_health_popstruct <- apply(unvalidated_health[3:1538],1,function(row) cosine_similarity(row,centroid_popstruct))
cos_dist_health_popstruct <- 1 - cos_sim_health_popstruct
distance_health_popstruct <- data.frame(cosine_similarity=cos_sim_health_popstruct,cosine_distance=cos_dist_health_popstruct)
summary(distance_health_popstruct)

################################ Subset Identity ###############################

#Compare with "evolution" centroid
cos_sim_identity_evo <- apply(unvalidated_identity[3:1538],1,function(row) cosine_similarity(row,centroid_evolution))
cos_dist_identity_evo <- 1 - cos_sim_identity_evo
distance_identity_evo <- data.frame(cosine_similarity=cos_sim_identity_evo,cosine_distance=cos_dist_identity_evo)
summary(distance_identity_evo)

#Compare with "health" centroid
cos_sim_identity_health <- apply(unvalidated_identity[3:1538],1,function(row) cosine_similarity(row,centroid_health))
cos_dist_identity_health <- 1 - cos_sim_identity_health
distance_identity_health <- data.frame(cosine_similarity=cos_sim_identity_health,cosine_distance=cos_dist_identity_health)
summary(distance_identity_health)

#Compare with "identity" centroid
cos_sim_identity_identity <- apply(unvalidated_identity[3:1538],1,function(row) cosine_similarity(row,centroid_identity))
cos_dist_identity_identity <- 1 - cos_sim_identity_identity
distance_identity_identity <- data.frame(cosine_similarity=cos_sim_identity_identity,cosine_distance=cos_dist_identity_identity)
summary(distance_identity_identity)

#Compare with "methods" centroid
cos_sim_identity_methods <- apply(unvalidated_identity[3:1538],1,function(row) cosine_similarity(row,centroid_methods))
cos_dist_identity_methods <- 1 - cos_sim_identity_methods
distance_identity_methods <- data.frame(cosine_similarity=cos_sim_identity_methods,cosine_distance=cos_dist_identity_methods)
summary(distance_identity_methods)

#Compare with "population structure" centroid
cos_sim_identity_popstruct <- apply(unvalidated_identity[3:1538],1,function(row) cosine_similarity(row,centroid_popstruct))
cos_dist_identity_popstruct <- 1 - cos_sim_identity_popstruct
distance_identity_popstruct <- data.frame(cosine_similarity=cos_sim_identity_popstruct,cosine_distance=cos_dist_identity_popstruct)
summary(distance_identity_popstruct)

################################## Subset Methods ##############################

#Compare with "evolution" centroid
cos_sim_methods_evo <- apply(unvalidated_methods[3:1538],1,function(row) cosine_similarity(row,centroid_evolution))
cos_dist_methods_evo <- 1 - cos_sim_methods_evo
distance_methods_evo <- data.frame(cosine_similarity=cos_sim_methods_evo,cosine_distance=cos_dist_methods_evo)
summary(distance_methods_evo)

#Compare with "health" centroid
cos_sim_methods_health <- apply(unvalidated_methods[3:1538],1,function(row) cosine_similarity(row,centroid_health))
cos_dist_methods_health <- 1 - cos_sim_methods_health
distance_methods_health <- data.frame(cosine_similarity=cos_sim_methods_health,cosine_distance=cos_dist_methods_health)
summary(distance_methods_health)

#Compare with "identity" centroid
cos_sim_methods_identity <- apply(unvalidated_methods[3:1538],1,function(row) cosine_similarity(row,centroid_identity))
cos_dist_methods_identity <- 1 - cos_sim_methods_identity
distance_methods_identity <- data.frame(cosine_similarity=cos_sim_methods_identity,cosine_distance=cos_dist_methods_identity)
summary(distance_methods_identity)

#Compare with "methods" centroid
cos_sim_methods_methods <- apply(unvalidated_methods[3:1538],1,function(row) cosine_similarity(row,centroid_methods))
cos_dist_methods_methods <- 1 - cos_sim_methods_methods
distance_methods_methods <- data.frame(cosine_similarity=cos_sim_methods_methods,cosine_distance=cos_dist_methods_methods)
summary(distance_methods_methods)

#Compare with "population structure" centroid
cos_sim_methods_popstruct <- apply(unvalidated_methods[3:1538],1,function(row) cosine_similarity(row,centroid_popstruct))
cos_dist_methods_popstruct <- 1 - cos_sim_methods_popstruct
distance_methods_popstruct <- data.frame(cosine_similarity=cos_sim_methods_popstruct,cosine_distance=cos_dist_methods_popstruct)
summary(distance_methods_popstruct)

################################ Subset Population Structure ###################

#Compare with "evolution" centroid
cos_sim_popstruct_evo <- apply(unvalidated_popstruct[3:1538],1,function(row) cosine_similarity(row,centroid_evolution))
cos_dist_popstruct_evo <- 1 - cos_sim_popstruct_evo
distance_popstruct_evo <- data.frame(cosine_similarity=cos_sim_popstruct_evo,cosine_distance=cos_dist_popstruct_evo)
summary(distance_popstruct_evo)

#Compare with "health" centroid
cos_sim_popstruct_health <- apply(unvalidated_popstruct[3:1538],1,function(row) cosine_similarity(row,centroid_health))
cos_dist_popstruct_health <- 1 - cos_sim_popstruct_health
distance_popstruct_health <- data.frame(cosine_similarity=cos_sim_popstruct_health,cosine_distance=cos_dist_popstruct_health)
summary(distance_popstruct_health)

#Compare with "identity" centroid
cos_sim_popstruct_identity <- apply(unvalidated_popstruct[3:1538],1,function(row) cosine_similarity(row,centroid_identity))
cos_dist_popstruct_identity <- 1 - cos_sim_popstruct_identity
distance_popstruct_identity <- data.frame(cosine_similarity=cos_sim_popstruct_identity,cosine_distance=cos_dist_popstruct_identity)
summary(distance_popstruct_identity)

#Compare with "methods" centroid
cos_sim_popstruct_methods <- apply(unvalidated_popstruct[3:1538],1,function(row) cosine_similarity(row,centroid_methods))
cos_dist_popstruct_methods <- 1 - cos_sim_popstruct_methods
distance_popstruct_methods <- data.frame(cosine_similarity=cos_sim_popstruct_methods,cosine_distance=cos_dist_popstruct_methods)
summary(distance_popstruct_methods)

#Compare with "population structure" centroid
cos_sim_popstruct_popstruct <- apply(unvalidated_popstruct[3:1538],1,function(row) cosine_similarity(row,centroid_popstruct))
cos_dist_popstruct_popstruct <- 1 - cos_sim_popstruct_popstruct
distance_popstruct_popstruct <- data.frame(cosine_similarity=cos_sim_popstruct_popstruct,cosine_distance=cos_dist_popstruct_popstruct)
summary(distance_popstruct_popstruct)