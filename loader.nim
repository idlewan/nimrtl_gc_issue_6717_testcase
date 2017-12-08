import dynlib

var libnames = [
  "./liblib1.so",
  "./liblib2.so"
]

type Fn = proc () {.nimcall.}

var lib: pointer
var lib_main: Fn

proc load(index: int) =
  echo "loading ", libnames[index]
  lib = loadLib(libnames[index])
  var p = lib.symAddr("lib_main_fn")
  if cast[int](p) == 0:
    quit "Error loading proc in .so"

  lib_main = cast[Fn](p)

load(0)

var i = 0
var cur_index = 0
while true:
  if i mod 5 == 0:
    lib.unloadLib()
    cur_index = (cur_index + 1) mod 2
    load(cur_index)
  lib_main()
  i += 1
