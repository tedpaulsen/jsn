{
  open Lexing
  open Types
  (* type json =
    | Bool of bool
    | Int of int
    | String of string
    | Float of float
    | Entry of (string * json)
    | Array of json list
    | True
    | False
    | Null
    | BRA
    | KET
    | ARR
    | RAY
    | COL
    | COM
    | EOF
  ;; *)
}

let non_zero_digit = ['1'-'9']
let digit = ['0'-'9']
let int =   '-'? non_zero_digit digit+
let float = '-'? digit+ '.' digit+
let str = "\"" ['A'-'Z''a'-'z''0'-'9']* "\""

let whitespace = [' ' '\t']
let newline = '\r' | '\n' | "\r\n"

let true = "true"
let false = "false"
let null = "null"

rule token = parse
  | whitespace+             { token lexbuf }
  | newline                 { new_line lexbuf; token lexbuf }
  | str                     { String (Lexing.lexeme lexbuf) }
  | "{"                     { BRA }
  | "}"                     { KET }
  | "["                     { ARR }
  | "]"                     { RAY }
  | ":"                     { COL }
  | ","                     { COM }
  | eof                     { EOF }

{
  (* let lexbuf = Lexing.from_channel stdin in *)
  
  (* let tks =
    let rec do_next acc = 
      match token lexbuf with
      | EOF -> acc
      | t -> do_next (t :: acc)
    in List.rev (do_next [])
  in *)

  (* let to_token_string (obj : json list) : string =
    let rec to_token_string_list (obj_ : json list) : string list =
      match obj_ with
      | BRA :: xs -> "BRA" :: to_token_string_list xs
      | KET :: xs -> "KET" :: to_token_string_list xs
      | ARR :: xs -> "ARR" :: to_token_string_list xs
      | RAY :: xs -> "RAY" :: to_token_string_list xs
      | COL :: xs -> "COL" :: to_token_string_list xs
      | COM :: xs -> "COM" :: to_token_string_list xs
      | String x :: xs -> x :: to_token_string_list xs
      | [] -> []
    in String.concat " " (to_token_string_list obj)
  in
  
  let to_string (obj : json list) : string =
    let rec to_string_list (obj_ : json list) : string list =
      match obj_ with
      | BRA :: xs -> "{" :: to_string_list xs
      | KET :: xs -> "}" :: to_string_list xs
      | ARR :: xs -> "[" :: to_string_list xs
      | RAY :: xs -> "]" :: to_string_list xs
      | COL :: xs -> ":" :: to_string_list xs
      | COM :: xs -> "," :: to_string_list xs
      | String x :: xs -> x :: to_string_list xs
      | [] -> []
    in String.concat "" (to_string_list obj)
  in *)

  (* let _ = print_endline (Util.to_token_string tks) in *)
  (* let _ = print_endline (Util.to_string tks) in *)
  (* () *)
}