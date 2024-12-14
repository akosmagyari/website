# Define directories
SOURCE_DIR = src
HTML_DIR = html
DEST_DIR = ../akosmagyari.github.io  # Destination directory

# Find all Markdown files in the source directory
MD_FILES = $(wildcard $(SOURCE_DIR)/*.md)

# Generate corresponding HTML file names
HTML_FILES = $(MD_FILES:$(SOURCE_DIR)/%.md=$(HTML_DIR)/%.html)

# Default target
all: $(HTML_FILES) copy

# Rule to convert Markdown to HTML
$(HTML_DIR)/%.html: $(SOURCE_DIR)/%.md
	@mkdir -p $(HTML_DIR)  # Create HTML directory if it doesn't exist
	pandoc $< -o $@

# Target to copy HTML files to the destination directory
copy: $(HTML_FILES)
	@mkdir -p $(DEST_DIR)  # Create destination directory if it doesn't exist
	cp $(HTML_FILES) $(DEST_DIR)

# Clean target to remove old HTML files
clean:
	rm -f $(HTML_DIR)/*.html
	rm -f $(DEST_DIR)/*.html  # Optionally remove copied HTML files

# Phony targets
.PHONY: all clean copy
