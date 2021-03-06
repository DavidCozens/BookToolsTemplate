# Pandoc Book Maker Template using docker and jenkins

Template for creating EPUB books from markdown using [Pandoc](https://pandoc.org/), [jenkins](https://www.jenkins.io/) and [docker](https://www.docker.com/)

## Introduction

There is so much information out there when starting to write a book, as well as the content there is a serious issue of which tool chain to use.
For me, as a software engineer I want to use the same text editing and build tools that I use when writing software.
For me that is [Visual Studio Code](https://code.visualstudio.com/),
[Jenkins](https://www.jenkins.io/) using [Docker](https://hub.docker.com/) to give a consistent build environment locally and on my Continuous Integration server.

On the assumption that I may end up self publishing this toolchain targets generation of an EPUB, and also [Amazon KDP](https://kdp.amazon.com/) for both Kindle and paperback.
(Or rather will do once I have it all working :laughing:)

## ToDo

* Decide on how to link to source code and embed it.
* Add markdown Lint to the build process
* Resize images for epub as they do not require the same resolution as printed books
* document how to adapt styling (once I know how)
* Generate error if there are files in the content that are not specified in the order

## Bugs

* Heading 5 and 6 have the following paragraph on the same line in pdf.
* Block quotes, add formatting to PDF and ebook
* Checklist isn't working in kindle from epub
* Fenced code block is double line spaced in kindle only

## Creating Your Own Content

This section explains how to customise this book template to create your own book.

### Overview

#### Title

Currently the title has to be specified in both [metadata.yaml](metadata.yaml) (see below) and the [makefile](makefile), just change the value of the *BOOKNAME* variable.

#### Metadata

Metadata for things like title, author etc. are held in [metadata.yaml](metadata.yaml), extra metadata specific to an output format is in an additional metadata file, e.g. [epubmetadata.yaml](epubmetadata.yaml).

#### Front Matter

Front Matter is specified in a similar way to chapters, place one markdown file for each piece of front matter in [FrontMatter](FrontMatter) and specify the order of front matter in [FrontMatterOrder.txt](FrontMatterOrder.txt). The type of Front Matter must be specified using the [epub:type attribute](https://pandoc.org/MANUAL.html#the-epubtype-attribute).

Front Matter would not normally be numbered so use an attribute to suppress numbering, see [Dedication.md](Dedication.md) for an example

#### BookContent

The entire content of the book is placed in the folder [BookContent](BookContent). There should be one markdown file per chapter.

#### Chapter Order

The Chapter order is defined by the order files are listed in [ChapterOrder.txt](ChapterOrder.txt)

#### Fonts

Control of the fonts used in the output of pandoc is complex, it is a complex problem. Pandoc can handle so many formats, on so many platforms. My own end target is KDP publishing for a paperback and an ebook for kindle. On kindles the end user can select the fonts used and so I have only applied minimal effort to selecting the font families used in epub.css. However for the paperback, I am generating a PDF and here I have full control.

The fonts to use are specified by name in <pdfmetadata.yaml>

```yaml
mainfont: "DejaVu Sans"
sansfont: "DejaVu Sans"
monofont: "DejaVu Sans Mono"
mathfont: "DejaVu Math TeX Gyre"
```

It took several attempts to get the name of the font correct. Building in the docker container means that the fonts need to be available in the container. So at the terminal prompt in the container in vscode execute

```bash
fc-list : family | cut -f1 -d"," | sort
```

At the time of writing this shows

```bash
DejaVu LGC Sans
DejaVu LGC Sans
DejaVu LGC Sans
DejaVu LGC Sans Mono
DejaVu LGC Serif
DejaVu LGC Serif
DejaVu Math TeX Gyre
DejaVu Sans
DejaVu Sans
DejaVu Sans
DejaVu Sans Mono
DejaVu Serif
DejaVu Serif
```

The fonts are installed when the docker container was built. I suggest deriving your own container if you wish to add more fonts.

To verify that fonts are actually embedded in the pdf look at the fonts tab in document properties in adobe acrobat.

![Document Properties->Fonts](ReadmeImages/pdf-font-properties.jpg)

## Using this template

I only use this template on Windows 11 using docker desktop and WSL2 with visual studio code with the docker extension. I believe that it should work on Linux or OSX (x86_64) with vscode as long as docker is installed and working. If it works for you (or doesn't please let me know).

If you don't want to work with docker then this may still work for you if you install the same tools as are used in the docker image [davidcozens/booktools](https://hub.docker.com/r/davidcozens/booktools), the source for this container is on github <https://github.com/DavidCozens/BookToolsDocker>

### git

This repository uses [git-lfs](https://git-lfs.github.com/). The Large File Storage is used because my books use images, I  prefer keeping high resolution images that are suitable for print, and then using the build system to generate smaller images for EPUB and kindle. The large image files will work better in git using git-lfs.

#### vscode

Open the folder containing this repo in vscode, when opened you will be prompted to re-open in the Dev Container, accept the option. When opening the container extensions will be installed to work with markdown and make. The books can be built with CTRL+SHIFT+B.

For finer control open a terminal and the build any of the targets in the makefile.

The pipeline configuration **MUST** specify an additional behaviour of *Git LFS pull after checkout*, the script path should point to *Jenkinsfile* as shown

### Jenkins

The jenkins job configuration for this template is in the Jenkinsfile, to add a job to jenkins create a new *Pipeline* item. Add whatever description and build triggers you require,

![Jenkins Configuration](ReadmeImages/Jenkins.jpg)

Following a build the books are made available as artefacts.

![Jenkins Artefacts](ReadmeImages/Artefacts.jpg)
