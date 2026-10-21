# requireNamespace() (unlike skip_if_not_installed()) also catches a terra that
# is installed but cannot be loaded, e.g. one compiled against a GDAL version
# the system no longer has ("libgdal.so.34: cannot open shared object file").
skip_if_no_terra <- function() {
  testthat::skip_if_not(
    requireNamespace("terra", quietly = TRUE),
    "terra is not installed or cannot be loaded (reinstall it: install.packages(\"terra\"))"
  )
}
