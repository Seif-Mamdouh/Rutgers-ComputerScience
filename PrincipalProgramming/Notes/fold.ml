(* fold is a function that takes two arguments,
    an initial value and a list *)

(* Combines the list recursively by applying the function
to the accumulaotr and one element from the list 
   until the list is exhausted *)


let rec fold f acc lst = 
  match lst with 
  [] -> acc
  | (h::t) -> fold f (f acc h) t;;


  fold (fun y z -> y + z) 2 [1;-3;1;7];;


  (* 2 + 1 = 3
     3 - 3 = 0
     0 + 1 = 1 
     7 + 1 = 8 *)

     (* We Recursively called the function until we added 
        everything togther with the initial value 
        and returned outpiut *)



let rec fold f acc lst = 
  match lst with 
  [] -> acc
  | (h::t) -> fold f (f acc h) t;;


  let add x y = x + y in
  let lst = [2;3;4] in fold add 0 lst;;

    let next a _ = a + 1 in 
    fold next 0 [2;3;4;5];;


    let prepend a x = x :: a in 
    fold prepend [] [2;3;4;5];;


    let f acc y = 
      if(y mod 2) = 0 
        then y :: acc 
    else
       acc in fold f [] [1;2;3;4;5;6];;


