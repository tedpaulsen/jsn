type json_token =
  | Bool of bool
  | Int of int
  | String of string
  | Float of float
  | Null
  | BRA
  | KET
  | ARR
  | RAY
  | COL
  | COM
  | EOF
  | ERROR of string
;;

type json_type =
  | JsonBool of bool
  | JsonString of string
  | JsonInt of int
  | JsonFloat of float
  | JsonObject of string * json_type
  | JsonArray of json_type list
  | JsonNull
;;