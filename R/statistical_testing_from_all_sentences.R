################################################################################

# This R script:
# Tests for statistical significance in the cosine similarities computed between a category subset and the competing centroids
# Based on centroids computed from all sentences

################################################################################

library(dplyr)
library(ggplot2)

################################### Subset Evolution ###########################

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

################################### Subset Health ##############################

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

################################ Subset Identity ###############################

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

################################## Subset Methods ##############################

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

################################ Subset Population Structure ###################

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