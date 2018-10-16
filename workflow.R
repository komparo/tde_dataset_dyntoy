library(certigo)
library(tidyverse)

design <- crossing(
  differentially_expressed_rate = seq(0.1, 0.9, 0.1)
) %>% 
  mutate(
    seed = row_number(),
    ix = as.character(row_number())
  )

calls <- list(
  run = rscript_call(
    "generate_dataset",
    script_file("scripts/run.R"),
    outputs = list(
      expression = derived_file(str_glue("datasets/{ix}/expression.csv")),
      meta = derived_file(str_glue("datasets/{ix}/meta.yml"))
    ),
    design = design
  ),
  test = rscript_call(
    "generate_dataset",
    script_file("scripts/run.R"),
    outputs = list(
      expression = derived_file(str_glue("datasets/{ix}/expression.csv")),
      meta = derived_file(str_glue("datasets/{ix}/meta.yml"))
    ),
    design = design[1, ]
  )
)


calls$test$run()
