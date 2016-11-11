%{ open Ast %}

%token SEMI ASSIGN
%token INT BOOL
%token TRUE FALSE

%token <int> LITERAL
%token <string> ID
%token EOF

%start program
%type <Ast.program> program

%%

program: decls EOF { $1 }

decls:	{ [] }
|	decls vdecl	{ $2 :: $1 }

typ: INT { Int }
|	BOOL { Bool }

expr:
	LITERAL	{ Literal ($1) }
|	ID		{ Id ($1) }
|	TRUE	{ BoolLit(true) }
|	FALSE	{ BoolLit(true) }

vdecl :
	typ ID SEMI	{ Declare ($1, $2)}
|	typ ID ASSIGN expr SEMI { Initialize ($1, $2, $4)}