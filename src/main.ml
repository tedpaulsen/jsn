open Json_parse
open Json_parse.JsonTypes
open Path_spec_parse
open Path_spec_parse.Path_spec_types

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
  | _ -> raise (InputError "Please provide an input from stdin or a filename")

let parse_json_input input =
  try JsonParser.exec JsonLexer.read input
  with JsonLexer.SyntaxError msg ->
    let _ =
      Printf.fprintf stderr "Syntax error in json input at position %d : \"%s\""
        (Lexing.lexeme_start input) msg in
    None

let get_path_input = Lexing.from_string ".Environments[1].Tier.Name"
(*
let lex_path_input input =
  let tks = PathSpecLexer.read input in
  PprintSpecTokens.pprint_tokens tks *)
let get_path_tks lexbuf =
  let rec do_next acc =
    match PathSpecLexer.read lexbuf with
    | EOF -> acc
    | t -> do_next (t :: acc)
  in List.rev (do_next [])

let parse_path_input input =
  (* let tks = get_path_tks input in *)
  (* let _ = PprintSpecTokens.pprint_tokens tks in *)
  try PathSpecParser.exec PathSpecLexer.read input
  with PathSpecLexer.SyntaxError msg ->
    let _ =
      Printf.fprintf stderr "Synax error in path specifier at position %d : \"%s\""
        (Lexing.lexeme_start input) msg in
    None

(* let get_keys obj =
  let _get_keys_from_entry (k, _) = k in
  match obj with
  | JsonObject entries -> List.map _get_keys_from_entry entries
  | _                  -> []

let print_keys keys_list = Printf.printf "%s\n" (String.concat "\n" keys_list)

*)

(* let get_path_spec =
  let lexbuf = Lexing.from_string ".test" in
  let tks = get_path_tks lexbuf in
  let _ = Path_spec_parse.PprintSpecTokens.pprint_tokens tks in
  PathSpecParser.exec PathSpecLexer.read lexbuf *)

let spec_to_string s = match s with
  | FieldSpec (k, _) -> k
  | ElementSpec (i, _) -> string_of_int i
  | TerminalSpec -> "TERM"

let rec find_fragment frg sp =
  let get_array_element f index =
    match f with
    | JsonArray x -> List.nth x index
    | _           -> JsonNull
  in
  let get_object_field f key =
    let find_pair pairs key = List.find (fun (k, _) -> String.equal ("\"" ^ key ^ "\"") k) pairs in
    let get_value (_, v) = v in
    match f with
    | JsonObject pairs -> get_value (find_pair pairs key)
    | _ -> JsonNull
  in

  (* let _ = print_endline ("finding specifier: " ^ spec_to_string sp) in *)
  (* let _ = print_string "in json: " in *)
  (* let _ = PprintJsonTokens.pprint_json frg in *)

  match sp with
  | TerminalSpec -> frg
  | FieldSpec (key, spec) -> find_fragment (get_object_field frg key) spec
  | ElementSpec (index, spec) -> find_fragment (get_array_element frg index) spec


let _ =
  (* let tks = get_path_tks get_path_input in
  let _ = print_string "path tokens " in
  let _ = PprintSpecTokens.pprint_tokens tks in *)

  let json_ast = parse_json_input get_json_input in
  let path_ast = parse_path_input get_path_input in

  let fragment = match json_ast with Some x -> x | None -> raise (ValidationError "json expected") in
  let spec  = match path_ast with Some x -> x | None -> raise (ValidationError "path specifier expected") in

  let sub_fragment = find_fragment fragment spec in
  PprintJsonTokens.pprint_json sub_fragment
