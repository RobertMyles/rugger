#' @title Return Six Nations Winners
#' @export
sixN_winners <- function() {
  base <- "http://www.lassen.co.nz/pickandgo.php?tourn=6N"
  url_check(base)
  message("Data courtesy of Lassen Creative Technologies, http://www.lassen.co.nz/pickandgo.php\n")
  x <- read_html(base) %>% 
    html_node("body > table:nth-child(4)") %>% 
    html_table() %>% 
    as_tibble() %>% 
    slice(-1:-2) %>% 
    filter(!str_detect(X1, "Total times"), !str_detect(X1, "Legend")) %>% 
    set_colnames(value = c("Year", "First", "points1", "Second", "points2",
                           "Third", "points3", "Fourth", "points4", "Fifth",
                           "points5", "Sixth", "points6")) %>% 
    pivot_longer(cols = c(First:points6),
                 names_to = "Position", values_to = "Country") %>% 
    mutate(Position = str_detect(Position, "points"), "points", Position) %>% 
    pivot_wider(id_cols = c(Year, Position), names_from = Position, 
                values_from = Country, values_fn = list(Country = list)) %>% 
    unnest(cols = c(`FALSE`, `TRUE`)) %>% 
    rename(Points = `TRUE`, Country = `FALSE`) %>% 
    mutate(
      `Grand Slam` = ifelse(str_detect(Country, "[\\*]{2}"), TRUE, FALSE),
      `Triple Crown` = ifelse(str_detect(Country, "[\\*]{1}"), TRUE, FALSE),
      Code = str_remove_all(Country, "[\\*]")
    ) %>% 
    select(-Country) %>% 
    country_longname() %>% 
    group_by(Year) %>% 
    mutate(Position = 1:6)
  x
}



rwc_winners <- function() {
  base <- "http://www.lassen.co.nz/pickandgo.php?tourn=WC"
  url_check(base)
  message("Data courtesy of Lassen Creative Technologies, http://www.lassen.co.nz/pickandgo.php\n")
  x <- read_html(base) %>% 
    html_node("body > table:nth-child(4)") %>% 
    html_table() %>% 
    as_tibble() %>% 
    slice(-1:-2) %>% 
    set_colnames(value = c("Year", "First", "Second", "Third", "Fourth",
                           "Host")) %>% 
    mutate(Host = ifelse(Year == "2019", "Japan", Host)) %>% 
    pivot_longer(cols = c(First:Fourth), names_to = "Position", values_to = "Code") %>% 
    country_longname()
  x
}
