rule all:
  input: "data/datasets.csv"

rule list_datasets:
  output: "data/datasets.csv"
  input: dynamic("data/{dataset_id}/expression.csv")
  script:
    "scripts/list_datasets.R"

rule generate_datasets:
  input:
    "design/{dataset_id}.json"
  output:
    expression = "data/{dataset_id}/expression.csv"
  script:
    "scripts/run.R"
    
rule dataset_design_dyntoy:
  output:
    dynamic("design/{dataset_id}.json")
  script:
    "scripts/create_design.R"
    
