source('workflow.R')

call <- rlang::eval_tidy(
  generate_datasets_expression,
  data = list(
    workflow_folder = ".",
    datasets_folder = "./datasets",
    design = design[1, ]
  )
)
call$start_and_wait()