(* floating points *)

let average_float a b = 
  (a +. b) /. 2.0 ;; 

  average_float 2.0 3.4;;

  let average_float2 a b c = 
    ( a -. b -. c) /. 2.9 ;;

    average_float2 2.4 3.6 5.9;;

let average_float3 a b c d = 
  (a *. b *. c*. d) /. 3.2;;

  average_float3 2.4 5.6 1.3 8.9;; 


  (* Recursive Functions *)
  (* Recrusvive is the function that calls itself within itslef *)
  (* in Ocaml we have we use 'rec' to show ocaml that we are using recursion alog *)

  let rec range a b = 
    if a > b then []
    else a :: range (a + 1 ) b;;

    let digits = range 0 20;;

    digits;;

    (* This is a expression not a statement 

       An expression is an instruction to be exuexted for example if else. 
       It is okay with returning a void statement.

       A statment is used from the sequence of a program example: if - then or while do
       A statement can be simple or complex and can contain 0 or more expression.

       *)