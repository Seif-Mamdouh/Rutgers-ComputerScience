
open Ast

exception TypeError
exception UndefinedVar
exception DivByZeroError

(* Remove shadowed bindings *)
let prune_env (env : environment) : environment =
  let binds = List.sort_uniq compare (List.map (fun (id, _) -> id) env) in
  List.map (fun e -> (e, List.assoc e env)) binds

(* Env print function to stdout *)
let print_env_std (env : environment): unit =
  List.fold_left (fun _ (var, value) ->
      match value with
        | Int_Val i -> Printf.printf "- %s => %s\n" var (string_of_int i)
        | Bool_Val b -> Printf.printf "- %s => %s\n" var (string_of_bool b)
        | Closure _ -> ()) () (prune_env env)

(* Env print function to string *)
let print_env_str (env : environment): string =
  List.fold_left (fun acc (var, value) ->
      match value with
        | Int_Val i -> acc ^ (Printf.sprintf "- %s => %s\n" var (string_of_int i))
        | Bool_Val b -> acc ^ (Printf.sprintf "- %s => %s\n" var (string_of_bool b))
        | Closure _ -> acc
      ) "" (prune_env env)


(***********************)
(****** Your Code ******)
(***********************)

(* evaluate an arithmetic expression in an environment *)
(* let rec eval_expr (e : exp) (env : environment) : value = *)
let rec eval_expr (e : exp) (env : environment) : value =
  match e with 
    | Plus (e1, e2) -> 
      let a1 = eval_expr e1 env in 
      let a2 = eval_expr e2 env in 
      (match a1, a2 with 
      | Int_Val i, Int_Val j -> Int_Val(a1 + a2) 
      | _ -> raise TypeError
      )

      
  
  
  
  (* Int_Val 0;; *)

(* let rec eval env e =
  match e with
  Ident x -> lookup env x
  | Val v -> v
  | Plus (e1,e2) ->
    let Int n1 = eval env e1 in
    let Int n2 = eval env e2 in
    let n3 = n1+n2 in
    Int n3
    | Let (x,e1,e2) ->
      let v1 = eval env e1 in
      let env’ = extend env x v1 in let v2 = eval env’ e2 in v2
      | Eq0 e1 -> let Int n = eval env e1 in
      if n=0 then Bool true else Bool false
      | If (e1,e2,e3) ->
        let Bool b = eval env e1 in if b then eval env e2
        else eval env e3 *)



(* match e with
| Plus (e1, e2) ->
  let r1 = eval_expr e1 env in
  let r2 = eval_expr e2 env in
  (match r1, r2 with
  | Int_Val i, Int_Val j -> ...
  | _ -> ...)  *)
  (* The parentheses are needed to delimit the scope of the two pattern-matchings *)


(* evaluate a command in an environment *)
let rec eval_command (c : com) (env : environment) : environment =
    []
