open Types

let _ =
  let argv = Sys.argv in
  let lexbuf = match Array.length argv with
    | 1 -> Lexing.from_channel stdin 
    (* | 2 -> Lexing.from_string (FileUtils.read_file (Array.get argv 1)) *)
    (* | 2 -> from_file (Array.get argv 1) *)
    (* | _ -> raise "Error" *)
  in
  let tks =
    let rec do_next acc = 
      match Lexer.token lexbuf with
      | EOF -> acc
      | t -> do_next (t :: acc)
    in List.rev (do_next [])
  in
  let _ = print_endline (Util.to_string tks) in
  let _ = print_endline (Util.to_token_string tks)
in ()