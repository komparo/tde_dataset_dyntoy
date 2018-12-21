library(tidyverse)

dataset_design <- crossing(
  differentially_expressed_rate = seq(0.1, 0.9, 0.2)
) %>% 
  mutate(
    num_cells = runif(n(), 10, 1000),
    seed = row_number(),
    id = as.character(row_number())
  )

dataset_design %>% pmap(function(...) {
  parameters <- list(...)
  jsonlite::write_json(parameters, paste0(parameters$id, ".json"))
})