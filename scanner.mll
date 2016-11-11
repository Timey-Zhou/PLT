{open Parser}

rule token = parse
	[' ' '\t' '\r' '\n'] { token lexbuf}
|	"int"	{ INT }
|	"bool"	{ BOOL }
|	"true"	{ TRUE }
|	"false"	{ FALSE }
|	"="		{ ASSIGN }
|	";"		{ SEMI }
| ['0'-'9']+ as lxm { LITERAL(int_of_string lxm) }
| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { ID(lxm) }
| eof { EOF }
