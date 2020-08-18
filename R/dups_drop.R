#' Drop duplicates
#'
#' @param data data.frame or tibble
#' @param ... id variables
#' @param warn logical, when TRUE (default), the function will warn you about how many observations are being dropped
#'
#' @return
#' @export
#'
#' @examples
dups_drop <- function(data, ..., warn = TRUE) {

  data_new <- data %>%
    dplyr::distinct(..., .keep_all = TRUE)

  n_before <- nrow(data)
  n_after <- nrow(data_new)
  n_dropped <- n_before - n_after
  if (warn) warning(paste("Dropping ", n_dropped, " rows due to duplication"))

  data_new
}
