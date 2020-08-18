#' Tag all observations that are duplicates
#'
#' Returns the dataframe with a new logical variable that denotes whether the observation
#' is a duplicate observation or not
#'
#' @param data data.frame or tibble
#' @param ... id variables
#' @param var name of the new logical variable that will be created (that identifies the duplicates in the dataset)
#'
#' @return
#' @export
#'
#' @examples
dups_tag <- function(data, ..., var = "dups_tag") {
  data %>%
    dplyr::group_by(...) %>%
    dplyr::mutate("{var}" := dplyr::n() > 1) %>%
    dplyr::ungroup()
}
