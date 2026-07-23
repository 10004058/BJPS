################################################################################

# This R script:
# Extracts the subsets of sentences to be converted into KG

################################################################################

library(dplyr)

############################ Produce the KG ####################################

#Clean the dataframe (remove brackets and quotes)
filtered_clean <- filtered_ancestry
filtered_clean$sentence <- gsub("\\[[0-9,]+\\]", "", filtered_clean$sentence)  
filtered_clean$sentence <- gsub('"', "", filtered_clean$sentence)               
filtered_clean$sentence <- gsub("'", "", filtered_clean$sentence)               
filtered_clean$sentence <- gsub('[\"\',‘’“”]', '', filtered_clean$sentence)

#Select 500 randoms quotes
HPC_ancest_500 <- filtered_clean |>
  slice_sample(n=500)|>
  select(sentence)
#Add quotes and "," after each sentence 
HPC_ancest_500$sentence <- paste0('"', HPC_ancest_500$sentence, '",')
#Save in an CSV file
write.csv(HPC_ancest_500,"Subset500.csv",row.names=F,quote=F)

#Select 3000 randoms quotes
set.seed(145)
HPC_ancest_3000 <- filtered_clean |>
  slice_sample(n=3000)|>
  select(sentence)
#Add quotes and "," after each sentence 
HPC_ancest_3000$sentence <- paste0('"', HPC_ancest_3000$sentence, '",')
#Save in an CSV file
write.csv(HPC_ancest_3000,"Subset3000.csv",row.names=F,quote=F)
