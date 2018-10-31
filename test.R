library(certigo)

datasets <- load_call(
  "workflow.R",
  derived_file_directory = "results/datasets"
)
datasets$design <- datasets$design[1, ]
datasets$start_and_wait()
