library(dyntoy)
library(readr)
library(dplyr)

# read parameters
parameters <- jsonlite::fromJSON(inputs[["parameters"]])
testthat::expect_true(all(names(parameters) %in% c("seed", "ix", names(formals(dyntoy::generate_dataset)))))
set.seed(parameters$seed)

# generate datasets
dataset <- purrr::invoke(dyntoy::generate_dataset, parameters[intersect(names(parameters), names(formals(dyntoy::generate_dataset)))])

# write dataset
write.csv(dataset$expression, outputs[["expression"]])

# generate metadata
metadata <- list(
  provides_expression = TRUE
)
yaml::write_yaml(metadata, outputs[["meta"]])
