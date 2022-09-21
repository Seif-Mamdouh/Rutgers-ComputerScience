(* Functions Syntax *)
(* let <function name> <inputs> = <outputs> *)

let add x = x + 2;;

add 2;;

let addFloat y = y +. 3.2;;

addFloat 3.2;;


let multiply j h = j * h ;;

multiply 2 3;;



(* Pattern MAtching *)

let int_to_month i = 
  match i with 
  | 1 -> "Jan"
  | 2 -> "Feb"
  | 3 -> "March"
  | 4 -> "April"
  | _ -> "None";;


int_to_month 0;;



(* Recursive functions *)

let rec fact n = 
  if n == 1 then 1 
  else n * fact(n - 1);;

  fact 6;;

  let rec fib n = 
    if(n <= 1) then 1
    else (fib(n - 1) + fib(n - 2));;

    fib 4;;


    (* lists *)
let rec length a = 
  match a with 
  | [] -> 0
  | (a :: b ) -> 1 + (length b);;

  length [1;2;3;4];;