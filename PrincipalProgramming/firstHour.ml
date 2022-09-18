(* let x = 5 in x * x;;*)


(* let a = 10 in 
let b = 2 in 
a + b;;  *)


(* Function can take multiple of arguments, unlike impreatitve lanagauges *)

let sqare x = x * x;;
(* sqare 5;; *)

let sqaure_is_even x = sqare x mod 2 = 0;;

sqaure_is_even 5;;