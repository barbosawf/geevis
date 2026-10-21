test_that("get_vi_table returns a usable index table", {
  vi <- get_vi_table()
  expect_s3_class(vi, "tbl_df")
  expect_named(vi, c("Index", "Equation", "Band"))
  expect_false(anyDuplicated(vi$Index) > 0)
})

test_that("extract_required_bands finds the generic bands an equation uses", {
  expect_setequal(extract_required_bands("(NIR - R) / (NIR + R)"), c("NIR", "R"))
  expect_setequal(
    extract_required_bands(c("(NIR - R) / (NIR + R)", "(NIR - G) / (NIR + G)")),
    c("NIR", "R", "G")
  )
})

test_that("calc_vis_4 computes indices and turns non-finite results into NA", {
  df <- data.frame(NIR = c(0.5, 0.8, 0), R = c(0.1, 0.2, 0))
  out <- calc_vis_4(df, data.frame(Index = "NDVI", Equation = "(NIR - R) / (NIR + R)"))
  expect_equal(out$NDVI, c(0.4 / 0.6, 0.6 / 1.0, NA))
})

test_that("calc_vis_rast agrees with calc_vis_4 on a small raster", {
  skip_if_no_terra()
  r <- terra::rast(nrows = 2, ncols = 2, nlyrs = 2)
  names(r) <- c("NIR", "R")
  terra::values(r) <- cbind(NIR = c(0.5, 0.8, 0.4, 0.9), R = c(0.1, 0.2, 0.2, 0.1))
  vis <- data.frame(Index = "NDVI", Equation = "(NIR - R) / (NIR + R)")

  out <- calc_vis_rast(r, vis)
  expected <- calc_vis_4(terra::as.data.frame(r), vis)$NDVI
  expect_equal(as.numeric(terra::values(out[["NDVI"]])), expected)
})

test_that("extract_formula_variables lists the symbols of a formula", {
  expect_setequal(extract_formula_variables("(NIR - R) / (NIR + R)"), c("NIR", "R"))
})

test_that("extract_date_and_phase parses the default file name convention", {
  ok <- extract_date_and_phase("Date_01_02_24_Flowering_x.tif")
  expect_equal(ok$date, "01_02_24")
  expect_equal(ok$phase, "Flowering")

  bad <- extract_date_and_phase("something_else.tif")
  expect_true(is.na(bad$date))
  expect_true(is.na(bad$phase))
})
