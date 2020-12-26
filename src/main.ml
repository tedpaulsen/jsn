open JsonParse
open PathSpecParse

exception InputError of string
exception ParsingError of string
exception ValidationError of string

let get_json_input =
  let argv = Sys.argv in
  match Array.length argv with
  | 1 -> Lexing.from_channel stdin
  | 2 ->
      let in_ch = FileUtils.open_file argv.(1) in
      Lexing.from_string (FileUtils.read_file in_ch)
  | 3 ->
      let in_ch = FileUtils.open_file argv.(1) in
      Lexing.from_string (FileUtils.read_file in_ch)
  | _ -> raise (InputError "Invalid json input")

let parse_json_input input =
  try JsonParser.exec JsonLexer.read input
  with JsonLexer.SyntaxError msg ->
    let _ =
      Printf.fprintf stderr "Syntax error in json input at position %d : \"%s\""
        (Lexing.lexeme_start input) msg in
    None

let get_path_input =
  let argv = Sys.argv in
  match Array.length argv with
  | 2 -> Lexing.from_string argv.(1)
  | 3 -> Lexing.from_string argv.(2)
  | _ -> raise (InputError "Invalid path specifier")

let parse_path_input input =
  try PathSpecParser.exec PathSpecLexer.read input
  with PathSpecLexer.SyntaxError msg ->
    let _ =
      Printf.fprintf stderr "Synax error in path specifier at position %d : \"%s\""
        (Lexing.lexeme_start input) msg in
    None

let _ =
  (* parse json and path specifier into ASTs *)
  let json_ast = parse_json_input get_json_input in
  let path_ast = parse_path_input get_path_input in
  (* make sure both exist *)
  let fragment =
    match json_ast with Some x -> x | None -> raise (ValidationError "json expected")
  in
  let spec =
    match path_ast with
    | Some x -> x
    | None   -> raise (ValidationError "path specifier expected") in
  (* run the path specifier engine to find the json fragment that exists at the specified
     path *)
  let sub_fragment = Engine.find_fragment fragment spec in
  PprintJsonTokens.pprint_json sub_fragment
