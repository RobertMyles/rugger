
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
```

Hmmm, what would happen if New Zealand played Ireland tomorrow, and
Ireland won by 5 points?

``` r
calculate_rank("New Zealand", "Ireland", score = c(15, 20))
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

get_team_records(type = "player") %>% 
  arrange(desc(points))
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
