## ocaml-hex

Mininal library providing hexadecimal converters.

```ocaml
#require "hex";;
# Hex.of_string "Hello world!";;
- : Hex.t = "48656c6c6f20776f726c6421"
# Hex.to_string "dead-beef";;
- : string = "ޭ��"
```