" Perl scripting specific settings
" $Id: perl.vim,v 1.7 2006/10/28 09:34:57 rnd Exp $

setlocal cindent com=b:# indk-=0# cink-=0# fo=crq
setlocal iskeyword=@,48-57,:,_,192-255
setlocal expandtab

let b:commentstart = '#'

if expand('%:e') == 'pm'
    let &l:makeprg='perl -cwT '.expand('%:t')
else
    let &l:makeprg='perl -cwTx '.expand('%:t')
endif

hi link podCommand	preProc

fun! s:InsertSeparator()
    let sep_len = 78
    let separator = repeat('#', sep_len)
    call append(line('.')-1, separator)
"    let pos = getpos('.')
"    let pos[1] -= 1
"    let pos[2] = strlen(b:commentstart)+5
"    call setpos('.', pos)
"    startreplace
endfun

map <silent> <buffer> ,- :call <SID>InsertSeparator()<CR>

" jump between subs
map <buffer> [[ ?{<CR>w99[{
map <buffer> <silent> ]] j0[[%:silent!/{<CR>
