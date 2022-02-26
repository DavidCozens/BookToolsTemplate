BOOKNAME = book
CONTENT_DIR = BookContent
CHAPTER_ORDER = ChapterOrder.txt
CHAPTERS = $(patsubst %,$(CONTENT_DIR)/%,$(strip $(file < $(CHAPTER_ORDER))))

FRONTMATTER_DIR = FrontMatter
FRONTMATTER_ORDER = FrontMatterOrder.txt
FRONTMATTER = $(patsubst %,$(FRONTMATTER_DIR)/%,$(strip $(file < $(FRONTMATTER_ORDER))))

COMMON_FLAGS = --from markdown --toc -N --toc-depth=1 --resource-path=$(CONTENT_DIR) 

EPUB_FLAGS = $(COMMON_FLAGS) 
EPUB_METADATA = epubmetadata.yaml
EPUB_CSS = epub.css
EPUB_TARGET = $(BOOKNAME).epub


PDF_FLAGS = $(COMMON_FLAGS) --pdf-engine=xelatex -f markdown-implicit_figures --top-level-division=chapter -V geometry:"paperwidth=7.5in, paperheight=9.25in, top=0.75in, bottom=0.75in, inner=1.25in, outer=0.75in, twoside"
PDF_METADATA = pdfmetadata.yaml 
PDF_YAML = pdf.yaml
PDF_TARGET = $(BOOKNAME).pdf

PANDOC = pandoc

.PHONY: clean all epub  pdf

all: epub  pdf

epub: $(EPUB_TARGET) 

kindle: $(KINDLE_TARGET) 

$(EPUB_TARGET): $(EPUB_METADATA) $(EPUB_CSS)  $(FRONTMATTER_ORDER) $(FRONTMATTER) $(CHAPTER_ORDER) $(CHAPTERS) $(MAKEFILE_LIST)
	$(PANDOC)  $(EPUB_FLAGS) -o $@ $(EPUB_METADATA) $(FRONTMATTER) $(CHAPTERS)

pdf: $(PDF_TARGET)

$(PDF_TARGET): $(PDF_YAML) $(CHAPTER_ORDER) $(CHAPTERS) $(MAKEFILE_LIST)
	$(PANDOC)  $(PDF_FLAGS) -o $@ $(PDF_YAML) $(CHAPTERS)

$(PDF_YAML) : $(PDF_METADATA) $(FRONTMATTER_ORDER) $(FRONTMATTER) $(MAKEFILE_LIST)
	cat $(PDF_METADATA) | sed -e '$$s/---//' > $@
	echo "include-before: |" >> $@
	cat $(FRONTMATTER) | sed 's/^/  /' | sed 's/epub:type=[a-z]*//' >> $@
	echo --- >> $@

clean:
	$(RM) $(EPUB_TARGET)
	$(RM) $(PDF_TARGET)
	$(RM) $(PDF_YAML)
