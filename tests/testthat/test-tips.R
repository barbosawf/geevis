walk_L <- function(x, f) {
  if (is.character(x) && identical(names(x), .tips_langs)) {
    f(x)
  } else if (is.list(x)) {
    invisible(lapply(x, walk_L, f = f))
  }
}

test_that("every translated string has all three languages, non-empty", {
  content <- .gee_tips_content()
  n <- 0
  walk_L(content, function(x) {
    n <<- n + 1
    expect_true(all(nzchar(x)), info = paste(x, collapse = " | "))
  })
  expect_gt(n, 50)
})

test_that("every exported function is documented in the cheat sheet", {
  content <- .gee_tips_content()
  text <- paste(unlist(lapply(content$reference, function(g) {
    vapply(g$items, `[[`, character(1), "fn")
  })), collapse = " ")
  exported <- setdiff(getNamespaceExports("geevis"), "gee_tips")
  missing <- exported[!vapply(exported, grepl, logical(1), x = text, fixed = TRUE)]
  expect_equal(missing, character(0))
})

test_that("the HTML page has the three languages and the switch buttons", {
  path <- gee_tips(open = FALSE, lang = "en")
  html <- paste(readLines(path, encoding = "UTF-8"), collapse = "\n")
  expect_match(html, 'data-lang="en"', fixed = TRUE)
  for (l in c("pt-BR", "en", "es")) {
    expect_match(html, sprintf('data-set="%s"', l), fixed = TRUE)
    expect_match(html, sprintf('<span data-l="%s">', l), fixed = TRUE)
  }
  expect_match(html, "GEE / imagery / vegetation indices cheat sheet", fixed = TRUE)
  expect_match(html, "Guia rápido de GEE / imagens / índices de vegetação", fixed = TRUE)
  expect_false(grepl("@@", html, fixed = TRUE))
})

test_that("console mode prints the chosen language", {
  expect_output(gee_tips(console = TRUE, lang = "es"), "Guía rápida de GEE / imágenes / índices de vegetación")
  expect_output(gee_tips(console = TRUE, lang = "en"), "Downloading bands and vegetation indices")
  expect_output(gee_tips(console = TRUE), "Baixar bandas e índices")
  expect_error(gee_tips(lang = "fr"))
})
