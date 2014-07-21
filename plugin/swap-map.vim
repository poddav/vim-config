" Swap type mapping `qwerty' <-> `ÊÃÕËÅÎ'
" Copyright (c) 2003 Slavik Gorbanyov <rnd@web-drive.ru>
" $Id: swap-map.vim,v 1.1 2003/01/25 01:00:25 rnd Exp $

let s:lat="qwertyuiop[]asdfghjkl;'zxcvbnm,.QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>"
let s:rus='ÊÃÕËÅÎÇÛİÚÈßÆÙ×ÁĞÒÏÌÄÖÜÑŞÓÍÉÔØÂÀêãõëåîçûıúèÿæù÷áğòïìäöüñşóíéôøâà'

fun! s:SwapInsert()
    if strlen(@.) == 0
	return
    endif
    normal v`[
    call s:SwapMap()
    normal `]
endfun

fun! s:SwapVisual()
    call s:SwapMap()
endfun

fun! SwapLine()
    normal V
    call s:SwapMap()
endfun

fun! s:SwapMap()
    normal "ty
    let last_insert = @t
    let new_insert = s:MapTrans(last_insert)
    let @t = new_insert
    normal gv"tp
endfun

fun! s:MapTrans(string)
    let index = 0
    let new_string = ''
    while index < strlen(a:string)
	let chr = stridx(s:lat, a:string[index])
	if chr == -1
	    let chr = stridx(s:rus, a:string[index])
	    if chr != -1
		let new_string = new_string . s:lat[chr]
	    else
		let new_string = new_string . a:string[index]
	    endif
	else
	    let new_string = new_string . s:rus[chr]
	endif
	let index = index + 1
    endwhile
    return new_string
endfun

noremap <F4> :call <SID>SwapInsert()<CR>
vnoremap <F4> :call <SID>SwapVisual()<CR>
inoremap <F4> <C-O>:call <SID>SwapInsert()<CR>
