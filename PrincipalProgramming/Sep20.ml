(* rec functions with a matching pattern that returns the total of Head + Tail *)
(* let rec total l = 
  match l with 
  | [] -> 0
  | h :: t -> h + total t;;


  total [1;2;3];; *)


(* prints out the length of the list *)
  (* let rec length l =
    match l with
    | [] -> 0
    | _ :: t -> 1 + length t;;

    length [1;2;3];; *)

                          (* Polyophric Functions *)

(* Polymorphic functions are functions that act over values with many different types. *)

(* OCaml gives such functions polymorphic types
○ hd : ‘a list -> ‘a
○ This says the function takes a list of any element 
type ‘a, and returns something of the same type *)

(* let tl (_ :: t) = t;;

tl [1;2;3];; *)


let rec append a b =
    match a with
    | [] -> b
    | h :: t -> h :: append t b;;
(* val append : 'a list -> 'a list -> 'a list = <fun> *)

append [2][3];;


let rec map f l =
    match l with
    | [] -> []
    | h :: t -> f h :: map f t;;

    map total [[1; 2]; [3; 4]; [5; 6]];;

