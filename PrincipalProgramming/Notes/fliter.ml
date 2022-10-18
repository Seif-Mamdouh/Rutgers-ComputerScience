(* let rec filter p = function
  | [] -> []
  | h :: t -> if p h then h :: filter p t else filter p t *)




  let rec filter_helper p acc = function
  | [] -> List.rev acc
  | h :: t -> filter_helper p (if p h then h :: acc else acc) t

  let rec filter p lst = filter_helper p [] lst ;;


    let even x = 
    x mod 2 = 0;;

  let odd x = 
    x mod 2 = 1;;
    
    
    let evens' lst = filter even lst;;
    let odds' lst = filter odd lst;;
