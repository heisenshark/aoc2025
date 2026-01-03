
let rec pow a = function
  | 0 -> 1
  | 1 -> a
  | n -> 
    let b = pow a (n / 2) in
    b * b * (if n mod 2 = 0 then 1 else a)
let doubleNumber num:int = 
	let digits = int_of_float (log10 (float_of_int num)) + 1 in
	num *(pow 10 digits)+num
        
let rec sum_range (range_start:int) (range_end:int) (acc:int) = 
        if (range_start > range_end) then acc else sum_range (range_start+1) range_end ((doubleNumber range_start) + acc)


let for_range (low:int) (high:int) = 
        let digitsL = int_of_float (log10 (float_of_int low)) + 1 in 
        let digitsH = int_of_float (log10 (float_of_int high)) + 1 in 
        let lEven = digitsL mod 2 == 0 in 
        let leStart = (low/(pow 10 (digitsL/2))) in 
        let startN = if lEven then
                (if leStart >= (low mod (pow 10 (digitsL/2))) then leStart else (low/(pow 10 (digitsL/2))+1))
        else pow 10 ((digitsL-1)/2) in 
        let hEven = digitsH mod 2 == 0 in 
        let heStart = (high/(pow 10 (digitsH/2))) in 
        let endN = if hEven then
                (if heStart <= (high mod (pow 10 (digitsH/2))) then heStart else (high/(pow 10 (digitsH/2))-1))
        else pow 10 ((digitsH)/2) -1 in 
        let sum = sum_range startN endN 0 in

        print_endline ((string_of_int digitsL) ^ "-d-" ^ (string_of_int digitsH) ^ "elo -- " ^ (string_of_int startN) ^ "--" ^ (string_of_int endN) ^ "--"
        ^(string_of_int sum));
        sum


(* let fold_wrapper (a:string list) (acc:int) = *)
(*         let low = int_of_string (List.nth a 0) in *)
(*         let high = int_of_string (List.nth a 1) in *)
(*         let sum = for_range low high in *)
(*         acc + sum *)


let for_high_low = function (n: string list list) -> 
List.fold_left
  (fun acc x ->
        let low = int_of_string (List.nth x 0) in
        let high = int_of_string (List.nth x 1) in
        let sum = for_range low high in
        acc + sum
  )
  0
  n





let () = 

let ic = open_in "input1.txt" in 
          try 
            let line = input_line ic in
            let elo = List.map (function x -> String.split_on_char '-' x) (String.split_on_char ',' line) in

            (* List.iter (function x ->  *)
            (*             let high_low = String.split_on_char '-' x in  *)
            (*             print_endline (List.nth high_low 0); *)
            (*             print_endline (List.nth high_low 1); *)
            (*     ) elo; *)
            let _zzz = for_high_low elo in
                print_endline (string_of_int _zzz);
            flush stdout;
            close_in ic
          with e ->
            close_in_noerr ic;
            raise e 



(* let () = *)
(*   let ic = open_in "input1.txt" in *)
(*   try *)
(*     let line = input_line ic in *)
(*     let elo = String.split_on_char ',' line in *)
(*     (* let elo2 = List.map (fun x ->  x) sl in *) *)
(*     List.iter print_endline elo; *)
(**)
(*     print_endline line; *)
(*     flush stdout; *)
(*     close_in ic *)
(*   with e -> *)
(*     close_in_noerr ic; *)
(*     raise e *)
