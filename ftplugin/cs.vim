" Autocommands for C# source files.
" Created: 2011 Aug 04
" Last change: 2014 Jul 21
" Copyright (c) 2011 **************** <poddav@gmail.com>

setlocal cinoptions=:0,(0,u0,W4,j1
setlocal nolist lcs=precedes:<,extends:>,tab:>-
let &textwidth = &columns - 10

setlocal foldmethod=syntax foldcolumn=2 foldtext=CSharpFoldText() 

fun! CSharpFoldText()
    let line = getline(v:foldstart)
    let text = substitute(line, '#region\s\+', '', '')
    let ts = &tabstop
    let tab = ""
    while ts > 0
	let tab .= v:folddashes[0]
	let ts -= 1
    endwhile
    let total = v:foldend - v:foldstart
    if total > 0
	let text .= printf(' (%d lines)', total)
    endif
    return substitute(text, "\t", tab, 'g')
endfun

" Key mappings

iab <buffer> /// /// <summary><CR><CR></summary><C-O>k

" swap operands of operator==
noremap <buffer> ,= :.s/\(.\{-}\)(\(.*\)\s\+==\s\+\(.*\))/\1(\3 == \2)/<CR>

noremap  <buffer> <silent> <HOME> :call MoveToFirstChar()<CR>
inoremap <buffer> <silent> <HOME> <C-\><C-O>:call MoveToFirstChar()<CR>
