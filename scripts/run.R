library(dyntoy)
library(readr)
library(dplyr)

# read parameters
design <- jsonlite::fromJSON(inputs["design"])
testthat::expect_true(all(names(design) %in% c("seed", "ix", names(formals(dyntoy::generate_dataset)))))
set.seed(design$seed)

# generate datasets
dataset <- purrr::invoke(dyntoy::generate_dataset, design[intersect(names(design), names(formals(dyntoy::generate_dataset)))])

# write dataset
write.csv(dataset$expression, outputs["expression"])

# generate metadata
metadata <- list(
  provides_expression = TRUE
)
yaml::write_yaml(metadata, outputs["meta"])
