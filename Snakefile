singularity: "docker://komparo/tde_dataset_dyntoy"

rule all:
  input: dynamic("datasets/{dataset_ix}/meta.yaml")

rule generate_datasets:
  input:
    "design/{dataset_ix}.json"
  output:
    meta = "datasets/{dataset_ix}/meta.yaml",
    expression = "datasets/{dataset_ix}/expression.csv"
  script:
    "scripts/run.R"
    
rule generate_design:
  output:
    dynamic("design/{dataset_ix}.json")
  script:
    "scripts/create_design.R"

rule test:
  input:
    "datasets/1/meta.yaml"
