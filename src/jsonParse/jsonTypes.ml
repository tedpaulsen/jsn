type json_fragment =
  | JsonBool   of bool
  | JsonString of string
  | JsonInt    of int
  | JsonFloat  of float
  | JsonNull
  | JsonObject of (string * json_fragment) list
  | JsonArray  of json_fragment list
