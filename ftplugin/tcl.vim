" Tcl scripting settings
" Created: 2013 Feb 20
" Copyright (c) 2013 **************** <poddav@gmail.com>
" $Id$

let b:commentstart = '#'

fun! s:InsertSeparator()
    let sep_len = 78
    let separator = repeat('#', sep_len)
    call append(line('.')-1, separator)
endfun

map <silent> <buffer> ,- :call <SID>InsertSeparator()<CR>
