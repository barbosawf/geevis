# geevis (development version)

* Split out of `ufmmfu` (GEE / raster / vegetation-index tools only); code is
  unchanged apart from the package name.
* New `gee_tips()`: trilingual (pt-BR / English / Español) cheat sheet, as an HTML
  page with language buttons or as plain text in the console.
* `%||%` is now defined locally and `rlang::\`:=\`` imported explicitly, instead of
  relying on `import(rlang)`.
