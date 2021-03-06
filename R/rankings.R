#' @export
get_rankings <- function(gender = c("men", "women")){
  
  gen <- match.arg(gender, choices = c("men", "women"))
  if(gen == "men") {
    url <- "https://cmsapi.pulselive.com/rugby/rankings/mru?language=en&client=pulse"
  } else {
    url <- "https://cmsapi.pulselive.com/rugby/rankings/wru?language=en&client=pulse"
  }
  
  txt <- read_lines(url)
  json <- fromJSON(txt)
  result <- tibble(
    team = json$entries$team$name,
    team_abbr = json$entries$team$abbreviation,
    points = json$entries$pts,
    rank = json$entries$pos,
    played = json$entries$matches,
    previous_points = json$entries$previousPts,
    previous_rank = json$entries$previousPos
  )
  
  return(result)
} 
