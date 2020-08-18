
#' Filter to look at only non-unique rows based on id variables
#'
#' Filter a dataset to only look at rows that are duplicated, useful for diagnosing why there may be duplicates
#' in the data and therefore how to remove them
#'
#' @param data data.frame or tibble
#' @param ... id variables
#'
#' @return
#' @export
#'
#' @examples
dups_filter <- function(data, ...) {

  filtered_data <- data %>%
    dplyr::group_by(...) %>%
    dplyr::filter(n() > 1) %>%
    dplyr::ungroup()

  filtered_data

}
