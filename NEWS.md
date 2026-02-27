# emojifont 0.6.0

+ switch default emoji font to OpenMoji Black (2026-02-27, Fri)
+ keep backward compatibility: loading EmojiOne/OpenSansEmoji shows message and uses OpenMoji
+ update vignette to use OpenMoji family and related examples
+ add script `inst/scripts/fetch_openmoji_black.R` to download OpenMoji-Black.ttf
+ update `inst/scripts/fetch_fontawesome.R` to match runtime CSS parsing logic
+ add helper `update_sysdata()` to write `fontawesome_data` and `emoji_data` into R/sysdata.rda
+ migrate vignette to Quarto (VignetteBuilder: quarto) (2026-02-26, Thu)
+ add “Emoji in tables” example using `knitr::kable`
+ fix ggplot2 deprecation: replace `aes_()` with `aes()` and use `rlang::sym`
+ add `rlang` to Imports and update NAMESPACE accordingly

# emojifont 0.5.3

+ update docs, now `phylomoji` is documented on <http://yulab-smu.top/treedata-book/chapter8.html#phylomoji>.

# emojifont 0.5.2

+ mv `phylomoji` vignette
  to <https://guangchuangyu.github.io/software/ggtree/vignettes/phylomoji.html>
  (2018-05-23, Wed)
