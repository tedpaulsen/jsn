{
  open Lexing
  open Types
}

let non_zero_digit = ['1'-'9']
let digit = ['0'-'9']
let int =   '-'? non_zero_digit digit*
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
  | true                    { True }
  | false                   { False }
  | int                     { Int (int_of_string (Lexing.lexeme lexbuf)) }
  | float                   { Float (float_of_string (Lexing.lexeme lexbuf)) }
  | eof                     { EOF }
  | _                       { ERROR (Lexing.lexeme lexbuf) }
