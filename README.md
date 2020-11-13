A JSON lexer and parser written in ocaml.

## Build from source
1. Clone this repository
2. Create opam switch
```
$ opam switch create . ocaml-base-compiler.4.09.0
```
3. Setup 
```
$ make install
```
4. Build
```
$ make build
```
5. Use
```
$ dune exec src/main.exe some_json_file.json
```