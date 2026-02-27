#' search fontawesome
#'
#'
#' @title search_fontawesome
#' @param str string text
#' @param approximate logical
#' @return corresponding aliases
#' @export
#' @author ygc
search_fontawesome <- function(str, approximate=FALSE) {
    ensure_fontawesome_data()
    efproto$search(str=str, type='aliases', approximate=approximate, font_data=fontawesome_data)
}

fontawesome_data <- NULL

ensure_fontawesome_data <- function() {
    if (!exists("fontawesome_data", inherits = FALSE) ||
        !is.data.frame(fontawesome_data) ||
        nrow(fontawesome_data) == 0) {
        df <- try(get_fontawesome_data(), silent = TRUE)
        if (inherits(df, "try-error") || !is.data.frame(df) || nrow(df) == 0) {
            .fa_hex <- c(
                "fa-github"  = "f09b",
                "fa-weibo"   = "f18a",
                "fa-twitter" = "f099",
                "fa-android" = "f17b",
                "fa-coffee"  = "f0f4"
            )
            .glyph <- vapply(.fa_hex, function(h) intToUtf8(strtoi(h, 16L)), character(1))
            .aliases <- names(.fa_hex)
            .html <- paste0("&#x", unname(.fa_hex), ";")
            df <- data.frame(
                glyph = .glyph,
                aliases = .aliases,
                html = .html,
                stringsAsFactors = FALSE
            )
        }
        utils::assignInNamespace("fontawesome_data", df, ns = "emojifont")
    }
}


#' random fontawesome
#'
#'
#' @title sample_fontawesome
#' @param size a non-negative integer giving the number of items to choose
#' @param replace Should sampling be with replacement?
#' @return random fontawesome
#' @export
#' @examples
#' sample_fontawesome(3)
#' @author Guangchuang Yu
sample_fontawesome <- function(size, replace=FALSE) {
    ensure_fontawesome_data()
    x <- fontawesome_data$aliases
    if (length(x) == 0) return(character(0))
    sample(x, size, replace = replace || size > length(x))
}

#' convert fontawesome aliases to text
#'
#'
#' @title fontawesome
#' @param aliases aliases
#' @return text
#' @export
#' @examples
#' fontawesome('fa-twitter')
#' @author ygc
fontawesome <- function(aliases) {
    ensure_fontawesome_data()
    mapper_(aliases, fontawesome_data)
}

#' load fontawesome
#'
#'
#' @title load.fontawesome
#' @param font font
#' @return NULL
#' @export
#' @author ygc
load.fontawesome <- function(font = "fontawesome-webfont.ttf") {
    efproto$load_font(font=font, type='fontawesome')
}


#' @importFrom utils read.delim
get_fontawesome_data <- function() {
    urls <- c(
        "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css",
        "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"
    )
    pat <- "\\.fa-([^:]+):before\\s*\\{[^}]*content:\\s*[\"']\\\\(f[0-9a-f]+)[\"']"
    for (url_css in urls) {
        css <- tryCatch(readLines(url_css, warn = FALSE), error = function(e) character())
        if (!length(css)) next
        s <- paste(css, collapse = "\n")
        gm <- gregexpr(pat, s, ignore.case = TRUE, perl = TRUE)
        starts <- attr(gm[[1]], "capture.start")
        lens <- attr(gm[[1]], "capture.length")
        if (!is.null(starts) && nrow(starts) > 0) {
            alias_part <- mapply(function(st, ln) substr(s, st, st + ln - 1),
                                 starts[, 1], lens[, 1], USE.NAMES = FALSE)
            hex_part <- mapply(function(st, ln) substr(s, st, st + ln - 1),
                               starts[, 2], lens[, 2], USE.NAMES = FALSE)
            aliases <- paste0("fa-", alias_part)
            hex <- hex_part
            glyph <- vapply(hex, function(h) intToUtf8(strtoi(h, 16L)), character(1))
            html <- paste0("&#x", hex, ";")
            df <- data.frame(glyph = glyph, aliases = aliases, html = html, stringsAsFactors = FALSE)
            df <- df[!duplicated(df$aliases), ]
            rownames(df) <- NULL
            return(df)
        }
    }
    stop("No fontawesome mappings parsed from CSS at ", paste(urls, collapse = " | "))
}


## example
## library(emojifont)
## load.fontawesome()
## set.seed(123)
## d = data.frame(x=rnorm(20),
##                y=rnorm(20),
##                z=sample(fontawesome(c('fa-weibo','fa-github', 'fa-twitter', 'fa-apple')), replace=T, 10))

## library(ggplot2)
## ggplot(d, aes(x, y, color=z)) + geom_text(aes(label=z), family='fontawesome-webfont', size=8)
