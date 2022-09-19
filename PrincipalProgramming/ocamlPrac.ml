(* floating points *)

(* let average_float a b = 
  (a +. b) /. 2.0 ;; 

  average_float 2.0 3.4;;

  let average_float2 a b c = 
    ( a -. b -. c) /. 2.9 ;;

    average_float2 2.4 3.6 5.9;;

let average_float3 a b c d = 
  (a *. b *. c*. d) /. 3.2;;

  average_float3 2.4 5.6 1.3 8.9;;  *)


  (* Recursive Functions *)
  (* Recrusvive is the function that calls itself within itslef *)
  (* in Ocaml we have we use 'rec' to show ocaml that we are using recursion alog *)

  (* let rec range a b = 
    if a > b then []
    else a :: range (a + 1 ) b;;

    let digits = range 0 20;;

    digits;; *)

    (* This is a expression not a statement 

       An expression is an instruction to be exuexted for example if else. 
       It is okay with returning a void statement.

       A statment is used from the sequence of a program example: if - then or while do
       A statement can be simple or complex and can contain 0 or more expression.

       *)

(* let rec factorial n =
    match n with
    | 0 | 1 -> 1
    | x -> x * factorial (x - 1);; *)




    (* Pattern Matching *)

    (* Instead of using if then else 
       We an use 'match' keyword to match on multiple possible values 
    *)

let rec factorial n = 
  match n with 
  | 0 | 1 -> 1 
  | x -> x * factorial (x - 1);;

  factorial 0

(* instead of using x in the second line and use the '_' and use w 
    _ which matches anything 
 *)

let rec factorial2 w = 
  match w with 
  | 0 | 1 -> 1
  | _ -> w * factorial (w - 1);;

factorial 3

let factorial3 q = function
  | 0 | 1 -> 1
  | n -> n * factorial (q - 1);;

  factorial3 4


(* Lists *)

(* Lists are a common compound data type in OCaml. They are ordered collections of elements of like type: *)

(* [];;
- : 'a list = []
# [1; 2; 3];;
- : int list = [1; 2; 3]
# [false; false; true];;
- : bool list = [false; false; true]
# [[1; 2]; [3; 4]; [5; 6]];;
- : int list list = [[1; 2]; [3; 4]; [5; 6]] *)

(* The head is the first element in the Linked List and the 
   tail is the rest of the elements of the Linked List *)

   1 :: [2; 3];;
   [3] @ [4; 5];;

   