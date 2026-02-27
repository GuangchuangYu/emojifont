url <- "https://github.com/hfg-gmuend/openmoji/raw/refs/heads/master/font/OpenMoji-black-glyf/OpenMoji-black-glyf.ttf"
dest_dir <- file.path("inst", "emoji_fonts")
dest_file <- file.path(dest_dir, "OpenMoji.ttf")
dir.create(dest_dir, recursive = TRUE, showWarnings = FALSE)
message("Downloading OpenMoji Black from: ", url)
utils::download.file(url, dest_file, mode = "wb", quiet = TRUE)
message("Saved to ", dest_file)
