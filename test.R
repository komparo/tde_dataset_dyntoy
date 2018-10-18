source('workflow.R')

call <- rlang::eval_tidy(
  generate_datasets_expression,
  data = list(
    design = design[1, ],
    params = list(workflow_folder = ".", datasets_folder = ".")
  )
)
call$start_and_wait()