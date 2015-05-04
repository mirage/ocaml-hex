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

val of_string: ?ignore:char list -> string -> t
(** [of_string s] is the hexadecimal representation of the binary
    string [s]. If [ignore] is set, skip the characters in the list when
    converting. Eg [of_string ~ignore:[' '] "a f"].
    The default value of [ignore] is [[]]) *)

val to_string: t -> string
(** [to_string h] is binary string corresponding to the hexadecimal
    encoding [h]. The decoding function will skip whitespaces, tabs
    and newlines. *)

(** {2 Cstruct} *)

val of_cstruct: ?ignore:char list -> Cstruct.t -> t
(** See [of_string] *)

val to_cstruct: t -> Cstruct.t
(** See [to_string] *)

(** {2 Debugging} *)

val hexdump: ?print_row_numbers:bool -> ?print_chars:bool -> t -> unit
(** [hexdump h] dumps the hex encoding to stdout in the following format:

    [{00000000: 6865 6c6c 6f20 776f 726c 6420 6865 6c6c  hello world hell
    00000010: 6f20 776f 726c 640a                      o world.}]

    This is the same format as emacs hexl-mode, and is a very similar format
    to hexdump -C. '\t' and '\n' are printed as '.'.in the char column.

    [print_row_numbers] and [print_chars] both default to [true]. Setting
    either to [false] does not print the column.
*)

val hexdump_s: ?print_row_numbers:bool -> ?print_chars:bool -> t -> string
(** Same as [hexdump] except returns a string. *)
