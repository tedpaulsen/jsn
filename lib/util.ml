let to_token_string (obj : Types.json list) : string =
  let rec to_token_string_list (obj_ : Types.json list) : string list =
    match obj_ with
    | BRA :: xs -> "BRA" :: to_token_string_list xs
    | KET :: xs -> "KET" :: to_token_string_list xs
    | ARR :: xs -> "ARR" :: to_token_string_list xs
    | RAY :: xs -> "RAY" :: to_token_string_list xs
    | COL :: xs -> "COL" :: to_token_string_list xs
    | COM :: xs -> "COM" :: to_token_string_list xs
    | True :: xs -> "True" :: to_token_string_list xs
    | False :: xs -> "False" :: to_token_string_list xs
    | Int n :: xs -> string_of_int n :: to_token_string_list xs
    | Float n :: xs -> string_of_float n :: to_token_string_list xs
    | String x :: xs -> x :: to_token_string_list xs
    | [] -> []
    | ERROR msg :: xs -> (Printf.sprintf "ERROR(%s)" msg) :: to_token_string_list xs
  in String.concat " " (to_token_string_list obj)
;;

let to_string (obj : Types.json list) : string =
  let rec to_string_list (obj_ : Types.json list) : string list =
    match obj_ with
    | BRA :: xs -> "{" :: to_string_list xs
    | KET :: xs -> "}" :: to_string_list xs
    | ARR :: xs -> "[" :: to_string_list xs
    | RAY :: xs -> "]" :: to_string_list xs
    | COL :: xs -> ":" :: to_string_list xs
    | COM :: xs -> "," :: to_string_list xs
    | True :: xs -> "true" :: to_string_list xs
    | False :: xs -> "false" :: to_string_list xs
    | Int n :: xs -> string_of_int n :: to_string_list xs
    | Float n :: xs -> string_of_float n :: to_string_list xs
    | String x :: xs -> x :: to_string_list xs
    | [] -> []
    | ERROR msg :: xs -> (Printf.sprintf "ERROR(%s)" msg) :: to_string_list xs
  in String.concat "" (to_string_list obj)
;;
