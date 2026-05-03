import Lake
open Lake DSL

package "collatz"

@[default_target]
lean_lib «Collatz_#1»

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.26.0"
