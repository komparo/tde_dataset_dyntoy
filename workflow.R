library(certigo)

# installed together with certigo
library(tidyr)
library(stringr)

design <- crossing(
  differentially_expressed_rate = seq(0.1, 0.9, 0.1)
) %>% 
  mutate(
    seed = row_number(),
    ix = as.character(row_number())
  )

generate_datasets <- rscript_call(
  "generate_datasets",
  script_file("scripts/run.R"),
  outputs = list(
    expression = derived_file(str_glue("datasets/{ix}/expression.csv")),
    meta = derived_file(str_glue("datasets/{ix}/meta.yml"))
  ),
  design = design,
  executor = docker_executor("komparo/tde_datasets_dyntoy")
)
