open Json_parse

exception InputError of string

let (_ : unit) =
  let argv = Sys.argv in
  let lexbuf =
    match Array.length argv with
    | 1 -> Lexing.from_channel stdin
    | 2 ->
        let in_ch = FileUtils.open_file argv.(1) in
        Lexing.from_string (FileUtils.read_file in_ch)
    | _ -> raise (InputError "Input must be read from stdin or from a provided filename")
  in
  let (_ : JsonTypes.json_fragment option) =
    try JsonParser.exec JsonLexer.read lexbuf
    with JsonLexer.SyntaxError msg ->
      Printf.fprintf stderr "Syntax error at position %d : \"%s\""
        (Lexing.lexeme_start lexbuf) msg ;
      None in
  ()
