#' Print a duplicates report
#'
#' Prints a reports of all the duplicates in a dataframe based on the uniquely identifying
#' variable(s)
#'
#' @param data data.frame or tibble
#' @param ... id variables
#' @param print_only logical. Does the report get printed and then return the original dataframe (default), or
#' does it return the tibble with the duplicate details?
#'
#' @return
#' @export
#'
#'
#' @examples
dups_report <- function(data, ..., print_only = TRUE) {
  dups_report <- data %>%
    dplyr::count(...) %>%
    dplyr::rename(copies = n) %>%
    dplyr::count(copies) %>%
    dplyr::mutate(observations = n * copies,
           surplus = observations - (observations / copies)) %>%
    dplyr::select(-n)

  if (print_only) {
    print(dups_report)
    invisible(data)
  } else if (!print_only) {
    dups_report
  }


}
