let () = Random.self_init ()

let random_string () =
  let s = String.create (Random.int 20483) in
  for i = 0 to String.length s - 1 do
    s.[i] <- Char.chr (Random.int 256)
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
  let h2 = Hex.of_string ~pretty:true s in
  check "pretty=false" s (Hex.to_string h1);
  check "pretty=true" s (Hex.to_string h2);
  incr success

let () =
  test "";
  test "dead-beef";
  for i = 0 to 100 do
    test (random_string ())
  done;
  Printf.printf "\027[32mSUCCESS!\027[m (%d/%d tests pass)\n" !success !success
