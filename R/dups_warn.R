#' Warn if there are duplicates in a dataset
#'
#' For use within functions, warns the user if there are any duplicates in the data
#'
#' @param data data.frame or tibble
#' @param ... id variables
#'
#' @return
#' @export
#'
#' @examples
dups_warn <- function(data, ...) {
  n_dups <- dups_count(data, ...)
  if (n_dups > 0) warning(paste0("There are ", n_dups, " non-unique rows in the dataset"))

  invisible(data)
}


#' Stop if there are duplicates in a dataset
#'
#' For use within functions, stops operations and throws an error if there are any duplicates in the data
#'
#' @param data data.frame or tibble
#' @param ... id variables
#'
#' @return
#' @export
#'
#' @examples
dups_stop <- function(data, ...) {
  n_dups <- dups_count(data, ...)
  if (n_dups > 0) stop(paste0("There are ", n_dups, " non-unique rows in the dataset"))

  invisible(data)

}
