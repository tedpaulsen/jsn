install:
	eval $(opam config env)
	opam update
	opam install --yes . --deps-only
	eval $(opam env)

prebuild:
	cp jsn.opam jsonParse.opam
	cp jsn.opam pathSpecParse.opam

build:
	make prebuild
	dune build

release:
	make prebuild
	dune build @fmt --auto-promote
	dune build

clean:
	dune clean

run:
	dune exec src/main.exe
