CONTENT_DIR = BookContent
CHAPTER_ORDER = ChapterOrder.txt
CHAPTERS = $(patsubst %,$(CONTENT_DIR)/%,$(strip $(file < $(CHAPTER_ORDER))))
METADATA = metadata.yaml

COMMON_FLAGS = --from markdown --toc -N --resource-path=$(CONTENT_DIR)

EPUBFLAGS = $(COMMON_FLAGS)
EPUBTARGET = book.epub

PDFFLAGS = $(COMMON_FLAGS) --pdf-engine=xelatex --top-level-division=chapter -V papersize:a5 -V geometry:"top=2cm, bottom=1.5cm, left=2cm, right=2cm"
PDFTARGET = book.pdf

PANDOC = pandoc

.PHONY: clean all epub pdf

all: epub pdf

epub: $(EPUBTARGET) 

$(EPUBTARGET): $(METADATA) $(CHAPTER_ORDER) $(CHAPTERS) $(MAKEFILE_LIST)
	$(PANDOC)  $(EPUBFLAGS) -o $@ $(METADATA) $(CHAPTERS)

pdf: $(PDFTARGET)

$(PDFTARGET): $(METADATA) $(CHAPTER_ORDER) $(CHAPTERS) $(MAKEFILE_LIST)
	$(PANDOC)  $(PDFFLAGS) -o $@ $(METADATA) $(CHAPTERS)

clean:
	$(RM) $(EPUBTARGET)
	$(RM) $(PDFTARGET)
