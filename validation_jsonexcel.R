################################################################################

# This R script:
# Takes a JSON-formatted object and save it as a XLSX that can be used for validation

################################################################################

library(openxlsx)
library(jsonlite)

################################################################################

#Function to reformat the object
flatten_entry_long <- function(entry)
{
  sentence <- entry$sentence
  
  if (!is.null(entry$labels) && length(entry$labels) > 0) 
  {
    data.frame(
      Sentence = sentence,
      Word = sapply(entry$labels, function(x) x$word),
      Label = sapply(entry$labels, function(x) x$label),
      Justification = sapply(entry$labels, function(x) x$justification),
      stringsAsFactors = FALSE
    )
  } 
  else 
  {
    # If no labels, still return one row
    data.frame(
      Sentence = sentence,
      Word = NA,
      Label = NA,
      Justification = NA,
      stringsAsFactors = FALSE
    )
  }
}

#Apply the function
flat_df_long <- do.call(rbind, lapply(run2_corpus,flatten_entry_long))

#Clean the dataframe 
clean_xml <- function(x) 
{
  x <- iconv(x, "UTF-8", "UTF-8", sub = "")
  x <- gsub("[^\t\r\n\u0020-\uD7FF\uE000-\uFFFD]", "", x, perl = TRUE)
  x
}
flat_df_long[] <- lapply(flat_df_long, function(col) {
  if (is.character(col)) clean_xml(col) else col
})

#Save the dataframe in an XLSX file
write.xlsx(flat_df_long,"corpus_categorization.xlsx", rowNames = FALSE)
