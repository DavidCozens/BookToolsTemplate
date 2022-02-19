BOOKNAME = book
CONTENT_DIR = BookContent
CHAPTER_ORDER = ChapterOrder.txt
CHAPTERS = $(patsubst %,$(CONTENT_DIR)/%,$(strip $(file < $(CHAPTER_ORDER))))
COMMON_METADATA = metadata.yaml

COMMON_FLAGS = --from markdown --toc -N --resource-path=$(CONTENT_DIR)

EPUB_FLAGS = $(COMMON_FLAGS)
EPUB_METADATA = epubmetadata.yaml
EPUB_TARGET = $(BOOKNAME).epub

PDF_FLAGS = $(COMMON_FLAGS) --pdf-engine=xelatex --top-level-division=chapter -V geometry:"paperwidth=7.5in, paperheight=9.25in, top=0.75in, bottom=0.75in, inner=1.25in, outer=0.75in, twoside"
PDF_TARGET = $(BOOKNAME).pdf

PANDOC = pandoc

.PHONY: clean all epub pdf

all: epub pdf

epub: $(EPUB_TARGET) 

$(EPUB_TARGET): $(COMMON_METADATA) $(EPUB_METADATA) $(CHAPTER_ORDER) $(CHAPTERS) $(MAKEFILE_LIST)
	$(PANDOC)  $(EPUB_FLAGS) -o $@ $(COMMON_METADATA) $(EPUB_METADATA) $(CHAPTERS)

pdf: $(PDF_TARGET)

$(PDF_TARGET): $(COMMON_METADATA) $(CHAPTER_ORDER) $(CHAPTERS) $(MAKEFILE_LIST)
	$(PANDOC)  $(PDF_FLAGS) -o $@ $(COMMON_METADATA) $(CHAPTERS)

clean:
	$(RM) $(EPUB_TARGET)
	$(RM) $(PDF_TARGET)
