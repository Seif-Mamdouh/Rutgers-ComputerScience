
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

        let rec lookup env x = match env with
          [] -> raise UndefinedVar| (y,v)::env' ->
          if x = y then v else lookup env' x

let rec eval_expr (e : exp) (env : environment) : value =

  match e with 


    | Number (e1) -> Int_Val(e1)

    | True -> Bool_Val(true)

    | False -> Bool_Val(false)

    | Var (e1) -> lookup env e1

    | Or (e1, e2) -> 
      let a1 = eval_expr e1 env in 
      let a2 = eval_expr e2 env in
      (match a1, a2 with 
      Bool_Val a1, Bool_Val a2 -> Bool_Val (a1 || a2) 
      | _ -> raise TypeError)
      
      
    | And (e1, e2) -> 
      let a1 = eval_expr e1 env in 
      let a2 = eval_expr e2 env in
      (match a1, a2 with 
      Bool_Val a1, Bool_Val a2 -> Bool_Val (a1 && a2) 
      | _ -> raise TypeError)


    | Not e1 -> 
      let a1 = eval_expr e1 env in 
      (match a1 with 
      Bool_Val a1 -> Bool_Val (not a1)
      | _ -> raise TypeError
      )

    | Lt(e1, e2) -> 
      let a1 = eval_expr e1 env in 
      let a2 = eval_expr e2 env in
      (match a1, a2 with 
      Int_Val a1, Int_Val a2 -> Bool_Val (a1 < a2)
      | _ -> raise TypeError)

    | Leq (e1, e2) -> 
      let a1 = eval_expr e1 env in 
      let a2 = eval_expr e2 env in
      (match a1, a2 with 
      Int_Val a1, Int_Val a2 -> Bool_Val (a1 <= a2)
      | _ -> raise TypeError)

    | Eq (e1, e2) -> 
      let a1 = eval_expr e1 env in 
      let a2 = eval_expr e2 env in
      (match a1, a2 with 
      Int_Val a1, Int_Val a2 -> Bool_Val (a1 = a2)
      | _ -> raise TypeError)

    | Fun (s1, e1) -> Closure (env, s1, e1)

    | App(e1, e2) -> 
      let a1 = eval_expr e1 env in 
      let a2 = eval_expr e2 env in
      (match a1 with 
      | Closure(env', x, e) -> eval_expr e ((x, a2) :: env')
      | _ -> raise TypeError
      )

    | Plus (e1, e2) -> 
      let a1 = eval_expr e1 env in 
      let a2 = eval_expr e2 env in 
      (match a1, a2 with 
      | Int_Val a1, Int_Val a2 -> Int_Val(a1 + a2) 
      | _ -> raise TypeError
      )

    | Minus (e1, e2) -> 
      let a1 = eval_expr e1 env in 
      let a2 = eval_expr e2 env in 
      (match a1, a2 with 
      | Int_Val a1, Int_Val a2 -> Int_Val(a1 - a2) 
      | _ -> raise TypeError
      )

    | Times (e1, e2) -> 
      let a1 = eval_expr e1 env in 
      let a2 = eval_expr e2 env in 
      (match a1, a2 with 
      | Int_Val a1, Int_Val a2 -> Int_Val(a1 * a2) 
      | _ -> raise TypeError
      )

    | Div (e1, e2) -> 
      let a1 = eval_expr e1 env in 
      let a2 = eval_expr e2 env in 
      (match a1, a2 with 
      | Int_Val a1, Int_Val a2 -> Int_Val(a1 / a2) 
      | _ -> raise TypeError
      )

    | Mod (e1, e2) -> 
      let a1 = eval_expr e1 env in 
      let a2 = eval_expr e2 env in 
      (match a1, a2 with 
      | Int_Val a1, Int_Val a2 -> Int_Val(a1 mod a2) 
      | _ -> raise TypeError
      )


    (* int i; *)
(* evaluate a command in an environment *)
let rec eval_command (c : com) (env : environment) : environment =
  match c with 
  


  | Skip -> env

  | Comp (c1, c2) -> 
    let env' = eval_command c1 env in 
    let update = eval_command c2 env' in 
    update

  | Declare (c1, c2) -> 
    (match c1 with
			| Int_Type -> (c2, Int_Val(0)) :: env 
			| Bool_Type  -> (c2, Bool_Val(false)) :: env
      | Lambda_Type -> (c2, Closure (env, "x", Var "x")):: env)

  | Assg (c1, c2) -> 
    let vicky = lookup env c1 in
    let marissa = eval_expr c2 env in 
    (match vicky, marissa with 
    | Int_Val vicky, Int_Val marissa -> (c1, Int_Val(marissa)) :: env
    | Bool_Val vicky, Bool_Val marissa -> (c1, Bool_Val(marissa)) :: env
    | Closure(env', seif, esra), Closure(env'', kassi, aleena) -> (c1, Closure (env'', kassi, aleena)) :: env
    | _ -> raise TypeError)


