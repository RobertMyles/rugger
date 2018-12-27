#' @importFrom tibble tibble
#' @importFrom tibble as_tibble
#' @importFrom xml2 read_html
#' @importFrom rvest html_node
#' @importFrom rvest html_table
#' @importFrom dplyr rename
#' @importFrom dplyr select
#' @importFrom dplyr mutate_at
#' @importFrom dplyr filter
#' @importFrom dplyr pull
#' @importFrom tidyr separate
#' @importFrom stringr str_to_lower
#' @title Get Match Data for Rugby Teams
#' @description Download data from ESPN's statsguru service. Data includes information
#' on various teams, win ratios, points scored etc.
#' @param country Name of country.
#' @param all \code{TRUE} by default, returns info on all teams. 
#' @export 
get_team_records <- function(country = NULL, all = TRUE){
  #cntry <- enquo(country)
  url <- "http://stats.espnscrum.com/statsguru/rugby/stats/index.html?class=1;"
  type <- "type=team"
  
  country_df <- tibble::tibble(
    country = c("england", "scotland", "ireland", "wales", "south africa",
                "australia", "new zealand", "france", "argentina", "usa",
                "romania", "fiji", "samoa", "tonga", "italy", "japan",
                "canada", "uruguay", "russia", "georgia", "pacific islanders",
                "american samoa"),
    number = c("1", "2", "3", "4", "5", "6", "8", "9", "10", "11", "12",
               "14", "15", "16", "20", "23", "25", "29", "57", "81",
               "121", "551")
    )
  
  get_rugger <- function(URL) {
    tabl <- xml2::read_html(URL) %>% 
      rvest::html_node("#scrumArticlesBoxContent > table:nth-child(2)") %>% 
      rvest::html_table() %>% 
      dplyr::rename(matches = Mat, percent_won = `%`, against = Aga,
             difference = Diff, conversions = Conv, penalties = Pens,
             dropgoals = Drop) %>% 
      dplyr::select(-GfM, -16) %>% 
      tidyr::separate(Span, into = c("start_year", "end_year"), sep = "-") %>% 
      dplyr::mutate_at(2:3, as.numeric)
    colnames(tabl) <- stringr::str_to_lower(colnames(tabl))
    tabl <- tibble::as_tibble(tabl)
    return(tabl)
  }
  
  if(is.null(country)){
    all_teams <- paste0(url, "template=results;", type)
    
    df <- get_rugger(all_teams)
    
    return(df)
  } else {
    
    ct <- stringr::str_to_lower(country)
    
    if(!ct %in% country_df$country) {
      stop("Selected country not available.")
    } else {
      
      team <- dplyr::filter(country_df, country == ct) %>% 
        dplyr::pull(number)
      req <- paste0(url, glue::glue("team={team};template=results;type=team"))
      df <- get_rugger(req)
      
      return(df)
    }
  }
}





