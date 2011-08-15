" Vim settings for Mingw MSYS environment.
" Created: 2011 May 05
" Last change: 2011 Aug 15
" $Id$

let MSYS_DIR='C:/usr/msys/1.0'
let &shell=MSYS_DIR.'/bin/sh.exe'
let &shellpipe='2>&1| '.MSYS_DIR.'/bin/tee'
let &grepprg=MSYS_DIR.'/bin/grep -n'
set makeprg=mingw32-make\ -j2
set shellslash
let $PATH=$PATH.';D:/Program Files/Microsoft Visual Studio 10.0/VC/bin'

language messages en
language time C
"language ctype Russian_Russia.1251
let $LC_ALL="C"
