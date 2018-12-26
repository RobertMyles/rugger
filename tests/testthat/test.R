
test_that("Response is a data frame", {
  expect_is(get_rankings("men"), "tbl")
  expect_is(get_rankings("women"), "tbl")
  })