update_sysdata <- function() {
    fontawesome_data <- get_fontawesome_data()
    emoji_data <- get_emoji_data()
    save(fontawesome_data, emoji_data, file = "R/sysdata.rda")
    invisible(list(fontawesome_data = fontawesome_data, emoji_data = emoji_data))
}
