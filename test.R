source('workflow.R')

call <- generate_dataset_calls(
  workflow_folder = ".",
  datasets_folder = "./datasets",
  dataset_design = dataset_design_all[1, ]
)
call$start_and_wait()
