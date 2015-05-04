let () = Random.self_init ()

let random_string () =
  let s = Bytes.create (Random.int 20483) in
  for i = 0 to String.length s - 1 do
    Bytes.set s i (Char.chr (Random.int 256))
  done;
  s

let check msg x y =
  if x = y then ()
  else (
    Printf.eprintf "\n---\n%S\n---\n%S\n%s: \027[31mERROR!\027[m\n" x y msg;
    exit 1
  )

let success = ref 0

let test s =
  let h1 = Hex.of_string s in
  check "to/from string" s (Hex.to_string h1);
  incr success

let test_cs s =
  let cs = Cstruct.of_string s in
  let `Hex s = Hex.of_cstruct cs in
  let `Hex s' = (Hex.of_string (Cstruct.to_string cs)) in
  check "of_cstruct = of_string" s s';
  incr success

let test_suite test =
  test "";
  test "deadbeef";
  for i = 0 to 100 do
    test (random_string ())
  done

let test_cs_array () =
  let open Bigarray in
  let arr = Array1.of_array char c_layout
      [|'0'; '1'; '2'; '3'; '4'; '5';
        '6'; '7'; '8'; '9'; 'a'; 'b';
        'c'; 'd'; 'e'; 'f'|] in
  let cs = Cstruct.of_bigarray arr in
  let hex = Hex.of_cstruct cs in
  let s = Hex.to_string hex in
  check "cstruct array" s "0123456789abcdef";
  incr success

let test_ignore () =
  let s = "...   aJjf...c 1" in
  let h = Hex.of_string ~ignore:[' '; '.'; 'j'; 'J'] s in
  check "string ignore" "afc1" (Hex.to_string h);
  let cs = Cstruct.of_string s in
  let h = Hex.of_cstruct ~ignore:[' '; '.'; 'j'; 'J'] cs in
  check "cstruct ignore" "afc1" (Cstruct.to_string (Hex.to_cstruct h));
  incr success

let () =
  test_suite test;
  test_suite test_cs;
  test_cs_array ();
  test_ignore ();
  Printf.printf "\027[32mSUCCESS!\027[m (%d/%d tests pass)\n" !success !success
