#' Pipe operator
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL

country_longname <- function(df) {
  data("countrycodes")
  suppressMessages({
    df %>% 
      full_join(countrycodes) %>% 
      filter(!is.na(Year))
    }
  )
}

url_check <- function(url) {
  tryer <- safely(read_html)
  result <- tryer(url)
  if (!is.null(result$error)) {
    msg <- glue("Call to {url} failed. \nWebsite may be temporarily down. \nIf this is not the case, please file an issue at github.com/RobertMyles/rugger.")
    suppressWarnings(closeAllConnections())
    stop(msg)
  }
}
