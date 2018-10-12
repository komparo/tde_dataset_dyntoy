library(dplyr)
library(tidyr)
library(purrr)

design <- crossing(
  differentially_expressed_rate = seq(0.1, 0.9, 0.2)
) %>% 
  mutate(
    seed = row_number(),
    ix = as.character(row_number())
  )


design %>% pwalk(function(...) {
  params = list(...)
  jsonlite::write_json(params, gsub("__snakemake_dynamic__", params$ix, snakemake@output[[1]]))
})
