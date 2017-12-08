import times

var i = 0

proc lib_main_fn*() {.exportc.} =
  var t = getGmTime(getTime())
  echo "hello " & $i & "  " & $t
  i += 1
