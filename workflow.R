library(certigo)

# installed together with certigo
library(tidyr)
library(stringr)
library(dplyr)
library(purrr)

dataset_design_all <- crossing(
  differentially_expressed_rate = seq(0.1, 0.9, 0.2)
) %>% 
  mutate(
    num_cells = runif(n(), 10, 1000),
    seed = row_number(),
    id = as.character(row_number())
  )

generate_dataset_calls <- function(dataset_design = dataset_design_all, workflow_folder = ".", datasets_folder = ".") {
  rscript_call(
    "komparo/dyntoy",
    design = dataset_design,
    inputs = tibble(
      script = list(script_file(str_glue("{workflow_folder}/scripts/run.R"))),
      executor = list(docker_executor("komparo/tde_dataset_dyntoy")),
      design = dataset_design %>% dynutils::mapdf(parameters)
    ),
    outputs = dataset_design %>% 
      transmute(
        expression = str_glue("{datasets_folder}/{id}/expression.csv") %>% map(derived_file),
        meta = str_glue("{datasets_folder}/{id}/meta.yml") %>% map(derived_file)
      )
  )
}
