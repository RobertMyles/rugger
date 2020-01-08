xfun::pkg_attach(c("rvest", "dplyr", "magrittr", "tidyr", "stringr"))

sixN_winners <- function(wide = FALSE) {
  read_html("http://www.lassen.co.nz/pickandgo.php?tourn=6N") %>% 
    html_node("body > table:nth-child(4)") %>% 
    html_table() %>% 
    as_tibble() %>% 
    slice(-1:-2) %>% 
    set_colnames(value = c("Year", "First", "points1", "Second", "points2",
                           "Third", "points3", "Fourth", "points4", "Fifth",
                           "points5", "Sixth", "points6")) %>% 
    pivot_longer(cols = c(First:points6),
                 names_to = "Position", values_to = "Country") %>% 
    mutate(Position = str_detect(Position, "points"), "points", Position) %>% 
    pivot_wider(id_cols = c(Year, Position), names_from = Position, values_from = Country)
}
rwc_winners <- function(wide = TRUE) {
  stopifnot(wide %in% c(TRUE, FALSE))
  x <- read_html("http://www.lassen.co.nz/pickandgo.php?tourn=WC") %>% 
    html_node("body > table:nth-child(4)") %>% 
    html_table() %>% 
    as_tibble() %>% 
    slice(-1:-2) %>% 
    set_colnames(value = c("Year", "First", "Second", "Third", "Fourth",
                           "Host")) %>% 
    mutate(Host = ifelse(Year == "2019", "Japan", Host))
  if (!wide) {
    x <- x %>% 
      pivot_longer(cols = c(First:Fourth), 
                   names_to = "Position", values_to = "Country")
    x
  } else {
    x
  }
}
