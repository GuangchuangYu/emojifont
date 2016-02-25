##' @importFrom sysfonts font.add
##' @importFrom showtext showtext.auto
##' @importFrom proto proto
efproto <- proto(expr={
    get_path <- function(.) {
        system.file("fonts", package="emojifont")
    }
    list_fonts <- function(.) {
        list.files(get_path())
    }
    load_font <- function(., font) {
        wd <- getwd()
        font_path <- get_path()
        setwd(font_path)
        if (!file.exists(font)) {
            setwd(wd)
            stop("font doesn't exist...")
        }

        font.add(sub("\\..*", "", font), font)
        showtext.auto()
        setwd(wd)        
    }
    search <- function(., str, type, approximate=FALSE, font_data=emoji_data) {
        type <- match.arg(type, c('description', 'aliases', 'tags'))
        if (approximate) {
            i <- agrep(str, font_data[, type])
        } else {
            i <- grep(str, font_data[, type])
        }
        unlist(font_data$aliases[i])
    }
    toUnicode <- function(., aliases, font_data=emoji_data) {
        ## emoji_data$emoji[match(aliases, emoji_data$aliases)]
        ##
        ## match not work
        ## eg.
        ## > emoji_data$aliases[227]
        ## [[1]]
        ## [1] "dolphin" "flipper"
        ## > match('dolphin', emoji_data$aliases)
        ## [1] NA
        ##
        ii <- sapply(aliases, function(alias) {
            i <- which(sapply(font_data$aliases, function(x) alias %in% x))
            if (length(i) == 0)
                return(NA)
            return(i)
        })
        font_data$emoji[ii]
    }
})

##' list emoji fonts
##'
##' 
##' @title list.emojifonts
##' @return emoji font files
##' @export
##' @author ygc
list.emojifonts <- function() {
    efproto$list_fonts()
}

##' search emoji
##'
##' 
##' @title search_emoji
##' @param str string text
##' @param type one of 'aliases', 'description' and 'tags'
##' @param approximate logical
##' @return corresponding aliases, can be used to get unicode by emoji function
##' @export
##' @author ygc
search_emoji <- function(str, type='aliases', approximate=FALSE) {
    efproto$search(str=str, type=type, approximate=approximate)
}

##' convert emoji aliases to unicode
##'
##' 
##' @title emoji
##' @param aliases aliases
##' @return unicode
##' @export
##' @author ygc
emoji <- function(aliases) {
    res <- efproto$toUnicode(aliases=aliases)
    ii <- is.na(res)
    if (any(ii)) {
        stop('Invalid emoji: ', paste(aliases[ii], collapse=', '))
    }
    return(res)
}

##' load emoji font
##'
##' 
##' @title load.emojifont
##' @param font one of output from list.emojifonts
##' @return NULL
##' @export
##' @author ygc
load.emojifont <- function(font = "OpenSansEmoji.ttf") {
    efproto$load_font(font=font)
}


##' @importFrom utils download.file
download_emoji <- function() {
    url <- "https://raw.githubusercontent.com/github/gemoji/master/db/emoji.json"
    emoji_file <- tempfile(fileext='.json')
    download.file(url, destfile=emoji_file)
    jsonlite <- "jsonlite"
    require(jsonlite, character.only=TRUE)
    fromJSON <- eval(parse(text='fromJSON'))
    emoji_data <- fromJSON(readLines(emoji_file))
    save(emoji_data, file="sysdata.rda")
}
