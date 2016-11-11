type typ = Int | Bool

type expr =
	Literal of int
| Id of string
| BoolLit of bool

type vdecl = 
	Declare of typ * string
| Initialize of typ * string * expr

type program = vdecl list