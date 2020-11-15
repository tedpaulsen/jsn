(* type json_token =
  | BOOL of bool
  | INT of int
  | STRING of string
  | FLOAT of float
  | NULL
  | BRA
  | KET
  | ARR
  | RAY
  | COL
  | COM
  | EOF
  | ERROR of string *)

type json_fragment =
  | JsonBool of bool
  | JsonString of string
  | JsonInt of int
  | JsonFloat of float
  | JsonNull
  | JsonObject of (string * json_fragment) list
  | JsonArray of json_fragment list