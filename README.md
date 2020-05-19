A JSON lexer and parser written in ocaml.

## Build from source
1. Clone this repository
2. Create opam switch
```
$ opam switch create . ocaml-base-compiler.4.09.0
```
3. Build
```
$ make native
```
4. Use
```
$ cat some.json | main.native
```