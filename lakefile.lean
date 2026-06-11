import Lake
open Lake DSL

package «collatz» where

@[default_target]
lean_lib «collatz» where
  srcDir := "."
