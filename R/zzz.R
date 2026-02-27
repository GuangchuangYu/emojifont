.onLoad <- function(libname, pkgname) {
    utils::globalVariables(c("fontawesome_data"))
}

.onAttach <- function(libname, pkgname) {
    tryCatch(load.emojifont(), error = function(e) {
        packageStartupMessage("Emoji font not loaded: ", conditionMessage(e))
    })
    tryCatch(load.fontawesome(), error = function(e) {
        packageStartupMessage("Font Awesome not loaded: ", conditionMessage(e))
    })
}
