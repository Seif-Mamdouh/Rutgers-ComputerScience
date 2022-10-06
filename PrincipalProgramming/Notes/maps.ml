
(* This map takes a function and a lsit, applies the function to 
   each element of the list and return a list of the results *)

let rec map f lst = 
  match lst with 
  [] -> []
  | (h::t) -> (f h) :: (map f t);;


  let double x = x * 2;; 
  map double [1;2;3];;

  let negate x = -x;;
  map negate [9; -5; 0];;