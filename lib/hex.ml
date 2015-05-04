(*
 * Copyright (c) 2015 Trevor Summers Smith <trevorsummerssmith@gmail.com>
 * Copyright (c) 2014 Thomas Gazagnaire <thomas@gazagnaire.org>
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

type t = [`Hex of string]

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
    | _ -> invalid_arg "Hex.to_char: %d is an invalid char" (Char.code c)
  in
  Char.chr (code x lsl 4 + code y)

let of_helper ?(ignore=[]) (next : int -> char) len =
  let buf = Buffer.create len in
  for i = 0 to len - 1 do
    let c = next i in
    if List.mem c ignore then ()
    else
      let x,y = of_char c in
      Buffer.add_char buf x;
      Buffer.add_char buf y;
  done;
  `Hex (Buffer.contents buf)

let of_string ?(ignore=[]) s =
  of_helper
    ~ignore:ignore
    (fun i -> s.[i])
    (String.length s)

let to_helper ~empty_return ~create ~set (`Hex s) =
  if s = "" then empty_return
  else
    let n = String.length s in
    let buf = create (n/2) in
    let rec aux i j =
      if i >= n then ()
      else if j >= n then invalid_arg "hex conversion: invalid hex string"
      else (
        set buf (i/2) (to_char s.[i] s.[j]);
        aux (j+1) (j+2)
      )
    in
    aux 0 1;
    buf

let to_string hex =
  to_helper
    ~empty_return:""
    ~create:(Bytes.create)
    ~set:(Bytes.set)
    hex

let of_cstruct ?(ignore=[]) cs =
  let open Cstruct in
  of_helper
    ~ignore:ignore
    (fun i -> Bigarray.Array1.get cs.buffer (cs.off+i))
    cs.len

(* Allocate just once for to_cstruct *)
let empty_cstruct = Cstruct.of_string ""

let to_cstruct hex =
  to_helper
    ~empty_return:empty_cstruct
    ~create:(Cstruct.create)
    ~set:(Cstruct.set_char)
    hex
