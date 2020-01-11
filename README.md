
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rugger

:new\_zealand: :ireland: 🏴󠁧󠁢󠁷󠁬󠁳󠁿 🏴󠁧󠁢󠁥󠁮󠁧󠁿 :south\_africa: :australia:
🏴󠁧󠁢󠁳󠁣󠁴󠁿 :fiji: \[1\]

rugger is a rrrrugby package :rugby\_football:. Get stats on teams,
players, rankings and calculate changes in the rankings for a certain
match.

## Installation

You can install rugger with:

``` r
remotes::install_github("RobertMyles/rugger")
```

I won’t be burdening CRAN with it.

## Usage

You can see the current world rankings with `get_rankings()`:

``` r
library(rugger)
get_rankings()
#> # A tibble: 105 x 7
#>    team         team_abbr points  rank played previous_points previous_rank
#>    <chr>        <chr>      <dbl> <int>  <int>           <dbl>         <int>
#>  1 South Africa RSA         94.2     1    212            94.2             1
#>  2 New Zealand  NZL         92.1     2    220            92.1             2
#>  3 England      ENG         88.8     3    204            88.8             3
#>  4 Wales        WAL         85.0     4    212            85.0             4
#>  5 Ireland      IRE         84.4     5    196            84.4             5
#>  6 Australia    AUS         81.9     6    227            81.9             6
#>  7 France       FRA         80.9     7    199            80.9             7
#>  8 Japan        JPN         79.3     8    174            79.3             8
#>  9 Scotland     SCO         79.2     9    190            79.2             9
#> 10 Argentina    ARG         78.3    10    190            78.3            10
#> # … with 95 more rows
```

Hmmm, what would happen if New Zealand played Ireland tomorrow, and
Ireland won by 5 points?

``` r
calculate_rank("New Zealand", "Ireland", score = c(15, 20))
#> # A tibble: 2 x 6
#>   team        points  rank points_exchanged new_points new_rank
#>   <chr>        <dbl> <int>            <dbl>      <dbl>    <int>
#> 1 New Zealand   92.1     2               -2       90.1        1
#> 2 Ireland       84.4     5                2       86.4        2
```

Let’s have a look at the history between England and Scotland, the first
two teams to play the game:

``` r
get_team_records("England", "Scotland")
#> Data courtesy of ESPN, http://stats.espnscrum.com/statsguru/rugby/
#> # A tibble: 1 x 15
#>   team  start_year end_year matches   won  lost  draw percent_won `for` against
#>   <chr>      <dbl>    <dbl>   <int> <int> <int> <int>       <dbl> <int>   <int>
#> 1 Engl…       1871     2019     137    75    43    19        61.7  1674    1225
#> # … with 5 more variables: difference <int>, tries <int>, conversions <int>,
#> #   penalties <int>, dropgoals <int>
```

England winning almost 62% of the matches there.

I wonder which player has scored most tries in rugby?

``` r
library(dplyr)

get_team_records(type = "player") %>% 
  arrange(desc(points)) %>% 
  select(player, points)
#> # A tibble: 50 x 2
#>    player                    points
#>    <chr>                      <int>
#>  1 DW Carter (NZ)              1598
#>  2 RJR O'Gara (Ire/Lions)      1083
#>  3 SM Jones (Lions/Wales)       970
#>  4 FA Vlaicu (Rom)              951
#>  5 M Kvirikashvili (Georg)      840
#>  6 CD Paterson (Scot)           809
#>  7 Y Kushnarev (Russ)           777
#>  8 MJ Giteau (Aust)             698
#>  9 BG Habana (SA)               335
#> 10 BG O'Driscoll (Ire/Lions)    250
#> # … with 40 more rows
```

The sublime Dan Carter\!

## Data etc.

All of the data acessed by this package is obviously for
informational/educational use, and a big thanks to all for making it
available.

It belongs to [World Rugby](https://www.world.rugby/rankings/mru) and
[ESPN](http://stats.espnscrum.com/statsguru/rugby/stats/index.html). The
algorithm that calculates the rankings also belongs to World Rugby, you
can read about it [here](https://www.world.rugby/rankings/explanation).
Some of the data is also pulled from [Pick and
Go](http://www.lassen.co.nz/pickandgo.php) by [Lassen Creative
Technologies](http://www.datacleanse.co.nz/).

1.  Black flags?\! They’re Github’s fault. The flags represent the
    rankings as of the end of 2018 – New Zealand, Ireland, Wales,
    England, South Africa, Australia, Scotland and Fiji. You can see
    them in R with `emo::ji("wales")`, for example, using the emo
    package, available from <https://github.com/hadley/emo>.
