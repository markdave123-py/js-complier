module ConcreteSyntax

lexical IntegerLiteral = [0-9]+ !>> [0-9];
lexical Identifier = [a-zA-Z][a-zA-Z0-9]* !>> [a-zA-Z0-9];
lexical FloatLiteral = [0-9]+[.][0-9]+;
lexical String =   "\"" ![\"]*  "\"" | "\'" ![\']* "\'";


syntax KeyValuePairs = keyValue : Expression ":" Expression ","?;
syntax SwitchStatement =
   switchCase: "case" Expression ":" Expression*
  > defaultCase: "default" ":" Expression*
  ;


syntax ClassProperty =
   classAttribute: Identifier "=" Expression ";"

  | classAttribute: Identifier ";"
  // | classConstructor: "constructor" "(" { Expression "," }* ")" "{" Expression "}"
  | classMethod: Identifier "(" { Expression "," }* ")" FunctionExpression
  ;

syntax FunctionExpression =
       expression: Expression
      | \return: "return" Expression ";"
      | \return: "return" ";"
      ;

start syntax Expression
  =
     right let: "let" Expression "=" Expression  ";"
    | right let: "let" Expression "=" Expression
    | right \const: "const" Expression "=" Expression
    | right \const: "const" Expression "=" Expression ";"
    | ifCondition: "if" "(" Expression ")" Expression "else" Expression
    | bracket "(" Expression ")"
    | variable: Identifier
    | integerLiteral: IntegerLiteral
    >  floatLiteral: FloatLiteral
    | string: String
    | class: "class" Expression {":" Expression }*  "{" ClassProperty "}"
    | class: "class" Expression "{" ClassProperty "}"
    | \return: "return" Expression ";"
    | \import: "import" Expression "from" String ";"
    | \import: "import" "{" { Expression "," }* "}" "from" String ";"
    | \import: "import" Expression "," "{" {Expression ","}* "}" "from" String ";"
    > non-assoc (
      left property: Expression "." Expression
    > left property: Expression "." Expression ";"
    > left member: Expression "[" Expression "]"
    > left member: Expression "[" Expression "]" ";"
    > left call: Expression "(" { Expression "," }* ")"
    )
    | left \function: "function" Expression "(" { Expression ","? }* ")"  FunctionExpression
    | left \function: "function" "(" { Expression ","? }* ")" FunctionExpression
    | \switch: "switch" "(" Expression ")" "{" SwitchStatement+ "}"
    | block: "{" Expression "}"
    | object: "{" KeyValuePairs* "}"
    | tryCatch: "try" Expression "catch" Expression Expression
    | tryCatch: "try" Expression "catch" "("")" Expression
    | right \throw: "throw" Expression ";"
    | right \throw: "throw" Expression
    | \list: "[" { Expression ","?}* "]"
    | arrowFunction: "(" { Expression ","}* ")" "=" "\>" "{" Expression "}"
    | \for: "for" "(" Expression ";" Expression ";" Expression ")" Expression
    | \forIn: "for" "(" Expression "in" Expression ")" Expression
    | \forOf: "for" "(" Expression "of" Expression ")" Expression
    | \while: "while" "(" Expression ")" Expression
    | doWhile: "do" Expression "while" "(" Expression ")" ";"
    > non-assoc (
        left mul: Expression "*" Expression
      | left mul: Expression "*" Expression ";"
      | left add: Expression "+" Expression
      | left add: Expression "+" Expression ";"
      | left sub: Expression "-" Expression
      | left sub: Expression "-" Expression ";"
      | left \mod: Expression "%" Expression
      | non-assoc div: Expression "/" Expression
      | non-assoc div: Expression "/" Expression ";"
    )

    >
    non-assoc (
        non-assoc gt: Expression "\>" Expression
      | non-assoc gt: Expression "\>" Expression ";"
      | non-assoc lt:  Expression "\<" Expression
      | non-assoc lt:  Expression "\<" Expression ";"
      | non-assoc geq:  Expression "\>=" Expression
      | non-assoc geq:  Expression "\>=" Expression ";"
      | non-assoc leq:  Expression "\<=" Expression
      | non-assoc leq:  Expression "\<=" Expression ";"

    )
    > right sequence: Expression ";" Expression
    > right increment: Expression "++"
    > right decrement: Expression "--"
    > right (
        right assign: Expression "=" Expression ";"
      | right addAssign: Expression "+=" Expression ";"
      | right subAssign: Expression "-=" Expression ";"
      | right mulAssign: Expression "*=" Expression ";"
      | right divAssign: Expression "/=" Expression ";"
      | right modAssign: Expression "%=" Expression ";"
    )

    > left (
        left eq: Expression "==" Expression
      | left neq: Expression "!=" Expression
      | left strictEq: Expression "===" Expression
      | left strictNeq: Expression "!==" Expression

    )
    > left (
        left and: Expression "&&" Expression
      | left or: Expression "||" Expression
      | left ternary: Expression "?" Expression ":" Expression
      | left not: "!" Expression
    )
  | empty: ";"
  | \true: "true"
  | \false: "false"
  | right new: "new" Expression

;


keyword Keywords
    = "let"
    | "const"
    | "if"
    | "else"
    | "return"
    | "function"
    | "switch"
    | "case"
    | "default"
    | "break"
    | "continue"
    | "for"
    | "while"
    | "do"
    | "in"
    | "of"
    | "true"
    | "false"
    | "null"
    | "undefined"
    | "import"
    | "export"
    | "from"
    | "as"
    | "try"
    | "catch"
    | "finally"
    | "throw"
    | "new"
    | "class"
    | "extends"
    | "super"
    | "this"
    | "typeof"
    | "instanceof"
    | "return"
    ;

layout Whitespace
    = [\ \t\n]*;