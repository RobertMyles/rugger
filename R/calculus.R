#' @importFrom rlang enquo
#' @importFrom rlang !!
#' @importFrom dplyr filter
#' @importFrom dplyr select
#' @importFrom dplyr bind_rows
#' @importFrom dplyr mutate
#' @importFrom dplyr arrange
#' @importFrom dplyr desc
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
  
  ht <- rlang::enquo(home_team)
  at <- rlang::enquo(away_team)
  home_score = score[1]
  away_score = score[2]
  
  # checks
  if(identical(ht, at)) stop("Please choose two different teams.")
  if(!is.numeric(home_score)) stop("Scores must be numeric.")
  if(!is.numeric(away_score)) stop("Scores must be numeric.")
  
  # data
  base <- get_rankings() %>% 
    dplyr::filter(team %in% c(!! ht, !! at)) %>% 
    dplyr::select(team, points, rank)
  
  if(nrow(base) < 2) stop("Have you chosen two valid teams? See `teams()` for 
                          valid selections.")
  
  home <- base %>% dplyr::filter(team == !! ht)
  away <- base %>% dplyr::filter(team == !! at)
  
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
    dplyr::mutate(points_exchanged = points_exchange)
  away <- away %>% 
    dplyr::mutate(points_exchanged = points_away)
  
  base <- dplyr::bind_rows(home, away) %>% 
    dplyr::mutate(new_points = points + points_exchanged) %>% 
    dplyr::arrange(dplyr::desc(new_points)) %>% 
    dplyr::mutate(new_rank = 1:nrow(.))
  
  base
}
