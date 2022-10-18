
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



  let t = [1;2;3;4] in map (fun x -> x - 1) t;;

  let t = [1;2;3;4;5] in let sub1 x = x - 1 in map sub1 t




  (* This is a wow moment for me *)
  let lst = [1;2;3];;
  let neg x = x * (-1);;
  let sub1 x = x - 1;;
  let double x = x * 2;;

  let fs = [neg; sub1; double] in map (fun x -> map x lst) fs;;




  let is_even x = ( x mod 2 = 0) in map is_even [1;2;3;4;5];;






  let fact x = 
  let rec helper arg acc = 
    if arg = 0 then acc
    else
        let arg = arg - 1 in
        let acc = acc * arg in
        helper arg acc in     (*end of helper function *)
  helper x 1
;;


(*  use fold_left 
   start with empty list
  for each element f in fs
  apply f to each element of args
  using map
  and append it to a (accumulator) *)
  
  
  let ap fs args =
  List.fold_left 
    (fun a f -> a @ (List.map f args)) [] fs;;

let test l = 
  match l with [] -> failwith "None"   
  |h::t ->  let rec helper (seen,rest) = 
    match rest with [] -> seen 
    |h'::t' -> let seen' = if h' > seen then h' else seen in 
    let rest' = t'
  in helper (seen',rest') 
in helper (h,t) 


(* let rec fold_inorder f acc t =
  match t with
  |Node(l, n, r) -> let ar = fold_inorder f acc r in
    let an = n :: ar in
      fold_inorder f an l
  |Leaf -> acc;; *)