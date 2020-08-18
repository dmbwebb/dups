#' Count the total number of duplicate observations in a dataset
#'
#' @param data data.frame or tibble
#' @param ... id variables
#'
#' @return
#' @export
#'
#' @examples
dups_count <- function(data, ...) {
  dat_dups <- data %>%
    dups_tag(...)

  sum(dat_dups$dups_tag == TRUE)
}
