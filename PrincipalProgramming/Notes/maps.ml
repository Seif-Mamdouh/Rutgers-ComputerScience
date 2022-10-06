
(* This map takes a function and a lsit, applies the function to 
   each element of the list and return a list of the results *)

let rec map f lst = 
  match lst with 
  [] -> []
  | (h::t) -> (f h) :: (map f t);;


  (* let double x = x * 2;; 
  map double [1;2;3];;

  let negate x = -x;;
  map negate [9; -5; 0];;



  let t = [1;2;3;4] in map (fun x -> x - 1) t;;

  let t = [1;2;3;4;5] in let sub1 x = x - 1 in map sub1 t *)




  (* This is a wow moment for me *)
  let lst = [1;2;3];;
  let neg x = x * (-1);;
  let sub1 x = x - 1;;
  let double x = x * 2;;

  let fs = [neg; sub1; double] in map (fun x -> map x lst) fs;;