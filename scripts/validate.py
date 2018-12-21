True

# library(tidyverse)

# ##
# deparse_friendly <- function(x) {
#   deparse(x, width.cutoff = 500) %>% glue::glue_collapse("")
# }

# validate <- function(expr, info = NULL, hint = NULL) {
#   expr <- rlang::enquo(expr)
#   result <- rlang::eval_tidy(expr)
#   if (!isTRUE(result)) {
#     if (is.null(info)) {
#         info <- deparse_friendly(expr)
#     }
#     stop(info, hint, call. = FALSE)
#   }
#   invisible(TRUE)
# }
# ##

# gene_expression <- read.csv(inputs$gene_expression, header = TRUE, row.names = 1)
# gene_ids <- colnames(gene_expression)

# if ("tde_overall" %in% names(inputs)) {
#     tde_overall <- read_csv(inputs$tde_overall)

#     validate(all(tde_overall$feature_id %in% gene_ids))
# }

