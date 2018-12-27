
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

## Usage

You can see the current world rankings with `get_rankings()`:

``` r
library(rugger)
get_rankings()
#> # A tibble: 105 x 7
#>    team         team_abbr points  rank played previous_points previous_rank
#>    <chr>        <chr>      <dbl> <int>  <int>           <dbl>         <int>
#>  1 New Zealand  NZL         92.5     1    209            92.5             1
#>  2 Ireland      IRE         91.2     2    182            91.2             2
#>  3 Wales        WAL         87.2     3    196            86.7             3
#>  4 England      ENG         86.2     4    189            85.5             4
#>  5 South Africa RSA         84.6     5    200            85.1             5
#>  6 Australia    AUS         82.4     6    217            83.1             6
#>  7 Scotland     SCO         81.8     7    177            81.6             7
#>  8 Fiji         FJI         77.9     8    111            76.4            10
#>  9 France       FRA         77.3     9    187            78.9             8
#> 10 Argentina    ARG         77.0    10    182            77.3             9
#> # ... with 95 more rows
```

Hmmm, what would happen if New Zealand played Ireland tomorrow, and
Ireland won by 5 points?

``` r
calculate_rank("New Zealand", "Ireland", score = c(15, 20))
#> # A tibble: 2 x 6
#>   team        points  rank points_exchanged new_points new_rank
#>   <chr>        <dbl> <int>            <dbl>      <dbl>    <int>
#> 1 Ireland       91.2     2             1.44       92.6        1
#> 2 New Zealand   92.5     1            -1.44       91.1        2
```

Yay, we’d jump into first place (sorry, biased\!).

Let’s have a look at the history between England and Scotland, the first
two teams to play the game:

``` r
get_team_records("England", "Scotland")
```

England winning almost 62% of the matches there.

I wonder which player has scored most tries in rugby?

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

get_team_records(type = "player") %>% 
  arrange(desc(points))
#> # A tibble: 50 x 16
#>    player start_year end_year matches start   sub points tries conversions
#>    <chr>       <dbl>    <dbl>   <int> <int> <int>  <int> <int>       <int>
#>  1 DW Ca…       2003     2015     112   106     6   1598    29         293
#>  2 RJR O…       2000     2013     130    87    43   1083    16         176
#>  3 SM Jo…       1998     2011     110    91    19    970     7         160
#>  4 PC Mo…       1997     2008     102    90    12    893    25         153
#>  5 FA Vl…       2006     2018     113    89    24    888    11         159
#>  6 M Kvi…       2003     2018     115    94    21    840    17         148
#>  7 CD Pa…       1999     2011     109    96    13    809    22          90
#>  8 Y Kus…       2005     2018     101    89    12    733    10         136
#>  9 MJ Gi…       2002     2016     103    89    14    698    30         106
#> 10 BG Ha…       2004     2016     124   122     2    335    67           0
#> # ... with 40 more rows, and 7 more variables: penalties <int>,
#> #   dropgoals <int>, gfm <int>, won <int>, lost <int>, draw <int>,
#> #   percent_won <dbl>
```

The sublime Dan Carter\!

## Data etc.

All of the data acessed by this package is obviously for
informational/educational use.

It belongs to [World Rugby](https://www.world.rugby/rankings/mru) and
[ESPN](http://stats.espnscrum.com/statsguru/rugby/stats/index.html). The
algorithm that calculates the rankings also belongs to World Rugby, you
can read about it [here](https://www.world.rugby/rankings/explanation).

1.  Black flags?\! They’re Github’s fault. The flags represent the
    rankings as of the tp 8 at the end of 2018 – New Zealand, Ireland,
    Wales, England, South Africa, Australia, Scotland and Fiji. You can
    see them in R with `emo::ji("wales")`, for example.
