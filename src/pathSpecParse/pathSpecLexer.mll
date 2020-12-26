{
  open PathSpecParser

  exception SyntaxError of string
}

let str = (['a'-'z'] | ['A'-'Z'] | ['0'-'9'])+
let int = ['0' - '9']+

rule read = parse
  | "." { DOT }
  | int { INDEX (int_of_string (Lexing.lexeme lexbuf)) }
  | str { ID (Lexing.lexeme lexbuf) }
  | "[" { ARR }
  | "]" { RAY }
  | eof { EOF }
  | _   { raise (SyntaxError (Lexing.lexeme lexbuf)) }
