" Vim syntax file
" Language:	autoconf scripts: M4 with sh
" Maintainer:	rnd <rnd@softhome.net>
" Last Change:	Sat Mar 10 04:55:45 SAMT 2001
" $Id: config.vim,v 1.1 2006/10/28 10:13:26 rnd Exp $

if exists("b:current_syntax")
    finish
endif

syn match	acComment	"#.*"
syn region	acComment	matchgroup=acM4Keyword start="\<dnl\>" end="$"
"syn match	acError	+]+
"syn region	acM4String	matchgroup=acDelimiter start=+\[+ end=+\]+ contains=acM4String,acFunction,acM4Keyword,acM4Param
syn region	acString	matchgroup=acDelimiter start=+\[+ end=+\]+ oneline contains=acFunction,acShellVar
syn match	acDelimiter	"[();,]"
syn match	acOperator	"[=|&\*\+\<\>]"
syn keyword	acM4Keyword	define changequote ifelse
syn match	acShellVar	"\$\i\+"
syn match	acShellVar	"\${\i\+}"
syn match	acFunction	"\<A[CM]_[A-Z0-9_]*"
syn match	acNumber	"[-+]\=\<\d\+\(\.\d*\)\=\>"
syn keyword	acKeyword	if then else elif fi for in while do done
syn keyword	acKeyword	case esac
syn keyword	acShellCmd	sed cat rm eval echo test
syn region	acString	start=+"+ skip=+\\"+ end=+"+ contains=acShellVar
syn region	acString	start=+'+ end=+'+ contains=acFunction
syn region	acString	start=+`+ end=+`+ contains=acShellVar,acShellCmd
syn cluster	acAll	contains=acM4String,acFunction,acShellVar,acString,acComment,acOperator,acM4Keyword,acShellVar,acKeyword,acShellCmd

" The default highlighting.
hi def link acComment	Comment
hi def link acString	String
hi def link acDelimiter	Delimiter
hi def link acOperator	Operator
hi def link acFunction	Function
hi def link acNumber	Number
hi def link acKeyword	Keyword
hi def link acShellCmd	Keyword
hi def link acShellVar	Macro
hi def link acM4Keyword	Macro
hi def link acM4Param	Macro
hi def link acError	Error

let b:current_syntax = "config"

" vim: ts=16
