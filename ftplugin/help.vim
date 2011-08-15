" Vim internal help autocommands
" Copyright (c) 2001 rnd <rnd@softhome.net>
" $Id: help.vim,v 1.3 2006/10/28 09:33:57 rnd Exp $

map <buffer> q		:bdel<CR>
map <buffer> <TAB>	/\([\|']\)[^\|']\+\1<CR>
map <buffer> <CR>	<C-]>
map <buffer> <BS>	<C-T>
