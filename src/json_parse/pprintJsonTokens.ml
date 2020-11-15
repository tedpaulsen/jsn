let to_token_string (obj : JsonParser.token list) : string =
  let rec to_token_string_list (obj_ : JsonParser.token list) : string list =
    match obj_ with
    | BRA :: xs -> "BRA" :: to_token_string_list xs
    | KET :: xs -> "KET" :: to_token_string_list xs
    | ARR :: xs -> "ARR" :: to_token_string_list xs
    | RAY :: xs -> "RAY" :: to_token_string_list xs
    | COL :: xs -> "COL" :: to_token_string_list xs
    | COM :: xs -> "COM" :: to_token_string_list xs
    | INT n :: xs -> string_of_int n :: to_token_string_list xs
    | FLOAT n :: xs -> string_of_float n :: to_token_string_list xs
    | STRING x :: xs -> ("STRING("^x^")") :: to_token_string_list xs
    | NULL :: xs -> "NULL" :: to_token_string_list xs
    | BOOL x :: xs -> string_of_bool x :: to_token_string_list xs
    | [] -> []
    | EOF :: xs -> "EOF" :: to_token_string_list xs
    | ERROR msg :: xs -> (Printf.sprintf "ERROR(%s)" msg) :: to_token_string_list xs
  in String.concat " " (to_token_string_list obj)
;;

let to_string (obj : JsonParser.token list) : string =
  let rec to_string_list (obj_ : JsonParser.token list) : string list =
    match obj_ with
    | BRA :: xs -> "{" :: to_string_list xs
    | KET :: xs -> "}" :: to_string_list xs
    | ARR :: xs -> "[" :: to_string_list xs
    | RAY :: xs -> "]" :: to_string_list xs
    | COL :: xs -> ":" :: to_string_list xs
    | COM :: xs -> "," :: to_string_list xs
    | INT n :: xs -> string_of_int n :: to_string_list xs
    | FLOAT n :: xs -> string_of_float n :: to_string_list xs
    | STRING x :: xs -> x :: to_string_list xs
    | NULL :: xs -> "null" :: to_string_list xs
    | BOOL x :: xs -> string_of_bool x :: to_string_list xs
    | [] -> []
    | EOF :: xs -> "EOF" :: to_string_list xs
    | ERROR msg :: xs -> (Printf.sprintf "ERROR(%s)" msg) :: to_string_list xs
  in String.concat "" (to_string_list obj)
;;

let pprint_tokens (tokens : JsonParser.token list) : unit = print_endline (to_token_string tokens)

let pprint (tokens : JsonParser.token list) : unit = print_endline (to_string tokens)
