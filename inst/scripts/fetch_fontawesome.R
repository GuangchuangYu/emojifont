base_url <- "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/"
urls <- c(
  paste0(base_url, "css/font-awesome.min.css"),
  paste0(base_url, "css/font-awesome.css")
)
ttf_url <- paste0(base_url, "fonts/fontawesome-webfont.ttf")

pat <- "\\.fa-([^:]+):before\\s*\\{[^}]*content:\\s*[\"']\\\\(f[0-9a-f]+)[\"']"
df <- NULL
for (css_url in urls) {
  message("Fetching Font Awesome 4.7 CSS from: ", css_url)
  css <- tryCatch(readLines(css_url, warn = FALSE), error = function(e) character())
  if (!length(css)) next
  s <- paste(css, collapse = "\n")
  gm <- gregexpr(pat, s, ignore.case = TRUE, perl = TRUE)
  starts <- attr(gm[[1]], "capture.start")
  lens <- attr(gm[[1]], "capture.length")
  if (!is.null(starts) && nrow(starts) > 0) {
    alias_part <- mapply(function(st, ln) substr(s, st, st + ln - 1), starts[,1], lens[,1], USE.NAMES = FALSE)
    hex_part <- mapply(function(st, ln) substr(s, st, st + ln - 1), starts[,2], lens[,2], USE.NAMES = FALSE)
    aliases <- paste0("fa-", alias_part)
    hex <- hex_part
    glyph <- vapply(hex, function(h) intToUtf8(strtoi(h, 16L)), character(1))
    html <- paste0("&#x", hex, ";")
    df <- data.frame(glyph = glyph, aliases = aliases, html = html, stringsAsFactors = FALSE)
    df <- df[!duplicated(df$aliases), ]
    rownames(df) <- NULL
    break
  }
}

if (is.null(df)) {
  warning("Failed to parse Font Awesome mappings from: ", paste(urls, collapse = " | "))
} else {
  out_csv <- file.path("inst", "fonts", "fontawesome_mapping.csv")
  dir.create(dirname(out_csv), recursive = TRUE, showWarnings = FALSE)
  write.csv(df, out_csv, row.names = FALSE)
  message("Saved mapping to ", out_csv, " (", nrow(df), " entries)")
}

dest_ttf <- file.path("inst", "fonts", "fontawesome-webfont.ttf")
dir.create(dirname(dest_ttf), recursive = TRUE, showWarnings = FALSE)
message("Downloading Font Awesome TTF from: ", ttf_url)
utils::download.file(ttf_url, dest_ttf, mode = "wb", quiet = TRUE)
message("Saved TTF to ", dest_ttf)
