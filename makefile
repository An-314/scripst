# Build the current checkout, even when another scripst version is installed.
# Requirements: Python 3.11+, Typst 0.15.0+, ImageMagick (for PNG previews).
PYTHON ?= python3
TYPST ?= typst
MAGICK ?= magick
BUILD = $(PYTHON) tools/build.py --typst "$(TYPST)" --magick "$(MAGICK)"

PDF_DIR = docs/builds
PDF_DIR_LOCALE = docs/locale/builds
TYP_DIR = docs
TYP_DIR_LOCALE = docs/locale
PROMO_DIR = docs/promotional
PREVIEW_DIR = previews
THUMBNAIL = thumbnail.png
DENSITY = 250
QUALITY = 100
SIZE = 1080x>
PREVIEW_OPTIONS = --ppi $(DENSITY) --quality $(QUALITY) --size "$(SIZE)"

PDF_FILES = article book report
TEMPLATE_DOCS = $(foreach file, $(PDF_FILES), $(PDF_DIR)/$(file).pdf)
TEMPLATE_DOCS_LOCALE = $(PDF_DIR_LOCALE)/article-en.pdf
BEAMER_DOCS = $(PDF_DIR)/beamer.pdf $(PDF_DIR_LOCALE)/beamer-en.pdf
DEMO_DOCS = $(PDF_DIR)/beamer-demo.pdf $(PDF_DIR_LOCALE)/beamer-demo-en.pdf
TEMPLATE_DOCS_ALL = $(TEMPLATE_DOCS) $(TEMPLATE_DOCS_LOCALE) $(BEAMER_DOCS)
DOC_CHAPTERS = $(wildcard $(TYP_DIR)/chap*.typ) $(TYP_DIR)/fonts.typ
DOC_ASSETS = $(wildcard $(TYP_DIR)/pic/* $(TYP_DIR_LOCALE)/pic/*)
SCRIPST_SOURCES = $(wildcard src/*.typ src/locale/*.typ src/locale/*.yml)
BUILD_DEPS = tools/build.py typst.toml makefile $(SCRIPST_SOURCES)

PREVIEW_IMAGES = $(foreach file, $(PDF_FILES), $(PREVIEW_DIR)/$(file)-1.png $(PREVIEW_DIR)/$(file)-2.png)

PREVIEW_EXTRA = $(PREVIEW_DIR)/article-ratchet.png $(PREVIEW_DIR)/article-countblocks.png
PREVIEW_FEATURES = $(PREVIEW_DIR)/countblock.png $(PREVIEW_DIR)/labelset.png
PREVIEW_LOCALE = $(PREVIEW_DIR)/article-en-1.png $(PREVIEW_DIR)/article-en-2.png $(PREVIEW_DIR)/article-en-ratchet.png $(PREVIEW_DIR)/article-en-countblocks.png
PREVIEW_BEAMER = $(PREVIEW_DIR)/beamer-1.png $(PREVIEW_DIR)/beamer-2.png $(PREVIEW_DIR)/beamer-en-1.png $(PREVIEW_DIR)/beamer-en-2.png

PREVIEW_ALL = $(PREVIEW_IMAGES) $(PREVIEW_EXTRA) $(PREVIEW_FEATURES) $(PREVIEW_LOCALE) $(PREVIEW_BEAMER)
PROMO_NAMES = why-typst why-typst-en syntax-comparison syntax-comparison-en
PROMO_DOCS = $(addprefix $(PROMO_DIR)/, $(addsuffix .pdf, $(PROMO_NAMES)))
PROMO_WHY = $(PREVIEW_DIR)/why-typst.png $(PREVIEW_DIR)/why-typst-en.png
PROMO_SYNTAX = $(foreach name, syntax-comparison syntax-comparison-en, $(foreach page, 1 2 3 4, $(PREVIEW_DIR)/$(name)-$(page).png))
PROMO_IMAGES = $(PROMO_WHY) $(PROMO_SYNTAX)

all: doc preview thumbnail promo

doc: $(TEMPLATE_DOCS_ALL)

preview: $(PREVIEW_ALL)

thumbnail: $(THUMBNAIL)

beamer: $(BEAMER_DOCS)

# Short decks are optional; doc builds the complete Chinese and English guides.
demo: $(DEMO_DOCS)

promo: $(PROMO_DOCS) $(PROMO_IMAGES)

$(PDF_DIR)/beamer.pdf: $(TYP_DIR)/beamer.typ $(BUILD_DEPS)
	$(BUILD) compile "$<" "$@"

$(PDF_DIR_LOCALE)/beamer-en.pdf: $(TYP_DIR_LOCALE)/beamer-en.typ $(BUILD_DEPS)
	$(BUILD) compile "$<" "$@"

$(PDF_DIR)/beamer-demo.pdf: $(TYP_DIR)/examples/beamer.typ $(BUILD_DEPS)
	$(BUILD) compile "$<" "$@"

$(PDF_DIR_LOCALE)/beamer-demo-en.pdf: $(TYP_DIR)/examples/beamer-en.typ $(BUILD_DEPS)
	$(BUILD) compile "$<" "$@"

$(PDF_DIR)/%.pdf: $(TYP_DIR)/%.typ $(DOC_CHAPTERS) $(DOC_ASSETS) $(BUILD_DEPS)
	$(BUILD) compile "$<" "$@"

$(PDF_DIR_LOCALE)/article-en.pdf: $(TYP_DIR_LOCALE)/article-en.typ $(TYP_DIR_LOCALE)/fonts-en.typ $(DOC_ASSETS) $(BUILD_DEPS)
	$(BUILD) compile "$<" "$@"

$(PROMO_DOCS): $(PROMO_DIR)/%.pdf: $(PROMO_DIR)/%.typ $(BUILD_DEPS)
	$(BUILD) compile "$<" "$@"

$(PREVIEW_DIR):
	mkdir -p "$@"

# One recipe per output: safe when doc, preview and thumbnail run together -j.
$(PREVIEW_DIR)/%-1.png: $(PDF_DIR)/%.pdf | $(PREVIEW_DIR)
	$(BUILD) preview "$(TYP_DIR)/$*.typ" "$@" --page 1 $(PREVIEW_OPTIONS)

$(PREVIEW_DIR)/%-2.png: $(PDF_DIR)/%.pdf | $(PREVIEW_DIR)
	$(BUILD) preview "$(TYP_DIR)/$*.typ" "$@" --page 2 $(PREVIEW_OPTIONS)

# Locate feature pages by stable labels, not page indices or pixel crops.
$(PREVIEW_DIR)/article-ratchet.png: $(PDF_DIR)/article.pdf | $(PREVIEW_DIR)
	$(BUILD) preview "$(TYP_DIR)/article.typ" "$@" --marker ratchet $(PREVIEW_OPTIONS)

$(PREVIEW_DIR)/article-countblocks.png: $(PDF_DIR)/article.pdf | $(PREVIEW_DIR)
	$(BUILD) preview "$(TYP_DIR)/article.typ" "$@" --marker scripst-preview-countblocks $(PREVIEW_OPTIONS)

$(PREVIEW_DIR)/countblock.png: $(PDF_DIR)/article.pdf | $(PREVIEW_DIR)
	$(BUILD) preview "$(TYP_DIR)/article.typ" "$@" --marker scripst-preview-countblocks $(PREVIEW_OPTIONS)

$(PREVIEW_DIR)/labelset.png: $(PDF_DIR)/article.pdf | $(PREVIEW_DIR)
	$(BUILD) preview "$(TYP_DIR)/article.typ" "$@" --marker scripst-preview-labelset $(PREVIEW_OPTIONS)

$(PREVIEW_DIR)/article-en-1.png: $(PDF_DIR_LOCALE)/article-en.pdf | $(PREVIEW_DIR)
	$(BUILD) preview "$(TYP_DIR_LOCALE)/article-en.typ" "$@" --page 1 $(PREVIEW_OPTIONS)

$(PREVIEW_DIR)/article-en-2.png: $(PDF_DIR_LOCALE)/article-en.pdf | $(PREVIEW_DIR)
	$(BUILD) preview "$(TYP_DIR_LOCALE)/article-en.typ" "$@" --page 2 $(PREVIEW_OPTIONS)

$(PREVIEW_DIR)/beamer-en-1.png: $(PDF_DIR_LOCALE)/beamer-en.pdf | $(PREVIEW_DIR)
	$(BUILD) preview "$(TYP_DIR_LOCALE)/beamer-en.typ" "$@" --page 1 $(PREVIEW_OPTIONS)

$(PREVIEW_DIR)/beamer-en-2.png: $(PDF_DIR_LOCALE)/beamer-en.pdf | $(PREVIEW_DIR)
	$(BUILD) preview "$(TYP_DIR_LOCALE)/beamer-en.typ" "$@" --page 2 $(PREVIEW_OPTIONS)

$(PREVIEW_DIR)/article-en-ratchet.png: $(PDF_DIR_LOCALE)/article-en.pdf | $(PREVIEW_DIR)
	$(BUILD) preview "$(TYP_DIR_LOCALE)/article-en.typ" "$@" --marker ratchet $(PREVIEW_OPTIONS)

$(PREVIEW_DIR)/article-en-countblocks.png: $(PDF_DIR_LOCALE)/article-en.pdf | $(PREVIEW_DIR)
	$(BUILD) preview "$(TYP_DIR_LOCALE)/article-en.typ" "$@" --marker scripst-preview-countblocks $(PREVIEW_OPTIONS)

$(PROMO_WHY): $(PREVIEW_DIR)/%.png: $(PROMO_DIR)/%.pdf | $(PREVIEW_DIR)
	$(BUILD) preview "$(PROMO_DIR)/$*.typ" "$@" --page 1 $(PREVIEW_OPTIONS)

# Explicit static rules take precedence over the document-preview patterns.
define promo_syntax_page
$(PREVIEW_DIR)/syntax-comparison-$(1).png: $(PROMO_DIR)/syntax-comparison.pdf | $(PREVIEW_DIR)
	$(BUILD) preview "$(PROMO_DIR)/syntax-comparison.typ" "$$@" --page $(1) $(PREVIEW_OPTIONS)
$(PREVIEW_DIR)/syntax-comparison-en-$(1).png: $(PROMO_DIR)/syntax-comparison-en.pdf | $(PREVIEW_DIR)
	$(BUILD) preview "$(PROMO_DIR)/syntax-comparison-en.typ" "$$@" --page $(1) $(PREVIEW_OPTIONS)
endef
$(foreach page, 1 2 3 4, $(eval $(call promo_syntax_page,$(page))))

$(THUMBNAIL): template/main.typ $(BUILD_DEPS) | $(PREVIEW_DIR)
	$(BUILD) preview "$<" "$@" --page 1 $(PREVIEW_OPTIONS)

# Only remove outputs owned by these targets, never entire directories/assets.
clean:
	rm -f -- $(TEMPLATE_DOCS_ALL) $(DEMO_DOCS) $(PREVIEW_ALL) $(PROMO_DOCS) $(PROMO_IMAGES) $(THUMBNAIL)

.PHONY: all doc preview thumbnail beamer demo promo clean
