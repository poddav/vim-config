" Perl scripting specific settings
" $Id: perl.vim,v 1.7 2006/10/28 09:34:57 rnd Exp $

setlocal cindent com=b:# indk-=0# cink-=0# fo=crq
setlocal iskeyword=@,48-57,:,_,192-255
setlocal expandtab
setlocal foldlevelstart=99
if exists('perl_fold')
    unlet perl_fold
endif

let b:commentstart = '#'
let &l:makeprg='perl -cwT '.expand('%:t')

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

" move to first non-whitespace character
noremap  <buffer> <silent> <HOME> :call MoveToFirstChar()<CR>
inoremap <buffer> <silent> <HOME> <C-\><C-O>:call MoveToFirstChar()<CR>
