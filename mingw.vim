" Vim settings for Mingw MSYS environment.
" Created: 2011 May 05
" Last change: 2014 Feb 25
" $Id$

let MSYS_DIR='C:/usr/msys/1.0'
let &shell=MSYS_DIR.'/bin/sh.exe'
let &shellpipe='2>&1| '.MSYS_DIR.'/bin/tee'
"let &grepprg=MSYS_DIR.'/bin/grep -n'
"set makeprg=mingw32-make\ -j2
set shellslash

language messages en
"language ctype Russian_Russia.1251
let $LC_ALL="C"
