##' search fontawesome
##'
##' 
##' @title search_fontawesome
##' @param str string text
##' @param approximate logical
##' @return corresponding aliases
##' @export
##' @author ygc
search_fontawesome <- function(str, approximate=FALSE) {
    efproto$search(str=str, type='aliases', approximate=approximate, font_data=fontawesome_data)
}

##' convert fontawesome aliases to text
##'
##' 
##' @title fontawesome
##' @param aliases aliases
##' @return text
##' @export
##' @author ygc
fontawesome <- function(aliases) {
    mapper_(aliases, fontawesome_data)
}

##' load fontawesome
##'
##' 
##' @title load.fontawesome
##' @param font font
##' @return NULL
##' @export
##' @author ygc
load.fontawesome <- function(font = "fontawesome-webfont.ttf") {
    efproto$load_font(font=font, type='fontawesome')
}


##' @importFrom utils read.delim
get_fontawesome_data <- function() {
    ## copy font table from:
    ## https://fortawesome.github.io/Font-Awesome/cheatsheet/
    y <- read.delim(pipe("pbpaste"), stringsAsFactors=F)
    fa <- gsub("(.*)fa.*", '\\1', y[,1])
    html <- gsub(".*\\[(.*)\\].*",'\\1', y)

    aliases <- gsub(".*(fa.*)\\s+.*", '\\1', y)

    fontawesome_data <- data.frame(fa=fa, aliases=aliases, html=html, stringsAsFactors=FALSE)
    return(fontawesome_data)
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
