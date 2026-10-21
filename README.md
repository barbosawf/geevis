# geevis

Google Earth Engine, satellite/drone imagery and vegetation indices for R, from
`rgee` setup to plot-level tables. Split out of
[`ufmmfu`](https://github.com/barbosawf/ufmmfu).

```r
# install.packages("pak")
pak::pak("barbosawf/geevis")

library(geevis)
gee_tips()                # cheat sheet (HTML, buttons: pt-BR / English / Español)
gee_tips(lang = "en", console = TRUE)   # same, as plain text in the console
```

## What it does

| Area | Functions |
|---|---|
| `rgee` setup & auth | `run_rgee_setup()`, `setup_rgee_python_env()`, `initialize_rgee()`, `get_ee_credential_paths()`, `has_cached_ee_token()`, `sync_ee_credentials()`, `reset_ee_python_module()` |
| EE assets | `get_asset_id()`, `get_bands()`, `get_available_bands()`, `get_native_scale()` |
| EE download | `create_time_table()`, `get_gee_data()` |
| Local (drone) rasters | `get_raster_data()`, `overlapping_raster_union()`, `find_non_covered_areas()`, `extract_date_and_phase()` |
| Vegetation indices | `get_vi_table()`, `extract_required_bands()`, `calc_vis_4()`, `calc_vis_rast()` |
| Vegetation segmentation | `compute_segmentation_index()`, `extract_formula_variables()`, `compute_threshold()`, `otsu_threshold()`, `triangle_threshold()`, `kmeans_threshold()` |

Requires the `terra`, `sf` and `rgee` packages (and a Google Cloud project with
the Earth Engine API for the GEE part).
