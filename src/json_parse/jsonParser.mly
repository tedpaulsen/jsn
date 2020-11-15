%{
  open JsonTypes
%}

%token <int> INT
%token <float> FLOAT
%token <string> STRING
%token <bool> BOOL
%token NULL
%token BRA
%token KET
%token ARR
%token RAY
%token COL
%token COM
%token EOF

/* define entry point and return type */
%start <JsonTypes.json_fragment option> exec

%%

/* entry point */
exec:
  | f = fragment;   { Some f }
  | EOF             { None }
;

obj:
  flds = separated_list(COM, obj_entry)      { flds }
;

obj_entry:
  k = STRING; COL; v = fragment;             { (k, v) }
;

array_elements:
  elts = separated_list(COM, fragment)       { elts }
;

/* main fragment builder */
fragment:
  | BRA; o = obj; KET;              { JsonObject o }
  | ARR; e = array_elements; RAY    { JsonArray e }
  | s = STRING                      { JsonString s }
  | b = BOOL                        { JsonBool b }
  | i = INT                         { JsonInt i }
  | f = FLOAT                       { JsonFloat f }
  | NULL                            { JsonNull }
;
