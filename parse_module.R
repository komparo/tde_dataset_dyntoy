parse_module <- function(path = "module.yml") {
  blueprint <- yaml::read_yaml(path)
  
  design <- extract_design_r(blueprint[["design@R"]])
  
}

extract_design_r <- function(input) {
  exprs <- rlang::parse_exprs(input)
  
  parse_design <- function(exprs) {
    library(tidyr)
    library(purrr)
    library(dplyr)
    
    set.seed(1)
    
    output <- map(exprs, rlang::eval_tidy)
    
    last(output)
  }
  
  callr::r(
    parse_design,
    list(exprs = exprs)
  )
}

parse_module()