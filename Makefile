GENERATED_JS := ipt.js
PACKAGES := \
	js_of_ocaml \
	js_of_ocaml.syntax
PACKAGES_OPTION := $(addprefix -package ,$(PACKAGES))

all: build

.PHONY: build
build: $(GENERATED_JS)

%.byte: %.ml Makefile
	ocamlfind ocamlc \
		$(PACKAGES_OPTION) \
        -syntax camlp4o \
		-linkpkg \
		-g \
		-o $@ $<

%.js: %.byte Makefile
	js_of_ocaml $<

.PHONY: clean
clean:
	rm -f *.cmi
	rm -f *.cmo
	rm -f *.byte
	rm -f $(GENERATED_JS)