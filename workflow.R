library(certigo)

# installed together with certigo
library(tidyr)
library(stringr)
library(dplyr)
library(purrr)

get_call <- function() {
  set.seed(1)
  dataset_design <- crossing(
    differentially_expressed_rate = seq(0.1, 0.9, 0.2)
  ) %>% 
    mutate(
      num_cells = runif(n(), 10, 1000),
      seed = row_number(),
      id = as.character(row_number())
    )
  
  rscript_call(
    design = dataset_design %>% 
      mutate(
        script = list(script_file("scripts/run.R")),
        executor = list(docker_executor("komparo/tde_dataset_dyntoy")),
        parameters = dataset_design %>% dynutils::mapdf(parameters),
        
        expression = str_glue("{id}/expression.csv") %>% map(derived_file),
        meta = str_glue("{id}/meta.yml") %>% map(derived_file)
      ),
    inputs = c("script", "executor", "parameters"),
    outputs = c("expression", "meta")
  )
}
