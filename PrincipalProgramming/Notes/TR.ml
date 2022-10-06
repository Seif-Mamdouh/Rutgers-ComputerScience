let rec fold_left f a lst = 
  match lst with 
  [] -> a
  | (h::t) -> fold_left f (f a h) t;;


  (* Tail Recursion Pattern *)
(* 
  let func x = 
    let rec helper arg acc =
      if (base case) then acc
      else 
        let arg' = (argument to recursive call) in 
        let acc' = (updated accumulator) in  
        helper arg' acc' in (end of helper function)
      helper x (initial value of accumulator);;
 *)


let fact x = 
  let rec helper arg acc = 
    if arg = 0 then acc
    else
        let arg = arg - 1 in
        let acc = acc * arg in
        helper arg acc in     (*end of helper function *)
  helper x 1
;;