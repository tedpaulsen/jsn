type json =
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
;;

type mode = 
  | FromFile
  | FromStdin
;;