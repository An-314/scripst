LANGUAGES := $(notdir $(wildcard ./config/*))

all: $(LANGUAGES)

$(LANGUAGES):
	@echo "Building documentation for $@"
	mkdocs build -f ./config/$@/mkdocs.yml

clean:
	@echo "Cleaning up..."
	rm -rf site

deploy: all
	@echo "Deploying to gh-pages branch..."
	ghp-import -n -p -f generated