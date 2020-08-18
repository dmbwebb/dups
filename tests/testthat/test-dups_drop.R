test_that("dups_drop drops a duplicate observation", {
  d <- data.frame(x = c("A", "A"), y = c(1, 2))
  result <- dups_drop(d, x)
  expect_equal(nrow(result), 1)
})
