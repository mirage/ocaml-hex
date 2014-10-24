(*
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

(** Hexadecimal encoding. *)

(** {2 Char} *)

val of_char: char -> char * char
(** [of_char c] is the the hexadecimal encoding of the character
    [c]. *)

val to_char: char -> char -> char
(** [to_char x y] is the character correspondong to the [xy]
    hexadecimal encoding. *)

(** {2 Strings} *)

type t = [`Hex of string]
(** The type of hexadecimal encodings. *)

val of_string: ?pretty:bool -> string -> t
(** [of_string s] is the hexadecimal representation of the binary
    string [s]. If [pretty] is set, the hexadecimal is formatted to 80
    columms with some space, to ease reading it. The default value of
    [pretty] is [false]) *)

val to_string: t -> string
(** [to_string h] is binary string corresponding to the hexadecimal
    encoding [h]. The decoding function will skip whitespaces, tabs
    and newlines. *)
