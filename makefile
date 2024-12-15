# Define paths
WEBSITE_SRC = src
WEBSITE_HTML = html
GITHUB_HTML = ../akosmagyari.github.io

# Define pandoc command
PANDOC = pandoc

# Find markdown and html files
MARKDOWN_FILES = $(wildcard $(WEBSITE_SRC)/*.md)
HTML_FILES = $(patsubst $(WEBSITE_SRC)/%.md,$(WEBSITE_HTML)/%.html,$(MARKDOWN_FILES))

.PHONY: all clean convert modify_links add_boilerplate deploy

# Default target
all: clean convert modify_links add_boilerplate deploy

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

# Add boilerplate to HTML files
add_boilerplate:
	@for file in $(HTML_FILES); do \
		boilerplate_head="$$(grep -v '^$$' $(WEBSITE_SRC)/boilerplate.html | head -n -2)"; \
		boilerplate_foot="$$(grep -v '^$$' $(WEBSITE_SRC)/boilerplate.html | tail -n 2)"; \
		content=$$(cat $$file); \
		echo "$$boilerplate_head" > $$file; \
		echo "$$content" >> $$file; \
		echo "$$boilerplate_foot" >> $$file; \
		filename=$$(basename $$file .html | tr '-' ' '); \
		sed -i "s|<title>.*</title>|<title>$$filename</title>|" $$file; \
	done

# Copy html files to akosmagyari.github.io
deploy:
	cp $(WEBSITE_HTML)/*.html $(GITHUB_HTML)/
