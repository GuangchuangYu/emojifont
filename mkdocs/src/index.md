<!-- addtoany:= -->

<link rel="stylesheet" href="https://guangchuangyu.github.io/css/font-awesome.min.css">


[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/emojifont?color=blue)](http://cran.r-project.org/package=emojifont)
![](http://cranlogs.r-pkg.org/badges/grand-total/emojifont?color=blue)
![](http://cranlogs.r-pkg.org/badges/emojifont?color=blue)
![](http://cranlogs.r-pkg.org/badges/last-week/emojifont?color=blue)

`emojifont` is an implementation of using emoji font in both base and
'ggplot2' graphics. `emojifont` is released on
[CRAN](https://cran.r-project.org/package=emojifont) and the source
code is hosted on <a href="https://github.com/GuangchuangYu/emojifont"><i class="fa fa-github fa-lg"></i> GitHub</a>.

## <i class="fa fa-user"></i> Author

Guangchuang Yu, School of Public Health, The University of Hong Kong.

## <i class="fa fa-download"></i> Installation

To install `emojifont`, start R and enter:

```r
install.packages("emojifont")
```

## <i class="fa fa-book"></i> Examples

#### <i class="fa fa-angle-double-right"></i> base plot

```r
require(remoji)
set.seed(123)
x <- rnorm(10)
set.seed(321)
y <- rnorm(10)
plot(x, y, cex=0)
text(x, y, labels=emoji('cow'), cex=1.5, col='steelblue', family='OpenSansEmoji')
```

![](https://raw.githubusercontent.com/GuangchuangYu/emojifont/master/vignettes/figures/base_emoji-1.png)

#### <i class="fa fa-angle-double-right"></i> ggplot2

```r
dd=data.frame(x=emoji(c("satisfied", "disapointed")), y=c(50, 10))
emoji_text=element_text(family="OpenSansEmoji", size=20)
ggplot(dd, aes(x, y)) + geom_bar(stat='identity', aes(fill=x)) +
     ggtitle(paste(emoji(c("+1", "-1")), collapse=" "))+
     theme(axis.text.x = emoji_text, legend.text=emoji_text, title=emoji_text) +
     xlab(NULL)+ylab(NULL)
```

![](http://guangchuangyu.github.io/blog_images/2015/Screenshot%202015-12-16%2011.10.51.png)


#### <i class="fa fa-angle-double-right"></i> ggtree

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

![](https://raw.githubusercontent.com/GuangchuangYu/emojifont/master/vignettes/figures/ggtree_emoji-1.png)

Found out more on <https://cran.r-project.org/web/packages/emojifont/vignettes/emojifont.html>.

## <i class="fa fa-wordpress"></i> Blog posts

+ [use emoji font in R](https://guangchuangyu.github.io/2015/12/use-emoji-font-in-r)
+ [font awesome supported in emojifont](https://guangchuangyu.github.io/2016/03/font-awesome-supported-in-emojifont)
