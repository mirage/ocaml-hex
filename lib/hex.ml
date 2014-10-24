(*
 * Copyright (c) 2013-2014 Thomas Gazagnaire <thomas@gazagnaire.org>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

type t = string

let invalid_arg fmt =
  Printf.ksprintf (fun str -> raise (Invalid_argument str)) fmt

let hexa = "0123456789abcdef"

let of_char c =
  let x = Char.code c in
  hexa.[x lsr 4], hexa.[x land 0xf]

let to_char x y =
  let code c = match c with
    | '0'..'9' -> Char.code c - 48 (* Char.code '0' *)
    | 'A'..'F' -> Char.code c - 55 (* Char.code 'A' + 10 *)
    | 'a'..'f' -> Char.code c - 87 (* Char.code 'a' + 10 *)
    | _ -> invalid_arg "Hex.of_char: %d is an invalid char" (Char.code c)
  in
  Char.chr (code x lsl 4 + code y)

let of_string ?(pretty=false) s =
  let n = String.length s in
  let buf = Buffer.create (n*2) in
  for i = 0 to n-1 do
    let x, y = of_char s.[i] in
    Buffer.add_char buf x;
    Buffer.add_char buf y;
    if pretty then
      if (i+1) mod 27 = 0 then Buffer.add_char buf '\n'
      else if i+1 <> n then Buffer.add_char buf ' '
  done;
  Buffer.contents buf

let can_skip = function
  | ' ' | '\t' | '\n' | '\r' | '-' -> true
  | _ -> false

let to_string s =
  if s = "" then ""
  else
    let n = String.length s in
    let buf = Buffer.create (1 + n/2) in
    let rec aux i j =
      if i >= n then ()
      else if can_skip s.[i] then aux (i+1) (i+2)
      else if j >= n then invalid_arg "Hex.to_string: invalid hex string"
      else if can_skip s.[j] then aux i (j+1)
      else (
        Buffer.add_char buf (to_char s.[i] s.[j]);
        aux (j+1) (j+2)
      )
    in
    aux 0 1;
    Buffer.contents buf
