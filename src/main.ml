open Types

exception InputError of string

let _ =
  let argv = Sys.argv in
  let lexbuf = match Array.length argv with
    | 1 -> Lexing.from_channel stdin 
    | 2 -> let in_ch = FileUtils.open_file (Array.get argv 1) in 
                       Lexing.from_string (FileUtils.read_file in_ch)
    | _ -> raise (InputError "Input must be read from stdin or from a provided filename")
  in
  let tks =
    let rec do_next acc =
      match Lexer.token lexbuf with
      | EOF -> acc
      | t -> do_next (t :: acc)
    in List.rev (do_next [])
  in
  let _ = print_endline (Util.to_token_string tks)
in ()