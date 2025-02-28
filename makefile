# Makefile for generating PDFs from Typst and generating thumbnails with ImageMagick

PDF_DIR = docs/builds
TYP_DIR = docs
PREVIEW_DIR = previews
DENSITY = 200  # DPI 分辨率
QUALITY = 90   # 输出质量
SIZE = 300x    # 目标缩略图大小

PDF_FILES = article book report
TEMPLATE_DOCS = $(foreach file, $(PDF_FILES), $(PDF_DIR)/$(file).pdf)

PREVIEW_IMAGES = $(foreach file, $(PDF_FILES), $(PREVIEW_DIR)/$(file)-1.png $(PREVIEW_DIR)/$(file)-2.png)

PREVIEW_EXTRA = $(PREVIEW_DIR)/article-12.png $(PREVIEW_DIR)/article-9.png

PREVIEW_ALL = $(PREVIEW_IMAGES) $(PREVIEW_EXTRA)

all: $(TEMPLATE_DOCS) $(PREVIEW_ALL)

doc: $(TEMPLATE_DOCS)

preview: $(PREVIEW_ALL)

$(PDF_DIR)/%.pdf: $(TYP_DIR)/%.typ
	cd $(TYP_DIR) && typst compile $*.typ builds/$*.pdf

$(PREVIEW_DIR):
	mkdir -p $(PREVIEW_DIR)

$(PREVIEW_DIR)/%-1.png $(PREVIEW_DIR)/%-2.png: $(PDF_DIR)/%.pdf | $(PREVIEW_DIR)
	magick convert -density $(DENSITY) $<[0] -quality $(QUALITY) -resize $(SIZE) -background white -alpha remove $(PREVIEW_DIR)/$*-1.png
	magick convert -density $(DENSITY) $<[1] -quality $(QUALITY) -resize $(SIZE) -background white -alpha remove $(PREVIEW_DIR)/$*-2.png

$(PREVIEW_DIR)/article-12.png $(PREVIEW_DIR)/article-9.png: $(PDF_DIR)/article.pdf | $(PREVIEW_DIR)
	magick convert -density $(DENSITY) $<[11] -quality $(QUALITY) -resize $(SIZE) -background white -alpha remove $(PREVIEW_DIR)/article-12.png
	magick convert -density $(DENSITY) $<[8] -quality $(QUALITY) -resize $(SIZE) -background white -alpha remove $(PREVIEW_DIR)/article-9.png

clean:
	rm -rf $(PREVIEW_DIR) $(TEMPLATE_DOCS)

.PHONY: all doc preview clean
