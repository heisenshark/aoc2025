(* let build_set digits repeatedDigits =  *)
(*         let nigga = Set.Make(int) in  *)
(**)
(**)
(* let rec pow a = function *)
(*   | 0 -> 1 *)
(*   | 1 -> a *)
(*   | n ->  *)
(*     let b = pow a (n / 2) in *)
(*     b * b * (if n mod 2 = 0 then 1 else a) *)
(**)
(* let doubleNumber num:int =  *)
(* 	let digits = int_of_float (log10 (float_of_int num)) + 1 in *)
(* 	num *(pow 10 digits)+num *)
(*          *)
(* let rec sum_range (range_start:int) (range_end:int) (acc:int) =  *)
(*         if (range_start > range_end) then acc else sum_range (range_start+1) range_end ((doubleNumber range_start) + acc) *)
(**)
(**)
(* let for_range (low:int) (high:int) =  *)
(*         let digitsL = int_of_float (log10 (float_of_int low)) + 1 in  *)
(*         let digitsH = int_of_float (log10 (float_of_int high)) + 1 in  *)
(*         let lEven = digitsL mod 2 == 0 in  *)
(*         let leStart = (low/(pow 10 (digitsL/2))) in  *)
(*         let startN = if lEven then *)
(*                 (if leStart >= (low mod (pow 10 (digitsL/2))) then leStart else (low/(pow 10 (digitsL/2))+1)) *)
(*         else pow 10 ((digitsL-1)/2) in  *)
(*         let hEven = digitsH mod 2 == 0 in  *)
(*         let heStart = (high/(pow 10 (digitsH/2))) in  *)
(*         let endN = if hEven then *)
(*                 (if heStart <= (high mod (pow 10 (digitsH/2))) then heStart else (high/(pow 10 (digitsH/2))-1)) *)
(*         else pow 10 ((digitsH)/2) -1 in  *)
(*         let sum = sum_range startN endN 0 in *)
(**)
(*         print_endline ((string_of_int digitsL) ^ "-d-" ^ (string_of_int digitsH) ^ "elo -- " ^ (string_of_int startN) ^ "--" ^ (string_of_int endN) ^ "--" *)
(*         ^(string_of_int sum)); *)
(*         sum *)
(**)
(**)
(* (* let fold_wrapper (a:string list) (acc:int) = *) *)
(* (*         let low = int_of_string (List.nth a 0) in *) *)
(* (*         let high = int_of_string (List.nth a 1) in *) *)
(* (*         let sum = for_range low high in *) *)
(* (*         acc + sum *) *)
(**)
(**)
(* let for_high_low = function (n: string list list) ->  *)
(* List.fold_left *)
(*   (fun acc x -> *)
(*         let low = int_of_string (List.nth x 0) in *)
(*         let high = int_of_string (List.nth x 1) in *)
(*         let sum = for_range low high in *)
(*         acc + sum *)
(*   ) *)
(*   0 *)
(*   n *)
(**)
(**)
(**)
(**)
(**)
(* let () = let ic = open_in "input1.txt" in  *)
(*           try  *)
(*             let line = input_line ic in *)
(*             let elo = List.map (function x -> String.split_on_char '-' x) (String.split_on_char ',' line) in *)
(**)
(*             (* List.iter (function x ->  *) *)
(*             (*             let high_low = String.split_on_char '-' x in  *) *)
(*             (*             print_endline (List.nth high_low 0); *) *)
(*             (*             print_endline (List.nth high_low 1); *) *)
(*             (*     ) elo; *) *)
(*             let _zzz = for_high_low elo in *)
(*                 print_endline (string_of_int _zzz); *)
(*             flush stdout; *)
(*             close_in ic *)
(*           with e -> *)
(*             close_in_noerr ic; *)
(*             raise e  *)
(**)
(**)
(**)
(* (* let () = *) *)
(* (*   let ic = open_in "input1.txt" in *) *)
(* (*   try *) *)
(* (*     let line = input_line ic in *) *)
(* (*     let elo = String.split_on_char ',' line in *) *)
(* (*     (* let elo2 = List.map (fun x ->  x) sl in *) *) *)
(* (*     List.iter print_endline elo; *) *)
(* (**) *)
(* (*     print_endline line; *) *)
(* (*     flush stdout; *) *)
(* (*     close_in ic *) *)
(* (*   with e -> *) *)
(* (*     close_in_noerr ic; *) *)
(* (*     raise e *) *)
(**)
(**)
(**)

(* Read entire file *)
(* ---------- Read file ---------- *)

(* ---------- Utilities ---------- *)

let pow10 n =
  let rec loop acc n =
    if n <= 0 then acc else loop (acc * 10) (n - 1)
  in
  loop 1 n

let repeat_block ~block ~block_digits ~times =
  (* Numerically build: block repeated 'times' times *)
  let base = pow10 block_digits in
  let acc = ref 0 in
  for _ = 1 to times do
    acc := (!acc * base) + block
  done;
  !acc

let read_file path =
  let ic = open_in path in
  let len = in_channel_length ic in
  let s = really_input_string ic len in
  close_in ic;
  s

(* ---------- Build setset (JS Set) ---------- *)

let digits_start = 12
let repeat_digits = 6

module IntHashSet = struct
  type t = (int, unit) Hashtbl.t
  let create n = Hashtbl.create n
  let add (h : t) (x : int) = Hashtbl.replace h x ()
  let iter (h : t) (f : int -> unit) = Hashtbl.iter (fun k () -> f k) h
end

let setset =
  let h = IntHashSet.create 2_000_000 in
  for digits = digits_start downto 2 do
    for k = repeat_digits downto 1 do
      (* JS:
         d = digits / k (float), segmentCount = floor(d)
         if fractional > 0.01 OR segmentCount==1 continue
         -> equivalent to: digits mod k = 0 AND segmentCount > 1
      *)
      if digits mod k = 0 then begin
        let segment_count = digits / k in
        if segment_count > 1 then begin
          let lo = pow10 (k - 1) in
          let hi = (pow10 k) - 1 in
          for block = lo to hi do
            let v = repeat_block ~block ~block_digits:k ~times:segment_count in
            IntHashSet.add h v
          done
        end
      end
    done
  done;
  h

(* ---------- Read ranges ---------- *)

let () =
  let day2_input = read_file "../day2/input1.txt" in
  let line =
    match String.split_on_char '\n' day2_input with
    | h :: _ -> String.trim h
    | [] -> failwith "Empty input file"
  in

  let ranges =
    line
    |> String.split_on_char ','
    |> List.map (fun part ->
         match String.split_on_char '-' part with
         | [a; b] -> (int_of_string a, int_of_string b)
         | _ -> failwith ("Invalid range: " ^ part)
       )
  in

  let summing = ref 0 in
  let output_set = IntHashSet.create 100_000 in

  (* Core logic: for i in setset, for (lo,hi) in ranges, if in range -> add & sum & print *)
  IntHashSet.iter setset (fun i ->
    List.iter (fun (lo, hi) ->
      if i >= lo && i <= hi then begin
        IntHashSet.add output_set i;
        summing := !summing + i;
        Printf.printf "%d [%d-%d]\n%!" i lo hi
      end
    ) ranges
  );

  Printf.printf "SUM = %d\n%!" !summing

