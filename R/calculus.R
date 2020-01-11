#' @importFrom rlang enquo
#' @importFrom rlang !!
#' @importFrom dplyr filter
#' @importFrom dplyr select
#' @importFrom dplyr group_by
#' @importFrom dplyr slice
#' @importFrom dplyr bind_rows
#' @importFrom dplyr mutate
#' @importFrom dplyr arrange
#' @importFrom dplyr desc
#' @importFrom dplyr rename
#' @importFrom dplyr mutate_at
#' @importFrom dplyr pull
#' @importFrom dplyr full_join
#' @importFrom jsonlite fromJSON
#' @importFrom readr read_lines
#' @importFrom tibble tibble
#' @importFrom tibble as_tibble
#' @importFrom xml2 read_html
#' @importFrom rvest html_node
#' @importFrom rvest html_table
#' @importFrom tidyr pivot_longer
#' @importFrom tidyr pivot_wider
#' @importFrom tidyr separate
#' @importFrom tidyr unnest
#' @importFrom stringr str_to_lower
#' @importFrom stringr str_detect
#' @importFrom stringr str_remove_all
#' @importFrom stringr str_sort
#' @importFrom glue glue
#' @importFrom purrr safely
#' @importFrom utils data
#' @importFrom magrittr set_colnames
#' @title Calculate Rankings 
#' @description Calculate rankings based on a match between two teams, the score,
#' home advantage and whether or not the match took place in a World Cup.
#' @param home_team Character vector of home team name. For a list of valid teams,
#' see \code{teams()}. 
#' @param away_team Character vector of away team name.
#' @param score Two-element numeric vector of scores. 
#' @param world_cup Whether the match took place in the Rugby World Cup or not.
#' @export
calculate_rank <- function(home_team = NULL, away_team = NULL,
                           score = c(0, 0), world_cup = FALSE) {
  ht <- enquo(home_team)
  at <- enquo(away_team)
  home_score = score[1]
  away_score = score[2]
  
  # checks
  if(identical(ht, at)) stop("Please choose two different teams.")
  if(!is.numeric(home_score)) stop("Scores must be numeric.")
  if(!is.numeric(away_score)) stop("Scores must be numeric.")
  
  # data
  base <- get_rankings() %>% 
    filter(team %in% c(!! ht, !! at)) %>% 
    select(team, points, rank)
  
  if(nrow(base) < 2) stop("Have you chosen two valid teams? See `teams()` for 
                          valid selections.")
  
  home <- base %>% filter(team == !! ht)
  away <- base %>% filter(team == !! at)
  
  # points gap
  gap <- (home$points + 3) - away$points
  sgn <- sign(gap)
  
  # max points exchange
  if(abs(gap) > 10) {
    gap <- 10 * sgn
  }
  
  # result
  if(home_score == away_score) {
    result <- 0
  } else if(home_score > away_score) {
    result <- 1
  } else {
    result <- -1
  }
  
  points_exchange <- (0.1 * gap - result) * -1
  
  # multipliers
  if(abs(home_score - away_score) > 15) {
    points_exchange <- points_exchange * 1.5
  }
  if(world_cup) {
    points_exchange <- points_exchange * 2
  }
  if(result <= 0 ) {
   points_away <- points_exchange * -1
  } else {
    points_away <- points_exchange
  }
  
  home <- home %>% 
    mutate(points_exchanged = points_exchange)
  away <- away %>% 
    mutate(points_exchanged = points_away)
  
  base <- bind_rows(home, away) %>% 
    mutate(new_points = points + points_exchanged) %>% 
    arrange(desc(new_points)) %>% 
    mutate(new_rank = 1:nrow(.))
  
  base
}
