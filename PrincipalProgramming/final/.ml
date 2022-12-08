module VarSet = Set.Make(struct type t = term let compare = Pervasives.compare end)
(* API Docs for Set : https://caml.inria.fr/pub/docs/manual-ocaml/libref/Set.S.html *)

let rec variables_of_term t =
  (* VarSet.empty *)
  match t with
  |Constant _ -> VarSet.empty
  |Function (_,y)->let rec vari p =
    match p with
    []->VarSet.empty
    |h::t->(VarSet.union (variables_of_term h) (vari t))
  in vari y
  |x->VarSet.singleton x
  let _ = assert (VarSet.equal (variables_of_term (func "f" [var "X"; var "Y"; const "a"]))
  (VarSet.of_list [var "X"; var "Y"]))
  let rec varia p =
    match p with
    []->VarSet.empty
    |h::t->(VarSet.union (variables_of_term h) (varia t))


let variables_of_clause c =
  (* VarSet.empty *)
  match c with
      |Fact x->variables_of_term x
      |Rule (h,b)->VarSet.union(variables_of_term h) (varia b)
      let _ = assert (VarSet.equal (variables_of_clause (fact (func "p" [var "X"; var "Y"; const "a"])))
      (VarSet.of_list [var "X"; var "Y"]))
      let _ = assert (VarSet.equal (variables_of_clause (rule (func "p" [var "X"; var "Y"; const "a"])
      [func "q" [const "a"; const "b"; const "a"]]))
      (VarSet.of_list [var "X"; var "Y"]))