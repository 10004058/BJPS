################################################################################

# This R script:
# Analysis the output of the categorization task of the consensus run on the 3000-sentences subset to compare the categories based on 404 KG and those based on 2474 KG

################################################################################

library(purrr)
library(jsonlite)

################################################################################

#Categories based on 404 KG

json_subset404 <- "Run_based_on_404KG.json"
json_data404 <- jsonlite::read_json(json_subset404, encoding = "UTF-8")

labels404 <- map(json_data404, ~ map_chr(.x$labels,"label"))

all_labels <- unlist(labels404) 
label_counts <- table(all_labels)
label_freq <- prop.table(label_counts)
df_labels <- data.frame(Label=names(label_counts),Count=as.integer(label_counts),Frequency=round(as.numeric(label_freq),2))
df_labels

sum(df_labels$Count)

################################################################################

#Categories based on 2474 KG

json_subset2474 <- "Run_based_on_2474KG.json"
json_data2474 <- jsonlite::read_json(json_subset2474, encoding = "UTF-8")

labels2474 <- map(json_data2474, ~ map_chr(.x$labels,"label"))

all_labels <- unlist(labels2474) 
label_counts <- table(all_labels)
label_freq <- prop.table(label_counts)
df_labels <- data.frame(Label=names(label_counts),Count=as.integer(label_counts),Frequency=round(as.numeric(label_freq),2))
df_labels

sum(df_labels$Count)
