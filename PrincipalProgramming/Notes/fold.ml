


let rec fold f acc lst = 
  match lst with 
  [] -> acc
  | (h::t) -> fold f (f acc h) t;;

  

