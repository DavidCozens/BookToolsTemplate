# Pandoc Book Maker Template using docker and jenkins

Template for creating EPUB books from markdown using [Pandoc](https://pandoc.org/), [jenkins](https://www.jenkins.io/) and [docker](https://www.docker.com/)

## Introduction

There is so much information out there when starting to write a book, as well as the content there is a serious issue of which tool chain to use.  For me, as a software engineer I want to use the same text editing and build tools that I use when writing software. For me that is [Visual Studio Code](https://code.visualstudio.com/), [Jenkins](https://www.jenkins.io/) using [Docker](https://hub.docker.com/) to give a consistent build environment locally and on my Continuous Integration server.

On the assumption that I may end up self publishing this toolchain targets generation of an EPUB, and also [Amazon KDP](https://kdp.amazon.com/) for both Kindle and paperback.  (Or rather will do once I have it all working :laughing:)

## ToDo

* PDF front matter needs to be investigated. Some is present but its a mess
* PDF Specified proper page size and margins
* PDF KDF request embedded fonts, select fonts and embed
* Separate epub and ebook for kindle build targets
* Decide on how to link to source code and embed it.
* Add markdown Lint to the build process
* Resize images for epub as they do not require the same resolution as printed books
* document how to adapt styling (once I know how)

## Bugs

* Heading 5 and 6 have the following paragraph on the same line in pdf.
* Image position with respect to text is incorrect in pdf
* Spacing in lists, especially unordered is poor
* Block quotes, add formatting to PDF and ebook
* Checklist isn't working in kindle from epub
* Definition list formatting in epub should be improved
* Fenced code block is double line spaced in kindle only
* Highlights are not working at all
* Strike through is not working
* Table formatting is inconsistent between formats

## Creating Your Own Content

This section explains how to customise this book template to create your own book.

### Overview

#### Title

Currently the title has to be specified in both [metadata.yaml](metadata.yaml) (see below) and the [makefile](makefile), just change the value of the *BOOKNAME* variable.

#### Metadata

Metadata for things like title, author etc. are held in [metadata.yaml](metadata.yaml), extra metadata specific to an output format is in an additional metadata file, e.g. [epubmetadata.yaml](epubmetadata.yaml).

#### BookContent

The entire content of the book is placed in the folder [BookContent](BookContent). There should be one markdown file per chapter.

#### Chapter Order

The Chapter order is defined by the order files are listed in [ChapterOrder.txt](ChapterOrder.txt)


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
