import Lake
open Lake DSL

package «Collatz» where

@[default_target]
lean_lib «Collatz» where
  srcDir := "."
