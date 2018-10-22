library(certigo)

# installed together with certigo
library(tidyr)
library(stringr)
library(dplyr)
library(purrr)

design <- crossing(
  differentially_expressed_rate = seq(0.1, 0.9, 0.1)
) %>% 
  mutate(
    seed = row_number(),
    id = as.character(row_number())
  )

generate_datasets_expression <- rlang::quo(
  rscript_call(
    "generate_datasets",
    design = design,
    inputs = tibble(
      script = list(script_file(str_glue("{workflow_folder}/scripts/run.R"))),
      executor = list(docker_executor("komparo/tde_dataset_dyntoy")),
      design = design %>% dynutils::mapdf(parameters)
    ),
    outputs = design %>% 
      transmute(
        expression = str_glue("{datasets_folder}/{id}/expression.csv") %>% map(derived_file),
        meta = str_glue("{datasets_folder}/{id}/meta.yml") %>% map(derived_file)
      )
  )
)
