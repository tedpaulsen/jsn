%{
  open! Path_spec_types
%}

%token DOT
%token ARR
%token RAY
%token <int> INDEX
%token <string> ID
%token EOF

%start <Path_spec_types.specifier option> exec

%%

exec:
  | s = pathspec; { Some s }
  | EOF           { None }
;

/*
Right now we are limiting the syntax for paths to be like

`.Comments[3].DateCreated`

Specifically, a pathspec is made up of one or more fragment specifiers,
This could be like `.Comments` specifies the JsonFragment assocated with
the Comments key. And/Or a pathspec is made up of array element specifier(s)
like [0] specifies the JsonFragment at 0th index
*/
pathspec:
  | EOF { TerminalSpec }
  | DOT; k = ID; rest = pathspec           { FieldSpec (k, rest) }
  | ARR; i = INDEX ; RAY; rest = pathspec  { ElementSpec (i, rest) }
;
