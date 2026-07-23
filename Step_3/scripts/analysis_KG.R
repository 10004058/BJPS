################################################################################

# This R script:
# Cleans and analyses the KG

########################### Analyze the KG #####################################

#read the TXT in R
lines <- readLines("404KG_raw.txt")

#Remove the beginning of the lines with the date
clean_lines <- gsub("^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2},\\d{3} \\[INFO\\] ?","",lines)

# Initialization
graphs <- list()
current_graph <- NULL
current_section <- NULL

#Create the list
for (line in clean_lines) 
{
  
  #Graphs
  if (grepl("^=== Graph", line)) 
  {
    graph_name <- gsub("===\\s*(Graph\\s*\\d+)\\s*===", "\\1", line)
    current_graph <- list(nodes = list(), relationships = list())
    graphs[[graph_name]] <- current_graph
    current_section <- NULL
    next
  }
  
  if (line == "Nodes:") { current_section <- "nodes"; next }
  if (line == "Relationships:") { current_section <- "relationships"; next }
  
  #Nodes
  if (!is.null(current_section) && current_section == "nodes") 
  {
    matches <- regmatches(line, regexec("id='([^']+)' type='([^']+)'", line))[[1]]
    if (length(matches) == 3) 
    {
      node <- list(id = matches[2], type = matches[3])
      graphs[[graph_name]][["nodes"]] <- append(graphs[[graph_name]][["nodes"]], list(node))
    }
  }
  
  #Relationshipts
  if (!is.null(current_section) && current_section == "relationships") 
  {
    line_clean <- sub("^-\\s*", "", line)
    parts <- strsplit(line_clean, "--\\[")[[1]]
    if (length(parts) == 2) 
    {
      source <- trimws(parts[1])
      rest <- parts[2]
      type_target <- strsplit(rest, "\\]-->")[[1]]
      if (length(type_target) == 2) 
      {
        type <- trimws(type_target[1])
        target <- trimws(type_target[2])
        rel <- list(source = source, type = type, target = target)
        graphs[[graph_name]][["relationships"]] <- append(graphs[[graph_name]][["relationships"]], list(rel))
      }
    }
  }
}

#Select graphs with "ancest"
graph_ancest <- function(graph,pattern="ancest") 
{
  node_match <- any(sapply(graph$nodes, function(n) 
  {
    grepl(pattern, n$id, ignore.case = TRUE)
  }))
  rel_match <- any(sapply(graph$relationships, function(r) 
  {
    grepl(pattern, r$source, ignore.case = TRUE) ||
      grepl(pattern, r$type, ignore.case = TRUE) ||
      grepl(pattern, r$target, ignore.case = TRUE)
  }))
  node_match || rel_match
}
graphs_filtered <- graphs[sapply(graphs,graph_ancest)]

node_has_ancest <- function(graph) {
  any(grepl("ancest", sapply(graph$nodes, `[[`, "id"), ignore.case = TRUE))
}

# does any relationship type contain "ANCEST" (case-sensitive)?
rel_has_ancest <- function(graph) {
  any(grepl("ANCEST", sapply(graph$relationships, `[[`, "type"), ignore.case = FALSE))
}

# apply to your list of graphs
node_matches <- sapply(graphs_filtered, node_has_ancest)
rel_matches <- sapply(graphs_filtered, rel_has_ancest)

# counts
in_nodes_only <- sum(node_matches & !rel_matches)
in_rels_only <- sum(rel_matches & !node_matches)
in_both <- sum(node_matches & rel_matches)
none <- sum(!node_matches & !rel_matches)

list(
  nodes_only = in_nodes_only,
  relationships_only = in_rels_only,
  both = in_both,
  none = none
)

which(!node_matches & !rel_matches)

#More cleaning
for (g in names(graphs_filtered)) 
{
  for (i in seq_along(graphs_filtered[[g]]$relationships)) 
  {
    graphs_filtered[[g]]$relationships[[i]]$source <- 
      trimws(sub("^-\\s*", "", graphs_filtered[[g]]$relationships[[i]]$source))
  }
}

#Save in a TXT file
txt_file <- "404KG_clean.txt"
con <- file(txt_file, open = "w")
for (g in names(graphs_filtered)) 
{
  cat("=== ", g, " ===\n", file = con, sep = "")
  # Nodes
  cat("Nodes:\n", file = con)
  for (n in graphs_filtered[[g]]$nodes) 
  {
    cat(" - id='", n$id, "' type='", n$type, "'\n", sep = "", file = con)
  }
  # Relationships
  cat("Relationships:\n", file = con)
  for (r in graphs_filtered[[g]]$relationships) 
  {
    cat(" - ", r$source, " --[", r$type, "]--> ", r$target, "\n", sep = "", file = con)
  }
  # Blank line between graphs
  cat("\n", file = con)
}
close(con)

