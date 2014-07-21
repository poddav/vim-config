" new files template plugin.
" Copyright (c) 2002 Slavik Gorbanyov <rnd@web-drive.ru>
" $Id: skel.vim,v 1.4 2006/11/29 00:33:38 rnd Exp $

if exists('g:skelDir')
    let s:skelDir = g:skelDir
else
    let s:skelDir = $VIMHOME.'/skel/'
endif

function ReadSkel(name) "{{{2
    let skelname = s:skelDir.a:name

    if !filereadable(expand(skelname))
	return
    endif
    call SaveRep()

    let fold_option = &foldenable
    set nofoldenable

    exe '0r' skelname
    $d _    " delete the last line
"    if has('folding')
"	%foldopen!
"    endif
    1	    " go to the first line

    let current_date = DateString('full')
    exe '%s/\*+date+\*/'.current_date.'/ge'

    let short_date = DateString('vim')
    exe '%s/\*+shortdate+\*/'.short_date.'/ge'

    exe '%s/\*+year+\*/'.strftime("%Y").'/ge'

    exe '%s/\*+author+\*/'.g:FullName.' <'.g:Email.'>/ge'

    let filename = expand("%:t")
    exe '%s/\*+filename+\*/'.filename.'/ge'
    let basename = expand("%:t:r")
    exe '%s/\*+basename+\*/'.basename.'/ge'

    let ext = expand('<afile>:e')
    if ext == 'h' || ext == 'hh' || ext == 'hpp'
	let headermacro = substitute(expand('<afile>:t'), '\.\|-', '_', 'g') " . -> _
	let headermacro = substitute(headermacro, '.*', '\U\0', '') " upcase
	exe '%s/\*+headmacro+\*/'.headermacro.'/ge'
    endif

"--- cursor postitioning
    silent! exe "normal 1G/\\*+cursor+\\*/s\<CR>\"_d/+\\*/e\<CR>"

    let &foldenable = fold_option

    call RestRep()
endfunction "}}}2

augroup skeleton "{{{2
    au!
    au BufNewFile *.vim		silent if expand('<afile>:p:h') =~ '/syntax'
	\				|   call ReadSkel('vim-syntax')
	\				| else
	\				|   call ReadSkel('vim')
	\				| endif
    au BufNewFile *.h		silent if exists('headers_are_cpp')
	\				|   call ReadSkel('hh')
	\				| else
	\				|   call ReadSkel('h')
	\				| endif
    au BufNewFile *.c		silent call ReadSkel('c')
    au BufNewFile *.cs		silent call ReadSkel('cs')
    au BufNewFile *.hh,*.hpp	silent call ReadSkel('hh')
    au BufNewFile *.cc,*.cpp,*.cxx,*.tcc	silent call ReadSkel('cc')
    au BufNewFile *.y,*.yy		silent call ReadSkel('yacc')
    au BufNewFile *.l,*.ll		silent call ReadSkel('lex')
    au BufNewFile *.html		silent call ReadSkel('html')
    au BufNewFile *.spec		silent call ReadSkel('spec')
    au BufNewFile *.pm		silent call ReadSkel('pm')
    au BufNewFile *.pl		silent call ReadSkel('perl')
"    au BufNewFile *		silent if filereadable(s:skelDir.&ft)
"				    \|   call ReadSkel(&ft)
"				    \| endif
augroup END "}}}2
