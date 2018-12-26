
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rugger

:new\_zealand: :ireland: 🏴󠁧󠁢󠁷󠁬󠁳󠁿 🏴󠁧󠁢󠁥󠁮󠁧󠁿 :south\_africa: :australia:
🏴󠁧󠁢󠁳󠁣󠁴󠁿 :fiji: \[1\]

(WIP) rugger is a rrrrugby package :rugby\_football:. You can see the
current world rankings with `get_rankings()` and calculate the impact on
the rankings of a hypothetical match with `calculate_rank()`. Right now
it gets some data from [World Rugby]() and does some little
calculations, maybe in the future it’ll have info from
[ESPN](http://stats.espnscrum.com/statsguru/rugby/stats/index.html) and
[Rugby Data](http://www.rugbydata.com). Let’s see. If you’re interested,
feel free to fork and submit a PR.

## Installation

You can install rugger with:

``` r
remotes::install_github("RobertMyles/rugger")
```

## Data etc.

All of the data acessed by this package is obviously for
informational/educational use. It belongs to World Rugby. The algorithm
that calculates the rankings also belongs to World Rugby, you can read
about it [here](https://www.world.rugby/rankings/explanation).

1.  Black flags?\! They’re Github’s fault. The flags represent the
    rankings as of the tp 8 at the end of 2018 – New Zealand, Ireland,
    Wales, England, South Africa, Australia, Scotland and Fiji. You can
    see them in R with `emo::ji("wales")`, for example.
