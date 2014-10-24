## ocaml-hex

Mininal library providing hexadecimal converters.

```
#require "hex";;
# Hex.of_string ~pretty:true "Hello world!";;
- : Hex.t = "48 65 6c 6c 6f 20 77 6f 72 6c 64 21"
# Hex.to_string "dead-beef";;
- : string = "ޭ��"
```