open Ast
module StringMap = Map.Make(String)

let lexbuf = Lexing.from_channel stdin;;
let vdecls = List.rev (Parser.program Scanner.token lexbuf);;

let string_of_typ = function
		Int -> "int"
	|	Bool -> "bool"

let string_of_expr = function
		Literal(l) -> string_of_int l
	| Id(s) -> s
  	| BoolLit(true) -> "true"
  	| BoolLit(false) -> "false"

let string_of_vdecl = function
		Declare(t, id) -> string_of_typ t ^ " " ^ id
	| Initialize(t, id, exp) ->	string_of_typ t ^ " " ^ id ^ "=" ^ string_of_expr exp

let check m decl=
	let check_assign lv rv err =
     if lv == rv then lv else raise err
  	in
	let type_of_identifier s map= 
		try StringMap.find s map
		with Not_found ->
			raise (Failure ("undecalred identifier " ^ s)) 
	in
	let expr e map = match e with
		Literal _ -> Int
	| BoolLit _ -> Bool 
	| Id s -> type_of_identifier s map 
	in
	let create stmt = match stmt with
		Declare(t, id) -> StringMap.add id t m
	| Initialize(t, id, exp) -> let rt = expr exp m in
			ignore( check_assign t (expr exp m)
					(Failure ("illegal assignment " ^ string_of_typ t ^
				     " = " ^ string_of_typ rt ^ " in " ^ 
				     string_of_vdecl stmt)));
			StringMap.add id t m
	in
	create decl

let result = List.fold_left check StringMap.empty vdecls;;
StringMap.iter (fun id t -> print_string(id ^ " " ^ string_of_typ t ^ "\n")) result;