/**************************** MODULE ********************************/
/******************* datasets/komparo/dyntoy ************************/
/********************************************************************/

params.test = false

/* Generate design */
process dataset_komparo_dyntoy_design {
  input:
  file "script.R" from Channel.fromPath('scripts/design.R').first()
  output:
  file '*.json' into design mode flatten

  cache 'deep'
  container 'komparo/tde_dataset_dyntoy'
  
  """
  #! /usr/bin/env Rscript

  set.seed(1)
  source('script.R')
  """
}

/* When testing, only take the first dataset */
if (params.test) {
  design = design.take(1)
}

/* Generate dataset */
process dataset_komparo_dyntoy_generate {
  input:
  file "script.R" from Channel.fromPath('scripts/run.R').first()
  file "design.json" from design
  output:
  file 'gene_expression.csv' into gene_expression
  file 'tde_overall.csv' into tde_overall
  file 'metadata.json' into metadata

  publishDir 'datasets/komparo/dyntoy/'
  errorStrategy 'ignore'
  cache 'deep'
  container 'komparo/tde_dataset_dyntoy'
  
  """
  #! /usr/bin/env Rscript

  set.seed(1)
  options(error=function()traceback(2))
  inputs <- list( 
    design = "design.json"
  )
  outputs <- list(
    gene_expression = "gene_expression.csv",
    tde_overall = "tde_overall.csv",
    metadata = "metadata.json"
  )
  source("script.R")
  """
}

datasets = gene_expression.merge(tde_overall, metadata) {a, b, c -> [gene_expression: a, tde_overall: b, metadata: c]}

/* Validate dataset */
process dataset_komparo_dyntoy_validate {
  input:
  file "script.R" from Channel.fromPath('scripts/validate.R').first()
  set file("gene_expression.csv"), file("tde_overall.csv"), file("metadata.json") from datasets

  output:
  stdout stdout
  cache 'deep'

  """
  #! /usr/bin/env Rscript

  set.seed(1)
  options(error=function()traceback(2))

  inputs <- list(
    gene_expression = "gene_expression.csv",
    tde_overall = "tde_overall.csv",
    metadata = "metadata.json"
  )

  source("script.R")
  """
}