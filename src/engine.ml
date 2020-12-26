open JsonParse.JsonTypes
open PathSpecParse.PathSpecTypes

let rec find_fragment frg sp =
  let get_array_element f index =
    match f with JsonArray x -> List.nth x index | _ -> JsonNull in
  let get_object_field f key =
    let find_pair pairs key =
      List.find (fun (k, _) -> String.equal ("\"" ^ key ^ "\"") k) pairs in
    let get_value (_, v) = v in
    match f with JsonObject pairs -> get_value (find_pair pairs key) | _ -> JsonNull in
  (* let _ = print_endline ("finding specifier: " ^ spec_to_string sp) in *)
  (* let _ = print_string "in json: " in *)
  (* let _ = PprintJsonTokens.pprint_json frg in *)
  match sp with
  | TerminalSpec              -> frg
  | FieldSpec (key, spec)     -> find_fragment (get_object_field frg key) spec
  | ElementSpec (index, spec) -> find_fragment (get_array_element frg index) spec
