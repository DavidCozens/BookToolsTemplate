CHAPTERS = contents.md
EPUBMETADATA = metadata.yaml

EPUBFLAGS = --from markdown+emoji --toc
EPUBTARGET = book.epub

PANDOC = pandoc

.PHONY: clean all epub

all: epub

epub: $(EPUBTARGET)

$(EPUBTARGET): $(EPUBMETADATA) $(CHAPTERS) $(MAKEFILE_LIST)
	$(PANDOC)  $(EPUBFLAGS) -o $@ $(EPUBMETADATA) $(CHAPTERS)

clean:
	$(RM) $(EPUBTARGET)
