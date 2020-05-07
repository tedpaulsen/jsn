let open_file file_name = open_in file_name

let attempt_read input_channel =
  try Some(input_line input_channel)
  with End_of_file -> None

let rec read_lines input_channel str_acc = 
  let attempt_read input_channel =
    try Some(input_line input_channel)
    with End_of_file -> None
  in
  match attempt_read input_channel with
  | Some line -> read_lines input_channel (line :: str_acc)
  | None -> List.rev str_acc 

let read_file input_channel =
  let contents = read_lines input_channel [] in
  String.concat "\n" contents

let print_file file_name =
  let contents = read_lines (open_file file_name) [] in
  print_string (String.concat "" contents)
