##' wrapper layer for visualizing emoji
##'
##'
##' @title geom_emoji
##' @param alias emoji alias
##' @param color color
##' @param size size
##' @param x x position
##' @param y y position
##' @param vjust vertical adjustment
##' @param ... additional parameter for geom_text
##' @return ggplot2 layer
##' @export
##' @author guangchuang yu
geom_emoji <- function(alias="rose", color="#67001f", size=120, x=1, y=1, vjust=0.25, ...) {
    geom_emoji_(alias, color, size, x, y, vjust=vjust, ...)

}

##' wrapper layer for visualizing fontawesome
##'
##'
##' @title geom_fontawesome
##' @param alias fontawesome alias
##' @param color color
##' @param size size
##' @param x x position
##' @param y y position
##' @param ... additional parameter for geom_text
##' @return ggplot2 layer
##' @export
##' @author guangchuang yu
geom_fontawesome <- function(alias="fa-github", color="#67001f", size=120, x=1, y=1, ...) {
    geom_emoji_(alias, color, size, x, y, ..., .fun=fontawesome, family="fontawesome-webfont")
}

##' @importFrom ggplot2 geom_text
##' @importFrom ggplot2 aes_
geom_emoji_ <- function(alias, color="#67001f", size=120, x=1, y=1, ..., .fun=emoji, family="EmojiOne") {
    data <- data.frame(x=x, y=y, label=.fun(alias))
    geom_text(aes_(~x, ~y, label=~label), data=data, family=family, color=color, size=size, ...)
}
