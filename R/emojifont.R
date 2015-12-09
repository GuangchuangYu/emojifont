##' list emoji fonts
##'
##' 
##' @title list.emojifonts
##' @return emoji font files
##' @export
##' @author ygc
list.emojifonts <- function() {
    font_path <- get.fontpath()
    list.files(font_path)
}

get.fontpath <- function() {
    system.file("fonts", package="emojifont")
}

##' load emoji font
##'
##' 
##' @title load.emojifont
##' @param font one of output from list.emojifonts
##' @return NULL
##' @importFrom sysfonts font.add
##' @importFrom showtext showtext.auto
##' @export
##' @author ygc
load.emojifont <- function(font = "OpenSansEmoji.ttf") {
    wd <- getwd()
    font_path <- get.fontpath()
    setwd(font_path)
    if (!file.exists(font)) {
        setwd(wd)
        stop("font doesn't exist...")
    }

    font.add(sub("\\..*", "", font), font)
    showtext.auto()
    setwd(wd)
}
