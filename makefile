# Define paths
WEBSITE_SRC = src
WEBSITE_HTML = html
GITHUB_HTML = ../akosmagyari.github.io

# Define pandoc command
PANDOC = pandoc

# Find markdown and html files
MARKDOWN_FILES = $(wildcard $(WEBSITE_SRC)/*.md)
HTML_FILES = $(patsubst $(WEBSITE_SRC)/%.md,$(WEBSITE_HTML)/%.html,$(MARKDOWN_FILES))

.PHONY: all clean convert modify_links deploy

# Default target
all: clean convert modify_links deploy

# Clean target: remove all files from html and html files from akosmagyari.github.io
clean:
	rm -f $(WEBSITE_HTML)/*
	rm -f $(GITHUB_HTML)/*.html

# Convert markdown files to html using pandoc
convert: $(HTML_FILES)

$(WEBSITE_HTML)/%.html: $(WEBSITE_SRC)/%.md
	$(PANDOC) $< -o $@

# Modify links in newly created html files
modify_links:
	@for file in $(HTML_FILES); do \
		sed -i 's/\.md\"/\.html\"/g' $$file; \
	done

# Copy html files to akosmagyari.github.io
deploy:
	cp $(WEBSITE_HTML)/*.html $(GITHUB_HTML)/
