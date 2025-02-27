# Makefile for generating PDF thumbnails using ImageMagick

PDF_DIR = docs
PREVIEW_DIR = previews
DENSITY = 200  # DPI 分辨率
QUALITY = 90   # 输出质量
SIZE = 300x    # 目标缩略图大小

PDF_FILES = article book report
PREVIEW_IMAGES = $(foreach file, $(PDF_FILES), $(PREVIEW_DIR)/$(file)-1.png $(PREVIEW_DIR)/$(file)-2.png)

all: $(PREVIEW_IMAGES)

$(PREVIEW_DIR):
	mkdir -p $(PREVIEW_DIR)

$(PREVIEW_DIR)/%-1.png $(PREVIEW_DIR)/%-2.png: $(PDF_DIR)/%.pdf | $(PREVIEW_DIR)
	convert -density $(DENSITY) $<[0] -quality $(QUALITY) -resize $(SIZE) -background white -alpha remove $(PREVIEW_DIR)/$*-1.png
	convert -density $(DENSITY) $<[1] -quality $(QUALITY) -resize $(SIZE) -background white -alpha remove $(PREVIEW_DIR)/$*-2.png

clean:
	rm -rf $(PREVIEW_DIR)

.PHONY: all clean
