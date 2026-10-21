bimodal <- function() {
  set.seed(42)
  c(rnorm(500, mean = 0.2, sd = 0.05), rnorm(500, mean = 0.8, sd = 0.05))
}

test_that("all three methods put the threshold between two clear modes", {
  x <- bimodal()
  for (f in list(otsu_threshold, triangle_threshold, kmeans_threshold)) {
    th <- f(x)
    expect_gt(th, 0.2)
    expect_lt(th, 0.8)
  }
})

test_that("compute_threshold dispatches to the matching method", {
  x <- bimodal()
  expect_equal(compute_threshold(x, "otsu"), otsu_threshold(x))
  expect_equal(compute_threshold(x, "triangle"), triangle_threshold(x))
  expect_equal(compute_threshold(x, "kmeans"), kmeans_threshold(x))
  expect_error(compute_threshold(x, "nope"))
})

test_that("compute_segmentation_index evaluates a formula on raster layers", {
  skip_if_no_terra()
  r <- terra::rast(nrows = 2, ncols = 2, nlyrs = 2)
  names(r) <- c("NIR", "R")
  terra::values(r) <- cbind(NIR = c(0.5, 0.8, 0.4, 0.9), R = c(0.1, 0.2, 0.2, 0.1))
  idx <- compute_segmentation_index(r, "(NIR - R) / (NIR + R)")
  expect_equal(as.numeric(terra::values(idx)),
               c(0.4, 0.6, 0.2, 0.8) / c(0.6, 1.0, 0.6, 1.0))
})
