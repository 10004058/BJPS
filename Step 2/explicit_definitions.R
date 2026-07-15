################################################################################

# This R script:
# Extracts explicit definitions in the corpus

################################################################################

library(stringr)

###############################################################################

#Define the concept keywords
concept <- "\\bancestr\\w*"

#Define the corpus
corpus <- filtered_ancestry$sentence

#Define the explicitly definitional patterns
patterns <- c(
  paste0(concept,"\\s+is defined as"),
  paste0(concept,"\\s+are defined as"),
  paste0(concept,"\\s+refers to"),
  paste0(concept,"\\s+refer to"),
  paste0("by\\s+",concept,",?\\s+we mean"),
  paste0(concept,"\\s+can be defined as"),
  paste0(concept,"\\s+is a type of"),
  paste0(concept,"\\s+are a type of")
)

#Retrieve the matching sentences
definition_sentences <- corpus[str_detect(tolower(corpus),str_c(patterns,collapse="|"))]

#save the result in a TXT file
write(definition_sentences,file="explicit_definitions.txt",ncolumns=if(is.character(definition_sentences)) 1 else 5,append=F,sep=" ")
