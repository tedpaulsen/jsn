open PathSpecParser
open PathSpecTypes

let pprint_tokens tks =
  let tk_to_string tk =
    match tk with
    | ID x    -> "ID(" ^ x ^ ")"
    | DOT     -> "DOT"
    | ARR     -> "["
    | RAY     -> "]"
    | INDEX i -> "INDEX(" ^ string_of_int i ^ ")"
    | EOF     -> "eof" in
  print_endline (String.concat " " (List.map tk_to_string tks))

let pprint_spec spec =
  let rec sp_to_string_list (sp : specifier) : string list =
    match sp with
    | FieldSpec (s, sps)   -> ("FS(" ^ s ^ ")") :: sp_to_string_list sps
    | ElementSpec (i, sps) -> ("ES(" ^ string_of_int i ^ ")") :: sp_to_string_list sps
    | TerminalSpec         -> ["TERMINAL"] in
  print_endline (String.concat " " (sp_to_string_list spec))

let spec_to_string s =
  match s with
  | FieldSpec (k, _)   -> k
  | ElementSpec (i, _) -> string_of_int i
  | TerminalSpec       -> "TERM"
