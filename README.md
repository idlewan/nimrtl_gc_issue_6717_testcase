# nimrtl GC bug

When loading a dynamic library, executing its function (which allocates
memory), unloading the library, loading another dynamic library and executing
its function (which also allocates memory), and so on, the program is going to
crash with a SIGSEV.
The traceback points to GC functions.
```
Traceback (most recent call last)
loader.nim(30)           loader
loader.nim(14)           load
gc.nim(492)              newObjNoInit
gc_common.nim(360)       prepareDealloc
```
This is the same issue presented at [Nim#6717], extracted in a minimal test case
(and simpler to reproduce than with https://github.com/Serenitor/hotnim).

[Nim#6717]: https://github.com/nim-lang/Nim/pull/6717

## How to reproduce the issue

First compile `libnimrtl.so` and place it in this folder.
```bash
nim c --nimcache:nimcache_libnimrtl -o:./libnimrtl.so /path/to/Nimrepo/lib/nimrtl.nim
```

Then compile the library loader and the two libraries.
```bash
./compile.sh
```

Now run the loader, paying careful attention to modify the `LD_LIBRARY_PATH`.
```bash
LD_LIBRARY_PATH=`realpath ./` ./loader
```

The program should crash in a fraction of a second with Nim dev compiler as of
2017-12-08.
