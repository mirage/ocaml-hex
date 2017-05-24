open Crowbar

module H = Hex

let pp_hex ppf t =
  pp ppf "%s" (H.to_string t)

let () =
  (add_test ~name:"hex" [bytes] @@ fun (s:bytes) ->
    check_eq (Hex.of_string s |> Hex.to_string) s);
  (add_test ~name:"cstruct" [bytes] @@ fun (s:bytes) ->
    check_eq (Cstruct.of_string s |> Hex.of_cstruct |> Hex.to_string) s);
  ()
