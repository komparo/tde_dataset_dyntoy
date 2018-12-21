library(dyntoy)
library(readr)
library(dplyr)

# read parameters
parameters <- jsonlite::fromJSON(inputs$design)
testthat::expect_true(all(names(parameters) %in% c("seed", "ix", names(formals(dyntoy::generate_dataset)))))
set.seed(parameters$seed)

# generate datasets
dataset <- purrr::invoke(dyntoy::generate_dataset, parameters[intersect(names(parameters), names(formals(dyntoy::generate_dataset)))])

# write dataset
write.csv(dataset$expression, outputs[["gene_expression"]])

# write differential expression
write_csv(dataset$tde_overall %>% rename(significant = differentially_expressed), outputs[["tde_overall"]])

# generate metadata
metadata <- list(
  do_we_have_metadata_yet = FALSE
)
jsonlite::write_json(metadata, outputs[["metadata"]])
