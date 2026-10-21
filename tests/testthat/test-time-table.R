test_that("create_time_table builds one row per month with consecutive dates", {
  tt <- create_time_table("2023-10", "2024-03", by = "month")
  expect_equal(nrow(tt), 6)
  expect_true(all(c("Year", "Phase", "start_date", "end_date") %in% names(tt)))
  expect_equal(tt$start_date[1], as.Date("2023-10-01"))
  expect_equal(tt$end_date[6], as.Date("2024-04-01"))
  # each phase starts where the previous one ended
  expect_equal(tt$start_date[-1], tt$end_date[-nrow(tt)])
})

test_that("create_time_table honors multi-month steps", {
  tt <- create_time_table("2023-10", "2024-09", by = "3 months")
  expect_equal(nrow(tt), 4)
})
