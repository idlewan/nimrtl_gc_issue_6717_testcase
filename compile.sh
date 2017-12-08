#!/usr/bin/bash
nim c -d:useNimRtl loader.nim
nim c -d:useNimRtl --app:lib lib1.nim
nim c -d:useNimRtl --app:lib lib2.nim
