#' View duplicate rows in the viewing portal
#'
#'
#'
#' @param data data.frame or tibble
#' @param ... id variables
#' @param n_viewing randomly select n_viewing observations to view (useful for large datasets)
#'
#' @return
#' @export
#'
#' @examples
dups_view <- function(data, ..., n_viewing = 200) {

  filtered_data <- data %>%
    dplyr::group_by(...) %>%
    dplyr::filter(n() > 1)

  if (is.null(n_viewing)) dplyr::view(filtered_data)

  else {
    n_groups <- dplyr::n_groups(filtered_data)
    if (n_groups < n_viewing) n_viewing <- n_groups

    view_n(filtered_data, n = n_viewing)
  }

  invisible(data)
}
