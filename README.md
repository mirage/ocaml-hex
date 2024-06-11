### ocaml-hex -- a minimal library providing hexadecimal converters

[![Build Status](https://travis-ci.org/mirage/ocaml-hex.svg)](https://travis-ci.org/mirage/ocaml-hex)
[![docs](https://img.shields.io/badge/doc-online-blue.svg)](https://mirage.github.io/ocaml-hex/hex/Hex/index.html)

```ocaml
# #require "hex";;
# Hex.of_string "Hello world!";;
- : Hex.t = `Hex "48656c6c6f20776f726c6421"
# Hex.to_string (`Hex "deadbeef");;
- : string = "Þ­¾ï"
# Hex.hexdump (Hex.of_string "Hello world!\n")
00000000: 4865 6c6c 6f20 776f 726c 6421 0a         Hello world!.
- : unit = ()
```
