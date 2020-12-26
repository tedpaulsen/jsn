type specifier =
  | FieldSpec of (string * specifier)
  | ElementSpec of (int * specifier)
  | TerminalSpec
