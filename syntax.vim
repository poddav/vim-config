" user syntax highlight definitions
" $Id: syntax.vim,v 1.13 2006/10/28 09:51:43 rnd Exp $

if !has('gui')
    " set color scheme for console vim
    " GUI colors are set into ~/.gvimrc
    if &background == 'dark'
	colorscheme rnd
    else
	colorscheme zellner
    endif
endif

let bash_is_sh=1
let is_bash=1
let c_syntax_for_h = 1
let perl_include_pod = 1
let perl_want_scope_in_variables = 1
"let perl_extended_vars = 1
let perl_highlight_matches = 1
let perl_fold = 1
let php_minlines = 300	" syntax sync threshold
"let asm_gnu_as_syntax = 1

" disable syntax errors within C++ lambdas definitions
let c_no_curly_error=1

" custom syntax
hi link Label			Special
hi link javaScript		Normal
hi link cStructure		Identifier
hi link cppStructure		Identifier
hi link perlUntilEOFstart	Special
hi link perlStringStartEnd	Special
