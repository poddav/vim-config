" C source-specific settigns
" $Id: c.vim,v 1.14 2006/11/01 08:09:11 rnd Exp $

let $VSDIR = 'D:/Program\\ Files/Microsoft\\ Visual\\ Studio\\ 12.0/VC'
let WINSDKDIR = 'D:/Program\\ Files/Microsoft\\ SDKs/Windows/v7.1/Include'

setlocal formatoptions=crql cindent
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,:///,://
setlocal foldmethod=marker
setlocal suffixesadd=.h,.hpp
setlocal expandtab

" indenting options:
" zero shift for func types, case labels and c++ class scope declarations,
" line up with open parentheses.
setlocal cinoptions=t0,:0,g0,(0,u0,W4,j1

setlocal iskeyword=@,48-57,_,192-255
if has('gui')
    setlocal textwidth=90
endif

if &ft == 'cpp'
    let b:commentstart = "//"
    let b:commentend = ""
    let &l:path = '.,'.$VSDIR.'/include,'.WINSDKDIR.',,'
    setlocal matchpairs+=<:>
else
    let b:commentstart = "/*"
    let b:commentend = "*/"
endif

" --- abbreviations and keybindings {{{1--------------------------------------

ab <buffer> #i #include
ab <buffer> #d #define

" swap operands of operator==
noremap <buffer> ,= :.s/\(.\{-}\)(\(.*\)\s\+==\s\+\(.*\))/\1(\3 == \2)/<CR>

" move to first non-whitespace character
noremap  <buffer> <silent> <HOME> :call MoveToFirstChar()<CR>
inoremap <buffer> <silent> <HOME> <C-\><C-O>:call MoveToFirstChar()<CR>

" mark GNU gettext translation
noremap <buffer> ,t mtF"i_(<ESC>2f"a)<ESC>g`t
noremap <buffer> ,T mtF"iN_(<ESC>2f"a)<ESC>g`t

fun! s:InsertSeparator()
    let commentend = b:commentend
    if strlen(commentend)
	let commentend = ' '.commentend
    endif
    let sep_len = 78 - strlen(b:commentstart.commentend)-1
    let separator = b:commentstart.' '.repeat('-', sep_len). commentend
    call append(line('.')-1, separator)
    let pos = getpos('.')
    let pos[1] -= 1
    let pos[2] = strlen(b:commentstart)+5
    call setpos('.', pos)
    startreplace
endfun

map <silent> <buffer> ,- :call <SID>InsertSeparator()<CR>
map <silent> <buffer> gh :exe 'find' expand("%:t:r")<CR>

" --- Tweak Vim options according to file path {{{1---------------------------

let path=expand("%:p:h")

if ! filereadable(path."/Makefile") && ! filereadable(path."/makefile")
    let &l:makeprg=&g:makeprg.' '.expand("%:t:r")
else
    let &l:makeprg=&g:makeprg
endif

fun! s:SourceRecursive(path, root_len)
    let parentdir = substitute(a:path, '^\(.*\)/.*', '\1', '')
    if strlen(parentdir) >= a:root_len
	call s:SourceRecursive(parentdir, a:root_len)
    endif
    if filereadable(a:path.'/.vimrc')
	sandbox exe 'source' a:path.'/.vimrc'
    endif
endfun

" this is way too dangerous
"if path =~ '^'.escape($HOME.'/src', '.').'\(/\|$\)'
"    call s:SourceRecursive(path, strlen($HOME.'/src'))
"endif

if path =~# 'qw262\|fuhquake\|QW'
    setlocal ts=4
endif

unlet path

" --- Preview tag under cursor {{{1-------------------------------------------

"au! CursorHold *.cc nested call PreviewWord()

func! PreviewWord()
    if &previewwindow		" don't do this in the preview window
      	return
    endif
    let word = expand("<cword>") " get the word under cursor
    if word !~ '\a'		" if the word contains a letter
	return
    endif

    " Delete any existing highlight before showing another tag
    silent! wincmd P		" jump to preview window
    if &previewwindow		" if we really get there...
	match none		" delete existing highlight
	wincmd p		" back to old window
    endif

    " Try displaying a matching tag for the word under the cursor
    try
	exe 'ptag' word
    catch
	return
    endtry

    silent! wincmd P		" jump to preview window
    if &previewwindow		" if we really get there...
	if has("folding")
	    silent! .foldopen	" don't want a closed fold
	endif
	call search("$", "b")	" to end of previous line
	let word = substitute(word, '\\', '\\\\', "")
	call search('\<\V' . word . '\>')	" position cursor on match
	" Add a match highlight to the word at this position
	hi previewWord term=bold ctermbg=green guibg=green
	exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
	wincmd p		" back to old window
    endif
endfun

" --- Help subsystem {{{1-----------------------------------------------------

let s:win_help_path='C:/Text/Programming/b5ms/win32.hlp'
let s:gl_help_path='C:/Text/Programming/b5ms/opengl.hlp'
let s:stl_help_path='C:/Text/Programming/C++/STL_doc'
let s:boost_help_path='C:/usr/boost_1_46_1/libs/index.html'
let s:boost_lookup='boost-lookup'

fun! CLookupHelp(word)
    let word = a:word
    if a:word =~ '^::'
	let word = strpart(a:word, 2)
    elseif a:word =~ '^std::'
	let word = strpart(a:word, 5)
    endif
    if !strlen(word)
	return 0
    endif
    if $OS == 'Windows_NT' "&& filereadable(s:win_help_path)
	if word =~# '^\%([A-Z][a-z]\+\)\+[AW]\=$'
	    if word =~# '[AW]$'
		let word = word[:-2]
	    endif
	    return WinHelp(word, s:win_help_path)
	elseif word =~# '^glu\=\%([A-Z][a-z0-9]\+\)\+$'
	    return WinHelp(word, s:gl_help_path)
	elseif word =~# '^WM_[A-Z_]\+'
	    return WinHelp(word, s:win_help_path)
	endif
    endif
    if &ft == 'cpp' && exists('g:start_browser')
	if filereadable(s:stl_help_path.'/'.word.'.html')
	    return OpenURL('file:///'.s:stl_help_path.'/'.word.'.html')
	endif

	" check for boost:: keyword
	"
	let save_isk = &isk
	set isk+=:
	let WORD = expand('<cword>')
	let &isk = save_isk
	let boost = matchlist(WORD, '^boost::\(.*\)')
	if !empty(boost)
"	    let url = SystemChop(s:boost_lookup.' '.boost[1])
"	    if v:shell_error || !strlen(url)
"		let url = s:boost_help_path
"	    endif
"	    return OpenURL(url)
	    return LookupInternet(WORD, 1)
	endif
    endif
    if !Man('2:3', word)
	return LookupInternet(word,1)
    endif
    return 1
endfun

if exists('b:context_help_fun') " Vim 7.2 workaround (E705)
    unlet b:context_help_fun
endif
let b:context_help_fun = function('CLookupHelp')

" }}}1
" vim: fdm=marker
