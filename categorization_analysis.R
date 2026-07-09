################################################################################

# This R script:
# Analysis the output of the categorization task of the consensus run

################################################################################

library(rjson)
library(waldo)
library(purrr)
library(dplyr)
library(tidyr)
library(jsonlite)
library(stringi)
library(gsubfn)

################################################################################

#Step 1: load the JSON files in R

json_subset2_1 <- "Run2_1.json"
json_data2_1 <- jsonlite::read_json(json_subset2_1, encoding = "UTF-8")

json_subset2_2 <- "Run2_2.json"
json_data2_2 <- jsonlite::read_json(json_subset2_2, encoding = "UTF-8")

json_subset2_3 <- "Run2_3.json"
json_data2_3 <- jsonlite::read_json(json_subset2_3, encoding = "UTF-8")

json_subset2_4 <- "Run2_4.json"
json_data2_4 <- jsonlite::read_json(json_subset2_4, encoding = "UTF-8")

json_subset2_5 <- "Run2_5.json"
json_data2_5 <- jsonlite::read_json(json_subset2_5, encoding = "UTF-8")

json_subset2_6 <- "Run2_6.json"
json_data2_6 <- jsonlite::read_json(json_subset2_6, encoding = "UTF-8")

################################################################################

#Step 2: extract the labels for each subset

labels2_1 <- map(json_data2_1, ~ map_chr(.x$labels,"label"))
labels2_2 <- map(json_data2_2, ~ map_chr(.x$labels,"label"))
labels2_3 <- map(json_data2_3, ~ map_chr(.x$labels,"label"))
labels2_4 <- map(json_data2_4, ~ map_chr(.x$labels,"label"))
labels2_5 <- map(json_data2_5, ~ map_chr(.x$labels,"label"))
labels2_6 <- map(json_data2_6, ~ map_chr(.x$labels,"label"))

################################################################################

#Step 3: compute the categories distribution in a given subset

all_labels <- unlist(labels2_6) #update the label
label_counts <- table(all_labels)
label_freq <- prop.table(label_counts)
df_labels <- data.frame(Label=names(label_counts),Count=as.integer(label_counts),Frequency=round(as.numeric(label_freq),2))
df_labels

sum(df_labels$Count)

################################################################################

#Step 4: combine all the subsets in a single list

combined_list_run2 <- list(json_data2_1,json_data2_2,json_data2_3,json_data2_4,json_data2_5,json_data2_6)
run2_corpus <- do.call(c,combined_list_run2)

################################################################################

#Step 5: extract the labels for the corpus

labels_run2 <- map(run2_corpus, ~ map_chr(.x$labels,"label"))

################################################################################

#Step 6: compute the categories distribution in the corpus

all_labels <- unlist(labels_run2) 
label_counts <- table(all_labels)
label_freq <- prop.table(label_counts)
df_labels <- data.frame(Label=names(label_counts),Count=as.integer(label_counts),Frequency=round(as.numeric(label_freq),2))
df_labels

sum(df_labels$Count)