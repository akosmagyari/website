# Define directories
SOURCE_DIR = src
HTML_DIR = html

# Find all Markdown files in the source directory
MD_FILES = $(wildcard $(SOURCE_DIR)/*.md)

# Generate corresponding HTML file names
HTML_FILES = $(MD_FILES:$(SOURCE_DIR)/%.md=$(HTML_DIR)/%.html)

# Default target
all: $(HTML_FILES)

# Rule to convert Markdown to HTML
$(HTML_DIR)/%.html: $(SOURCE_DIR)/%.md
	@mkdir -p $(HTML_DIR)  # Create HTML directory if it doesn't exist
	pandoc $< -o $@

# Clean target to remove old HTML files
clean:
	rm -f $(HTML_DIR)/*.html

# Phony targets
.PHONY: all clean
