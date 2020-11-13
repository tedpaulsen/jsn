#
# Pure OCaml, package from Opam, two directories
#

# - The -I flag introduces sub-directories
# - -use-ocamlfind is required to find packages (from Opam)
# - _tags file introduces packages, bin_annot flag for tool chain
# - using *.mll and *.mly are handled automatically

OCB_FLAGS   = -use-ocamlfind -I src -I lib -r
OCB = ocamlbuild $(OCB_FLAGS)

all: native byte # profile debug

install:
	eval $(opam config env)
	opam update
	opam install --yes . --deps-only
	eval $(opam env)

prebuild:
	cp jsn.opam json_parse.opam
	cp jsn.opam query_parse.opam

build:
	make prebuild
	dune build @fmt
	dune build

clean:
	dune clean