{
  open Lexing
  open JsonParser

  exception SyntaxError of string
}

let non_zero_digit = ['1'-'9']
let digit = ['0'-'9']
let int =   '-'? digit*
let float = '-'? digit+ '.' digit+
let str = "\"" ( [^'"'] | "\\\"" )* "\""

let whitespace = [' ' '\t']
let newline = '\r' | '\n' | "\r\n"

let true = "true"
let false = "false"
let null = "null"

rule token = parse
  | whitespace+             { token lexbuf }
  | newline                 { new_line lexbuf; token lexbuf }
  | str                     { STRING (Lexing.lexeme lexbuf) }
  | "{"                     { BRA }
  | "}"                     { KET }
  | "["                     { ARR }
  | "]"                     { RAY }
  | ":"                     { COL }
  | ","                     { COM }
  | true | false            { BOOL (bool_of_string (Lexing.lexeme lexbuf)) }
  | int                     { INT (int_of_string (Lexing.lexeme lexbuf)) }
  | float                   { FLOAT (float_of_string (Lexing.lexeme lexbuf)) }
  | null                    { NULL }
  | eof                     { EOF }
  | _                       { raise (SyntaxError (Lexing.lexeme lexbuf)) }
