let to_token_string (obj : Types.json list) : string =
  let rec to_token_string_list (obj_ : Types.json list) : string list =
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
    | String x :: xs -> x :: to_string_list xs
    | [] -> []
  in String.concat "" (to_string_list obj)
;;