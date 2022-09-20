(* Tail of a list

Statement

Solution
Write a function last : 'a list -> 'a option that returns the last element of a list

# last ["a" ; "b" ; "c" ; "d"];;
- : string option = Some "d"
# last [];;
- : 'a option = None *)

let rec last = function 
  | [] -> None
  | [ x ] -> Some x
  | _ :: t -> last t;;

  last ["a" ; "b" ; "c" ; "d"];;


  let rec last_two = function
  | [] -> None
  | [ x; y ] -> Some (x, y)
  | _ :: t -> last_two t;;

  last_two ["a" ; "b" ; "c" ; "d"];;


    let rec last_three = function
  | [] -> None
  | [ x; y ; z] -> Some (x, y, z)
  | _ :: t -> last_three t;;

  last_three ["a" ; "b" ; "c" ; "d"; "e"; "f"];;


  let rec length x = 
    match x with 
    | [] -> 0
    | _ :: t -> 1 + length t;;

    length ["a" ; "b" ; "c"];;