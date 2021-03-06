% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/espn_team.R
\name{get_team_records}
\alias{get_team_records}
\title{Get Match Data for Rugby Teams}
\usage{
get_team_records(
  country = NULL,
  opposition = NULL,
  all = TRUE,
  type = c("team", "player")
)
}
\arguments{
\item{country}{Name of home team.}

\item{opposition}{If searching for results for the home team by specific opposition,
the opposition team name can be used here.}

\item{all}{\code{TRUE} by default, returns info on all teams, ignoring the previous
parameters.}

\item{type}{Defaults to "team". Other option is "player", which gets records for 
individual players by countries selected.}
}
\description{
Download data from ESPN's statsguru service. Data includes information
on various teams, win ratios, points scored etc.
}
