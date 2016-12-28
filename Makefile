PKGNAME := $(shell sed -n "s/Package: *\([^ ]*\)/\1/p" DESCRIPTION)
PKGVERS := $(shell sed -n "s/Version: *\([^ ]*\)/\1/p" DESCRIPTION)
PKGSRC  := $(shell basename `pwd`)

all: rd check clean

alldocs: rd site

rd:
	Rscript -e 'roxygen2::roxygenise(".")'

build:
	cd ..;\
	R CMD build $(PKGSRC)

build2:
	cd ..;\
	R CMD build --no-build-vignettes $(PKGSRC)

install:
	cd ..;\
	R CMD INSTALL $(PKGNAME)_$(PKGVERS).tar.gz

check: build
	cd ..;\
	Rscript -e 'rcmdcheck::rcmdcheck("$(PKGNAME)_$(PKGVERS).tar.gz", args="--as-cran")'

check2: build
	cd ..;\
	R CMD check --as-cran $(PKGNAME)_$(PKGVERS).tar.gz


site: mkdocs

mkdocs: mdfiles
	cd mkdocs;\
	mkdocs build;\
	cd ../docs;\
	rm -rf fonts;\
	rm -rf css/font-awesome*

mdfiles:
	cd mkdocs;\
	Rscript -e 'library(ypages); gendoc("src/index.md", "blue", "docs/index.md")';\
	Rscript -e 'library(ypages); gendoc("src/gallery.md", "blue", "docs/gallery.md")';\
	cd docs;\
	ln -f -s ../emojifont/* ./;\
	ln -f -s ../mysoftware/* ./

clean:
	cd ..;\
	$(RM) -r $(PKGNAME).Rcheck/


