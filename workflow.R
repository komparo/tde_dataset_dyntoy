library(certigo)

# installed together with certigo
library(tidyr)
library(stringr)
library(dplyr)

design <- crossing(
  differentially_expressed_rate = seq(0.1, 0.9, 0.1)
) %>% 
  mutate(
    seed = row_number(),
    id = as.character(row_number())
  )

generate_datasets_expression <- rlang::quo(rscript_call(
  "generate_datasets",
  script_file(str_glue("{workflow_folder}/scripts/run.R")),
  outputs = list(
    expression = derived_file(str_glue("{datasets_folder}/{id}/expression.csv")),
    meta = derived_file(str_glue("{datasets_folder}/{id}/meta.yml"))
  ),
  design = design,
  params = params,
  executor = docker_executor("komparo/tde_datasets_dyntoy")
))