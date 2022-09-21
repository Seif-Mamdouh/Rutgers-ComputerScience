(* Functions Syntax *)
(* let <function name> <inputs> = <outputs> *)

let add x = x + 2;;

add 2;;

let addFloat y = y +. 3.2;;

addFloat 3.2;;


let multiply j h = j * h ;;

multiply 2 3;;


let int_to_month i = 
  match i with 
  | 1 -> "Jan"
  | 2 -> "Feb"
  | 3 -> "March"
  | 4 -> "April"
  | _ -> "None";;


int_to_month 0;;