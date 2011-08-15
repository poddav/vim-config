" Vim settings for Cygwin environment.
" $Id: cygwin.vim,v 1.1 2006/10/28 09:51:05 rnd Exp $

set shellslash
set shell=C:/Cygwin/bin/sh.exe
set shellpipe=2>&1\|\ tee
set grepprg=grep\ -n

language messages en
language time C
"language ctype Russian_Russia.1251
let $LC_ALL="C"
