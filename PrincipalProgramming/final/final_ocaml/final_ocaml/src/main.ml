open Final

let test_final_1_1 ctxt =
  assert (VarSet.equal (variables_of_term (func "f" [var "X"; var "Y"; const "a"]))
          (VarSet.of_list [var "X"; var "Y"]))

let test_final_1_2 ctxt =
  assert (VarSet.equal (variables_of_term (func "p" [var "X"; var "Y"; const "a"]))
          (VarSet.of_list [var "X"; var "Y"]))

let test_final_1_3 ctxt =
  assert (VarSet.equal (variables_of_clause (fact (func "p" [var "X"; var "Y"; const "a"])))
          (VarSet.of_list [var "X"; var "Y"]))

let test_final_1_4 ctxt =
  assert (VarSet.equal (variables_of_clause (rule (func "p" [var "X"; var "Y"; const "a"]) [func "q" [const "a"; const "b"; const "a"]]))
          (VarSet.of_list [var "X"; var "Y"]))


let s =
  Substitution.add (var "Y") (const "0") (Substitution.add (var "X") (var "Y") Substitution.empty)

let test_final_2_1 ctxt =
  assert (substitute_in_term s (func "f" [var "X"; var "Y"; const "a"]) =
          func "f" [var "Y"; const "0"; const "a"])

let test_final_2_2 ctxt =
  assert (substitute_in_term s (func "p" [var "X"; var "Y"; const "a"]) =
          func "p" [var "Y"; const "0"; const "a"])

let test_final_2_3 ctxt =
  assert (substitute_in_clause s (fact (func "p" [var "X"; var "Y"; const "a"])) =
          (fact (func "p" [var "Y"; const "0"; const "a"])))

let test_final_2_4 ctxt =
  assert (substitute_in_clause s (rule (func "p" [var "X"; var "Y"; const "a"]) [func "q" [const "a"; const "b"; const "a"]]) =
          (rule (func "p" [var "Y"; const "0"; const "a"]) [func "q" [const "a"; const "b"; const "a"]]))


let test_final_3_1 ctxt =
  assert ((unify (var "X") (var "Y")) = Substitution.singleton (var "Y") (var "X") ||
          (unify (var "X") (var "Y")) = Substitution.singleton (var "X") (var "Y"))

let test_final_3_2 ctxt =
  assert ((unify (var "Y") (var "X")) = Substitution.singleton (var "X") (var "Y") ||
          (unify (var "Y") (var "X")) = Substitution.singleton (var "Y") (var "X"))

let test_final_3_3 ctxt =
  assert (unify (var "Y") (var "Y") = Substitution.empty)

let test_final_3_4 ctxt =
  assert (unify (const "0") (const "0") = Substitution.empty)

let test_final_3_5 ctxt =
  assert (unify (const "0") (var "Y") = Substitution.singleton (var "Y") (const "0"))

let test_final_3_6 ctxt =
  assert (
    match unify (const "0") (const "1") with
    | _ -> false
    | exception Not_unifiable -> true)

let test_final_3_7 ctxt =
  assert (
    match unify (func "f" [const "0"]) (func "g" [const "1"]) with
    | _ -> false
    | exception Not_unifiable -> true)

let test_final_3_8 ctxt =
  assert (unify (func "f" [var "X"]) (func "f" [var "Y"]) = Substitution.singleton (var "X") (var "Y") ||
          unify (func "f" [var "X"]) (func "f" [var "Y"]) = Substitution.singleton (var "Y") (var "X"))

let s9 =
  Substitution.add (var "Z") (const "a")
    (Substitution.add (var "Y") (const "a")
      (Substitution.add (var "X") (const "a") Substitution.empty))

let test_final_3_9 ctxt =
  let t1 = Function("f", [Variable "X"; Variable "Y"; Variable "Y"]) in
  let t2 = Function("f", [Variable "Y"; Variable "Z"; Constant "a"]) in
  let u = unify t1 t2 in
  assert (Substitution.equal (=) u s9)


(* Test on a simple program *)
let psimple = [fact (func "f" [const "a"; const "b"])]

let test_final_4_1 ctxt =
  let _ = print_endline "\n\nTesting the non-deterministic abstract interpreter" in
  let _ = print_endline ("Program:\n" ^ (string_of_program psimple)) in
  let g = [func "f" [const "a"; const "b"]] in
  let _ = print_endline ("Goal:\n" ^ (string_of_goal g)) in
  let g' = nondet_query psimple g in
  assert (g' = [func "f" [const "a"; const "b"]]);
  print_endline ("Solution:\n" ^ (string_of_goal g'))

let test_final_4_2 ctxt =
  let g = [func "f" [var "X"; const "b"]] in
  let _ = print_endline ("Goal:\n" ^ (string_of_goal g)) in
  let g' = nondet_query psimple g in
  assert (g' = [func "f" [const "a"; const "b"]]);
  print_endline ("Solution:\n" ^ (string_of_goal g'))

let test_final_4_3 ctxt =
  let g = [func "f" [var "X"; var "Y"]] in
  let _ = print_endline ("Goal:\n" ^ (string_of_goal g)) in
  let g' = nondet_query psimple g in
  assert (g' = [func "f" [const "a"; const "b"]]);
  print_endline ("Solution:\n" ^ (string_of_goal g') ^ "\n")


(* Test on the House Stark program *)
let ancestor x y = func "ancestor" [x;y]
let father x y = func "father" [x;y]
let father_consts x y =  father (Constant x) (Constant y)
let f1 = Fact (father_consts "rickard" "ned")
let f2 = Fact (father_consts "ned" "robb")
let r1 = Rule (ancestor (var "X") (var "Y"), [father (var "X") (var "Y")])
let r2 = Rule (ancestor (var "X") (var "Y"), [father (var "X") (var "Z"); ancestor (var "Z") (var "Y")])
let pstark = [f1;f2;r1;r2]

let test_final_4_4 ctxt =
  let _ = print_endline ("Program:\n" ^ (string_of_program pstark)) in
  let g = [ancestor (const "rickard") (const "ned")] in
  let _ = print_endline ("Goal:\n" ^ (string_of_goal g)) in
  let g' = nondet_query pstark g in
  print_endline ("Solution:\n" ^ string_of_goal g');
  assert (g' = [ancestor (const "rickard") (const "ned")])

let test_final_4_5 ctxt =
  let g = [ancestor (const "rickard") (const "robb")] in
  let _ = print_endline ("Goal:\n" ^ (string_of_goal g)) in
  let g' = nondet_query pstark g in
  print_endline ("Solution:\n" ^ (string_of_goal g'));
  assert (g' = [ancestor (const "rickard") (const "robb")])

let test_final_4_6 ctxt =
  let g = [ancestor (var "X") (const "robb")] in
  let _ = print_endline ("Goal:\n" ^ (string_of_goal g)) in
  let g' = nondet_query pstark g in
  print_endline ("Solution:\n" ^ (string_of_goal g') ^ "\n");
  assert (g' = [ancestor (const "ned") (const "robb")] ||
                  g' = [ancestor (const "rickard") (const "robb")])

(* Test on the list append program *)
let nil = const "nil"
let cons h t = func "cons" [h;t]
let append x y z = func "append" [x;y;z]
let c1 = fact (append nil (var "Q") (var "Q"))
let c2 = rule (append (cons (var "H") (var "P")) (var "Q") (cons (var "H") (var "R")))
                [append (var "P") (var "Q") (var "R")]
let pappend = [c1;c2]

let test_final_4_7 ctxt =
  let _ = print_endline ("Program:\n" ^ (string_of_program pappend)) in
  let g = [append (var "X") (var "Y") (cons (const "1") (cons (const "2") (cons (const "3") nil)))] in
  let _ = print_endline ("Goal:\n" ^ (string_of_goal g)) in
  let g' = nondet_query pappend g in
  print_endline ("Solution:\n" ^ (string_of_goal g') ^ "\n");
  assert (
  g' = [append nil (cons (const "1") (cons (const "2") (cons (const "3") nil))) (cons (const "1") (cons (const "2") (cons (const "3") nil)))] ||
  g' = [append (cons (const "1") nil) (cons (const "2") (cons (const "3") nil)) (cons (const "1") (cons (const "2") (cons (const "3") nil)))] ||
  g' = [append (cons (const "1") (cons (const "2") nil)) (cons (const "3") nil) (cons (const "1") (cons (const "2") (cons (const "3") nil)))] ||
  g' = [append (cons (const "1") (cons (const "2") (cons (const "3") nil))) nil (cons (const "1") (cons (const "2") (cons (const "3") nil)))] )

(* Test on the simple program *)
let test_challenge_1 ctxt =
  let _ = print_endline "\n\nTesting the deterministic interpreter" in
  let _ = print_endline ("Program:\n" ^ (string_of_program psimple)) in
  (* Tests query failure *)
  let g = [func "f" [const "a"; const "c"]] in
  let _ = print_endline ("Goal:\n" ^ (string_of_goal g)) in
  assert (det_query psimple g = []);
  print_endline ("Solution:\n" ^ "Empty solution\n")

(* Test on the Stark House program *)
let test_challenge_2 ctxt =
  let _ = print_endline ("Program:\n" ^ (string_of_program pstark)) in
  (* Tests backtracking *)
  let g = [ancestor (const "rickard") (const "robb")] in
  let _ = print_endline ("Goal:\n" ^ (string_of_goal g)) in
  let g' = match det_query pstark g with [v] -> v | _ -> failwith "error" in
  print_endline ("Solution:\n" ^ (string_of_goal g'));
  assert (g' = g)

let test_challenge_3 ctxt =
  (* Tests choice points *)
  let g = [ancestor (var "X") (const "robb")] in
  let _ = print_endline ("Goal:\n" ^ (string_of_goal g)) in
  let g1,g2 = match det_query pstark g with [v1;v2] -> v1,v2 | _ -> failwith "error" in
  print_endline ("Solution:\n" ^ (string_of_goal g1));
  print_endline ("Solution:\n" ^ (string_of_goal g2) ^ "\n");
  assert (g1 = [ancestor (const "ned") (const "robb")]);
  assert (g2 = [ancestor (const "rickard") (const "robb")])

(* Test on the list append program *)
let test_challenge_4 ctxt =
  let _ = print_endline ("Program:\n" ^ (string_of_program pappend)) in
  (* Tests choice points *)
  let g = [append (var "X") (var "Y") (cons (const "1") (cons (const "2") (cons (const "3") nil)))] in
  let _ = print_endline ("Goal:\n" ^ (string_of_goal g)) in
  let g' = det_query pappend g in
  assert (List.length g' = 4);
  List.iter (fun g -> print_endline ("Solution:\n" ^ (string_of_goal g))) g'


let _ = print_string ("Testing your code ...\n")

let main () =
  let error_count = ref 0 in

  (* Testcases for problem 1 *)
  let _ =
    try
    test_final_1_1 ();
    test_final_1_2 ();
    test_final_1_3 ();
    test_final_1_4 ();
    with e -> (error_count := !error_count + 1; print_string ((Printexc.to_string e)^"\n")) in

  (* Testcases for problem 2 *)
  let _ =
    try
    test_final_2_1 ();
    test_final_2_2 ();
    test_final_2_3 ();
    test_final_2_4 ();
    with e -> (error_count := !error_count + 1; print_string ((Printexc.to_string e)^"\n")) in

  (* Testcases for problem 3 *)
  let _ =
    try
    test_final_3_1 ();
    test_final_3_2 ();
    test_final_3_3 ();
    test_final_3_4 ();
    test_final_3_5 ();
    test_final_3_6 ();
    test_final_3_7 ();
    test_final_3_8 ();
    test_final_3_9 ();
    with e -> (error_count := !error_count + 1; print_string ((Printexc.to_string e)^"\n")) in

  (* Testcases for problem 4 *)
  let _ =
    try
    test_final_4_1 ();
    test_final_4_2 ();
    test_final_4_3 ();
    test_final_4_4 ();
    test_final_4_5 ();
    test_final_4_6 ();
    test_final_4_7 ();
    with e -> (error_count := !error_count + 1; print_string ((Printexc.to_string e)^"\n")) in

  (* Testcases for challenge problem *)
  let _ =
    try
    test_challenge_1 ();
    test_challenge_2 ();
    test_challenge_3 ();
    test_challenge_4 ();
    with e -> (error_count := !error_count + 1; print_string ((Printexc.to_string e)^"\n")) in

  Printf.printf ("%d out of 5 programming questions are incorrect.\n") (!error_count)

let _ = main()
