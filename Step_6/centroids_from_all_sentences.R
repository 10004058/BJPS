################################################################################

# This R script:
# Computes the category centroids using all sentence embeddings
# Creates the category subsets based on the categorization and embeddings outputs
# Compares the embeddings of a category subset to the above-computed centroids
# Tests for statistical significance in the cosine similarities computed between a category subset and the competing centroids

################################################################################

library(purrr)
library(jsonlite)
library(readr)
library(readxl)
library(dplyr)

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
corpus_list <- map(input_corpus_occurrences$Embeddings,fromJSON)
corpus_matrix <- do.call(rbind,corpus_list)
corpus_df <- as.data.frame(corpus_matrix)
colnames(corpus_df) <- paste0("dim_",seq_len(ncol(corpus_df)))
#Combine
combined_corpus <- cbind(corpus_categorization_mapping,corpus_df)
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

################################################################################

#Compute the centroids

##Evolution
centroid_evolution <- colMeans(combined_evolution[ ,3:1538])
##Health
centroid_health <- colMeans(combined_health[ ,3:1538])
##Identity
centroid_identity <- colMeans(combined_identity[ ,3:1538])
##Methods
centroid_methods <- colMeans(combined_methods[ ,3:1538])
##Population structure
centroid_popstruct <- colMeans(combined_popstruct[ ,3:1538])

################################################################################

#Cosine similarity function
cosine_similarity <- function(x, y) 
{
  sum(x * y) / (sqrt(sum(x^2)) * sqrt(sum(y^2)))
}

################################### Subset Evolution ###########################

#Compare with "evolution" centroid
cos_sim_evolution_evo <- apply(combined_evolution[3:1538],1,function(row) cosine_similarity(row,centroid_evolution))
cos_dist_evolution_evo <- 1 - cos_sim_evolution_evo
distance_evolution_evo <- data.frame(cosine_similarity=cos_sim_evolution_evo,cosine_distance=cos_dist_evolution_evo)
summary(distance_evolution_evo)

#Compare with "health" centroid
cos_sim_evolution_health <- apply(combined_evolution[3:1538],1,function(row) cosine_similarity(row,centroid_health))
cos_dist_evolution_health <- 1 - cos_sim_evolution_health
distance_evolution_health <- data.frame(cosine_similarity=cos_sim_evolution_health,cosine_distance=cos_dist_evolution_health)
summary(distance_evolution_health)

#Compare with "identity" centroid
cos_sim_evolution_identity <- apply(combined_evolution[3:1538],1,function(row) cosine_similarity(row,centroid_identity))
cos_dist_evolution_identity <- 1 - cos_sim_evolution_identity
distance_evolution_identity <- data.frame(cosine_similarity=cos_sim_evolution_identity,cosine_distance=cos_dist_evolution_identity)
summary(distance_evolution_identity)

#Compare with "methods" centroid
cos_sim_evolution_methods <- apply(combined_evolution[3:1538],1,function(row) cosine_similarity(row,centroid_methods))
cos_dist_evolution_methods <- 1 - cos_sim_evolution_methods
distance_evolution_methods <- data.frame(cosine_similarity=cos_sim_evolution_methods,cosine_distance=cos_dist_evolution_methods)
summary(distance_evolution_methods)

#Compare with "population structure" centroid
cos_sim_evolution_popstruct <- apply(combined_evolution[3:1538],1,function(row) cosine_similarity(row,centroid_popstruct))
cos_dist_evolution_popstruct <- 1 - cos_sim_evolution_popstruct
distance_evolution_popstruct <- data.frame(cosine_similarity=cos_sim_evolution_popstruct,cosine_distance=cos_dist_evolution_popstruct)
summary(distance_evolution_popstruct)

################################### Subset Health ##############################

#Compare with "evolution" centroid
cos_sim_health_evo <- apply(combined_health[3:1538],1,function(row) cosine_similarity(row,centroid_evolution))
cos_dist_health_evo <- 1 - cos_sim_health_evo
distance_health_evo <- data.frame(cosine_similarity=cos_sim_health_evo,cosine_distance=cos_dist_health_evo)
summary(distance_health_evo)

#Compare with "health" centroid
cos_sim_health_health <- apply(combined_health[3:1538],1,function(row) cosine_similarity(row,centroid_health))
cos_dist_health_health <- 1 - cos_sim_health_health
distance_health_health <- data.frame(cosine_similarity=cos_sim_health_health,cosine_distance=cos_dist_health_health)
summary(distance_health_health)

#Compare with "identity" centroid
cos_sim_health_identity <- apply(combined_health[3:1538],1,function(row) cosine_similarity(row,centroid_identity))
cos_dist_health_identity <- 1 - cos_sim_health_identity
distance_health_identity <- data.frame(cosine_similarity=cos_sim_health_identity,cosine_distance=cos_dist_health_identity)
summary(distance_health_identity)

#Compare with "methods" centroid
cos_sim_health_methods <- apply(combined_health[3:1538],1,function(row) cosine_similarity(row,centroid_methods))
cos_dist_health_methods <- 1 - cos_sim_health_methods
distance_health_methods <- data.frame(cosine_similarity=cos_sim_health_methods,cosine_distance=cos_dist_health_methods)
summary(distance_health_methods)

#Compare with "population structure" centroid
cos_sim_health_popstruct <- apply(combined_health[3:1538],1,function(row) cosine_similarity(row,centroid_popstruct))
cos_dist_health_popstruct <- 1 - cos_sim_health_popstruct
distance_health_popstruct <- data.frame(cosine_similarity=cos_sim_health_popstruct,cosine_distance=cos_dist_health_popstruct)
summary(distance_health_popstruct)

################################ Subset Identity ###############################

#Compare with "evolution" centroid
cos_sim_identity_evo <- apply(combined_identity[3:1538],1,function(row) cosine_similarity(row,centroid_evolution))
cos_dist_identity_evo <- 1 - cos_sim_identity_evo
distance_identity_evo <- data.frame(cosine_similarity=cos_sim_identity_evo,cosine_distance=cos_dist_identity_evo)
summary(distance_identity_evo)

#Compare with "health" centroid
cos_sim_identity_health <- apply(combined_identity[3:1538],1,function(row) cosine_similarity(row,centroid_health))
cos_dist_identity_health <- 1 - cos_sim_identity_health
distance_identity_health <- data.frame(cosine_similarity=cos_sim_identity_health,cosine_distance=cos_dist_identity_health)
summary(distance_identity_health)

#Compare with "identity" centroid
cos_sim_identity_identity <- apply(combined_identity[3:1538],1,function(row) cosine_similarity(row,centroid_identity))
cos_dist_identity_identity <- 1 - cos_sim_identity_identity
distance_identity_identity <- data.frame(cosine_similarity=cos_sim_identity_identity,cosine_distance=cos_dist_identity_identity)
summary(distance_identity_identity)

#Compare with "methods" centroid
cos_sim_identity_methods <- apply(combined_identity[3:1538],1,function(row) cosine_similarity(row,centroid_methods))
cos_dist_identity_methods <- 1 - cos_sim_identity_methods
distance_identity_methods <- data.frame(cosine_similarity=cos_sim_identity_methods,cosine_distance=cos_dist_identity_methods)
summary(distance_identity_methods)

#Compare with "population structure" centroid
cos_sim_identity_popstruct <- apply(combined_identity[3:1538],1,function(row) cosine_similarity(row,centroid_popstruct))
cos_dist_identity_popstruct <- 1 - cos_sim_identity_popstruct
distance_identity_popstruct <- data.frame(cosine_similarity=cos_sim_identity_popstruct,cosine_distance=cos_dist_identity_popstruct)
summary(distance_identity_popstruct)

################################## Subset Methods ##############################

#Compare with "evolution" centroid
cos_sim_methods_evo <- apply(combined_methods[3:1538],1,function(row) cosine_similarity(row,centroid_evolution))
cos_dist_methods_evo <- 1 - cos_sim_methods_evo
distance_methods_evo <- data.frame(cosine_similarity=cos_sim_methods_evo,cosine_distance=cos_dist_methods_evo)
summary(distance_methods_evo)

#Compare with "health" centroid
cos_sim_methods_health <- apply(combined_methods[3:1538],1,function(row) cosine_similarity(row,centroid_health))
cos_dist_methods_health <- 1 - cos_sim_methods_health
distance_methods_health <- data.frame(cosine_similarity=cos_sim_methods_health,cosine_distance=cos_dist_methods_health)
summary(distance_methods_health)

#Compare with "identity" centroid
cos_sim_methods_identity <- apply(combined_methods[3:1538],1,function(row) cosine_similarity(row,centroid_identity))
cos_dist_methods_identity <- 1 - cos_sim_methods_identity
distance_methods_identity <- data.frame(cosine_similarity=cos_sim_methods_identity,cosine_distance=cos_dist_methods_identity)
summary(distance_methods_identity)

#Compare with "methods" centroid
cos_sim_methods_methods <- apply(combined_methods[3:1538],1,function(row) cosine_similarity(row,centroid_methods))
cos_dist_methods_methods <- 1 - cos_sim_methods_methods
distance_methods_methods <- data.frame(cosine_similarity=cos_sim_methods_methods,cosine_distance=cos_dist_methods_methods)
summary(distance_methods_methods)

#Compare with "population structure" centroid
cos_sim_methods_popstruct <- apply(combined_methods[3:1538],1,function(row) cosine_similarity(row,centroid_popstruct))
cos_dist_methods_popstruct <- 1 - cos_sim_methods_popstruct
distance_methods_popstruct <- data.frame(cosine_similarity=cos_sim_methods_popstruct,cosine_distance=cos_dist_methods_popstruct)
summary(distance_methods_popstruct)

################################ Subset Population Structure ###################

#Compare with "evolution" centroid
cos_sim_popstruct_evo <- apply(combined_popstruct[3:1538],1,function(row) cosine_similarity(row,centroid_evolution))
cos_dist_popstruct_evo <- 1 - cos_sim_popstruct_evo
distance_popstruct_evo <- data.frame(cosine_similarity=cos_sim_popstruct_evo,cosine_distance=cos_dist_popstruct_evo)
summary(distance_popstruct_evo)

#Compare with "health" centroid
cos_sim_popstruct_health <- apply(combined_popstruct[3:1538],1,function(row) cosine_similarity(row,centroid_health))
cos_dist_popstruct_health <- 1 - cos_sim_popstruct_health
distance_popstruct_health <- data.frame(cosine_similarity=cos_sim_popstruct_health,cosine_distance=cos_dist_popstruct_health)
summary(distance_popstruct_health)

#Compare with "identity" centroid
cos_sim_popstruct_identity <- apply(combined_popstruct[3:1538],1,function(row) cosine_similarity(row,centroid_identity))
cos_dist_popstruct_identity <- 1 - cos_sim_popstruct_identity
distance_popstruct_identity <- data.frame(cosine_similarity=cos_sim_popstruct_identity,cosine_distance=cos_dist_popstruct_identity)
summary(distance_popstruct_identity)

#Compare with "methods" centroid
cos_sim_popstruct_methods <- apply(combined_popstruct[3:1538],1,function(row) cosine_similarity(row,centroid_methods))
cos_dist_popstruct_methods <- 1 - cos_sim_popstruct_methods
distance_popstruct_methods <- data.frame(cosine_similarity=cos_sim_popstruct_methods,cosine_distance=cos_dist_popstruct_methods)
summary(distance_popstruct_methods)

#Compare with "population structure" centroid
cos_sim_popstruct_popstruct <- apply(combined_popstruct[3:1538],1,function(row) cosine_similarity(row,centroid_popstruct))
cos_dist_popstruct_popstruct <- 1 - cos_sim_popstruct_popstruct
distance_popstruct_popstruct <- data.frame(cosine_similarity=cos_sim_popstruct_popstruct,cosine_distance=cos_dist_popstruct_popstruct)
summary(distance_popstruct_popstruct)

################################### Test Evolution #############################

#Evolution/Health
test_evo_health <- wilcox.test(
  distance_evolution_evo$cosine_similarity,
  distance_evolution_health$cosine_similarity,
  paired = TRUE,
  alternative = "greater"
)

#Evolution/Identity
test_evo_identity <- wilcox.test(
  distance_evolution_evo$cosine_similarity,
  distance_evolution_identity$cosine_similarity,
  paired = TRUE,
  alternative = "greater"
)

#Evolution/Methods
test_evo_methods <- wilcox.test(
  distance_evolution_evo$cosine_similarity,
  distance_evolution_methods$cosine_similarity,
  paired = TRUE,
  alternative = "greater"
)

#Evolution/Population structure
test_evo_popstruct <- wilcox.test(
  distance_evolution_evo$cosine_similarity,
  distance_evolution_popstruct$cosine_similarity,
  paired = TRUE,
  alternative = "greater"
)

#Multiple-testing correction
pvals_evo <- c(
  evo_health = test_evo_health$p.value,
  evo_identity = test_evo_identity$p.value,
  evo_methods = test_evo_methods$p.value,
  evo_popstruct = test_evo_popstruct$p.value
)
pvals_bh_evo <- p.adjust(pvals_evo, method = "BH")

################################### Test Health ################################

#Health/Evolution
test_health_evo <- wilcox.test(
  distance_health_health$cosine_similarity,
  distance_health_evo$cosine_similarity,
  paired = TRUE,
  alternative = "greater"
)

#Health/Identity
test_health_identity <- wilcox.test(
  distance_health_health$cosine_similarity,
  distance_health_identity$cosine_similarity,
  paired = TRUE,
  alternative = "greater"
)

#Health/Methods
test_health_methods <- wilcox.test(
  distance_health_health$cosine_similarity,
  distance_health_methods$cosine_similarity,
  paired = TRUE,
  alternative = "greater"
)

#Health/Population structure
test_health_popstruct <- wilcox.test(
  distance_health_health$cosine_similarity,
  distance_health_popstruct$cosine_similarity,
  paired = TRUE,
  alternative = "greater"
)

#Multiple-testing correction
pvals_health <- c(
  health_evo = test_health_evo$p.value,
  health_identity = test_health_identity$p.value,
  health_methods = test_health_methods$p.value,
  health_popstruct = test_health_popstruct$p.value
)
pvals_bh_health <- p.adjust(pvals_health, method = "BH")

################################ Test Identity #################################

#Identity/Evolution
test_identity_evo <- wilcox.test(
  distance_identity_identity$cosine_similarity,
  distance_identity_evo$cosine_similarity,
  paired = TRUE,
  alternative = "greater"
)

#Identity/Health
test_identity_health <- wilcox.test(
  distance_identity_identity$cosine_similarity,
  distance_identity_health$cosine_similarity,
  paired = TRUE,
  alternative = "greater"
)

#Identity/Methods
test_identity_methods <- wilcox.test(
  distance_identity_identity$cosine_similarity,
  distance_identity_methods$cosine_similarity,
  paired = TRUE,
  alternative = "greater"
)

#Identity/Population structure
test_identity_popstruct <- wilcox.test(
  distance_identity_identity$cosine_similarity,
  distance_identity_popstruct$cosine_similarity,
  paired = TRUE,
  alternative = "greater"
)

#Multiple-testing correction
pvals_identity <- c(
  identity_evo = test_identity_evo$p.value,
  identity_health = test_identity_health$p.value,
  identity_methods = test_identity_methods$p.value,
  identity_popstruct = test_identity_popstruct$p.value
)
pvals_bh_identity <- p.adjust(pvals_identity, method = "BH")

################################## Test Methods ################################

#Methods/Evolution
test_methods_evo <- wilcox.test(
  distance_methods_methods$cosine_similarity,
  distance_methods_evo$cosine_similarity,
  paired = TRUE,
  alternative = "greater"
)

#Methods/Health
test_methods_health <- wilcox.test(
  distance_methods_methods$cosine_similarity,
  distance_methods_health$cosine_similarity,
  paired = TRUE,
  alternative = "greater"
)

#Methods/Identity
test_methods_identity <- wilcox.test(
  distance_methods_methods$cosine_similarity,
  distance_methods_identity$cosine_similarity,
  paired = TRUE,
  alternative = "greater"
)

#Methods/Population structure
test_methods_popstruct <- wilcox.test(
  distance_methods_methods$cosine_similarity,
  distance_methods_popstruct$cosine_similarity,
  paired = TRUE,
  alternative = "greater"
)

#Multiple-testing correction
pvals_methods <- c(
  methods_evo = test_methods_evo$p.value,
  methods_health = test_methods_health$p.value,
  methods_identity = test_methods_identity$p.value,
  methods_popstruct = test_methods_popstruct$p.value
)
pvals_bh_methods <- p.adjust(pvals_methods, method = "BH")

################################ Test Population Structure #####################

#Population structure/Evolution
test_popstruct_evo <- wilcox.test(
  distance_popstruct_popstruct$cosine_similarity,
  distance_popstruct_evo$cosine_similarity,
  paired = TRUE,
  alternative = "greater"
)

#Population structure/Health
test_popstruct_health <- wilcox.test(
  distance_popstruct_popstruct$cosine_similarity,
  distance_popstruct_health$cosine_similarity,
  paired = TRUE,
  alternative = "greater"
)

#Population structure/Identity
test_popstruct_identity <- wilcox.test(
  distance_popstruct_popstruct$cosine_similarity,
  distance_popstruct_identity$cosine_similarity,
  paired = TRUE,
  alternative = "greater"
)

#Population structure/Methods
test_popstruct_methods <- wilcox.test(
  distance_popstruct_popstruct$cosine_similarity,
  distance_popstruct_methods$cosine_similarity,
  paired = TRUE,
  alternative = "greater"
)

#Multiple-testing correction
pvals_popstruct <- c(
  popstruct_evo = test_popstruct_evo$p.value,
  popstruct_health = test_popstruct_health$p.value,
  popstruct_identity = test_popstruct_identity$p.value,
  popstruct_methods = test_popstruct_methods$p.value
)
pvals_bh_popstruct <- p.adjust(pvals_popstruct, method = "BH")
