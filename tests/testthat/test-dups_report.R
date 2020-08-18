test_that("dups_report returns the original data frame by default when print_only = TRUE", {
  d <- data.frame(x = c("1", "2"), y = c("foo", "bar"))

  expect_identical(d, dups_report(d, x, print_only = TRUE))
})

test_that("dups_report returns the data when print_only = FALSE", {
  d <- data.frame(x = c("1", "2"), y = c("foo", "bar"))

  result <- data.frame(copies = 1,
                       observations = 2,
                       surplus = 0)

  expect_equal(result, dups_report(d, x, print_only = FALSE))

})


# dups_report(data.frame(x = c("1", "2"), y = c("foo", "bar")), x, print_only = FALSE) %>% str()
