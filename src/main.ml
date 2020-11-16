open Json_parse
open Json_parse.JsonTypes

exception InputError of string

let get_input =
  let argv = Sys.argv in
  match Array.length argv with
  | 1 -> Lexing.from_channel stdin
  | 2 ->
      let in_ch = FileUtils.open_file argv.(1) in
      Lexing.from_string (FileUtils.read_file in_ch)
  | _ -> raise (InputError "Please provide an input from stdin or a filename")

let parse_input input =
  try JsonParser.exec JsonLexer.read input
  with JsonLexer.SyntaxError msg ->
    let _ =
      Printf.fprintf stderr "Syntax error at position %d : \"%s\""
        (Lexing.lexeme_start input) msg in
    None

let get_keys obj =
  let _get_keys_from_entry (k, _) = k in
  match obj with
  | JsonObject entries -> List.map _get_keys_from_entry entries
  | _                  -> []

let print_keys keys_list = Printf.printf "%s\n" (String.concat "\n" keys_list)

let _ =
  let ast = parse_input get_input in
  let keys = match ast with Some v -> get_keys v | None -> [] in
  print_keys keys
