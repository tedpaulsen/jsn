A json parser and path finding tool written in ocaml.

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
$ ./jsn JSON_FILE PATH_SPECIFIER
```
where `JSON_FILE` is some json file which you would like to parse
and `PATH_SPECIFIER` is some xpath-like json path specifier which
you would like to find.

Ex:
```
// test.json

{
  "b": "bbb",
  "c": "ccc",
  "d": [ "a","d" ],
  "e": { "yes": "no" }
}
```
Running `./jsn json_samples/test.json ".d[0]"` would result in `"a"`
