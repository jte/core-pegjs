SOURCES := $(wildcard src/*/*.pegjs)
PEG := $(patsubst src%, lib%, $(SOURCES))
PEGjs := $(PEG:.pegjs=.js)

.PHONY: all pegs js

all: pegs

pegs: $(PEG)

js: $(PEGjs)

$(PEG): $(1)

$(PEGjs): $(1)

lib/%.pegjs: src/%.pegjs
	@$(eval input := $<)
	@$(eval output := $@)
	@mkdir -p `dirname $(output)`
	@cat `bin/tree.sh $(input) src/` > $(output)

lib/%.js: lib/%.pegjs
	@$(eval input := $<)
	@$(eval output := $@)
	@mkdir -p `dirname $(output)`
	@pegjs $(input) $(output)

clean:
# @git clean -xdf
# @rm -f $(PEGjs)
