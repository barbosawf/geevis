#' Cheat Sheet for the GEE, Raster and Vegetation-Index Helpers (pt-BR, English, Spanish)
#'
#' @description
#' Shows every exported function of this package, organized around
#' \emph{workflows} -- first-time \pkg{rgee} setup, fixing Earth Engine
#' credentials, inspecting a GEE asset, building the phases table,
#' downloading bands and vegetation indices from Google Earth Engine,
#' extracting them from local (drone) rasters, vegetation segmentation --
#' plus a reference table with what each function does.
#'
#' By default the cheat sheet is rendered as a self-contained HTML page and
#' opened in the system browser, with buttons at the top right to switch
#' between \strong{Português (pt-BR)}, \strong{English} and
#' \strong{Español} without reloading. Alternatively, with
#' \code{console = TRUE} the same content is printed as plain text in the R
#' console, in the language given by \code{lang}.
#'
#' @param open Logical. If \code{TRUE} (default), opens the HTML page in the
#'   system browser with \code{\link[utils]{browseURL}}. Set to \code{FALSE}
#'   to only write the file (e.g. in non-interactive sessions). Ignored when
#'   \code{console = TRUE}.
#' @param lang Character. Initial language: \code{"pt-BR"} (default),
#'   \code{"en"} or \code{"es"}. In the HTML page it can be changed at any
#'   time with the buttons.
#' @param console Logical. If \code{TRUE}, prints the cheat sheet in the
#'   console (in \code{lang}) instead of writing/opening an HTML page.
#'   Default \code{FALSE}.
#' @return Invisibly returns the path to the generated HTML file, or
#'   \code{NULL} when \code{console = TRUE}.
#' @export
#'
#' @examples
#' \dontrun{
#' gee_tips()                             # HTML page, starts in pt-BR
#' gee_tips(lang = "en")                  # HTML page, starts in English
#' gee_tips(lang = "es", console = TRUE)  # plain text in the console
#' }
gee_tips <- function(open = TRUE, lang = c("pt-BR", "en", "es"), console = FALSE) {
  lang <- match.arg(lang)
  .show_tips(.gee_tips_content(), lang = lang, open = open, console = console,
             file_stub = "geevis_gee_tips")
}
