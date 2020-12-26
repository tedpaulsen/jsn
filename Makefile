install:
	eval $(opam config env)
	opam update
	opam install --yes . --deps-only
	eval $(opam env)

prebuild:
	cp jsn.opam json_parse.opam
	cp jsn.opam path_spec_parse.opam

build:
	make prebuild
	dune build @fmt
	dune build

clean:
	dune clean

# Execute this target like: make run JSON_FILE=asdf.json
run:
	dune exec src/main.exe $(JSON_FILE)
