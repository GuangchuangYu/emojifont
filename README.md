emojifont: using emoji font in `R`
---------

[emoGG](https://github.com/dill/emoGG/) is a good attemp to add `emoji` in `ggplot2`. It render `emoji` picture (png) and creat a layer, `geom_emoji`, to add emoji pictures.

In my opinion, although `emoji` maynot be treated as font internally, but it should be in user interface.


It will be more flexible if we can use emoji as ordinary font and in this way user don't need to learn extra stuff.


The `emojifont` package is designed to bring `emoji` font to R users and is created for users that are impatient and relutant to learn. 

The package is very simple, pack some emoji fonts (currently only [OpenSansEmoji.ttf](https://github.com/MorbZ/OpenSansEmoji)) and use [showtext](https://github.com/yixuan/showtext) to render the fonts, then we can use the font in either base plot or ggplot2.

# emojifont

## Installation

```r
devtools::install_github("GuangchuangYu/emojifont")
```

## load Emoji font 
```r
library(emojifont)
## list available emoji fonts
list.emojifonts()

## [1] "OpenSansEmoji.ttf"

## load selected emoji font
load.emojifont('OpenSansEmoji.ttf')
```

# Emoji characters

To use `emoji`, we need to use their corresponding unicode. The emoji unicode can be found in [http://apps.timwhitlock.info/emoji/tables/unicode](http://apps.timwhitlock.info/emoji/tables/unicode), or search using [remoji](https://github.com/richfitz/remoji) package.


# Emoji in R plot
## base plot

```r
require(remoji)
set.seed(123)
x <- rnorm(10)
set.seed(321)
y <- rnorm(10)
plot(x, y, cex=0)
text(x, y, labels=emoji('cow'), cex=1.5, col='steelblue', family='OpenSansEmoji')
```

![](https://raw.githubusercontent.com/GuangchuangYu/emojifont/master/inst/figures/base_emoji-1.png)

## ggplot2

```r
d <- data.frame(x=x, y=y,
     label = sample(c(emoji('cow'), emoji('camel')), 10, replace=TRUE),
     type = sample(LETTERS[1:3], 10, replace=TRUE))
require(ggplot2)
ggplot(d, aes(x, y, color=type, label=label)) + 
    geom_text(family="OpenSansEmoji", size=5)
```

![](https://raw.githubusercontent.com/GuangchuangYu/emojifont/master/inst/figures/ggplot_emoji-1.png)

## ggtree

```r
require(ggtree)
require(colorspace)

tree_text=paste0(
    "(","(","(",
       "(",
            "(",
               emoji("cow"), ",",
               "(",
                  emoji("whale"),",",
                  emoji("dolphin"),
               ")",
            "),",
            "(",
               emoji('pig2'),",",
               emoji('boar'),
            ")",
       "),",
       emoji("camel"),
    "),", emoji("fish"), "),", 
emoji("seedling"), ");")

ggtree(read.tree(text=tree_text)) + xlim(NA, 7) +
   geom_tiplab(family="OpenSansEmoji", size=10,
               color=rainbow_hcl(8))
```

![](https://raw.githubusercontent.com/GuangchuangYu/emojifont/master/inst/figures/ggtree_emoji-1.png)


# Apple Emoji

Although `R`'s graphical devices don't support Apple Emoji font, it's still possible to use it. We can export the `plot` to `svg` file and render it in `Safari`.

```r
library(gridSVG)
p <-  ggtree(read.tree(text=tree_text), size=2) + geom_tiplab(size=20)
p <- p %>% phylopic("79ad5f09-cf21-4c89-8e7d-0c82a00ce728", color="firebrick", alpha = .3)
p <- p + xlim(NA, 7) + ylim(NA, 8.5)
p
ps = grid.export("emoji.svg", addClass=T)
```

![](https://raw.githubusercontent.com/GuangchuangYu/emojifont/master/inst/figures/apple_emoji.png)


# Note

`OpenSansEmoji.ttf` in this package is downloaded from [https://github.com/MorbZ/OpenSansEmoji](https://github.com/MorbZ/OpenSansEmoji).

Feel free to fork this package to add your favorite Emoji Font.

