" Vim syntax file
" Language:	Configuration File (ini file) for Quake 3 Arena
" Maintainer:	<rnd@chat.ru>
" $Id: q3cfg.vim,v 1.1 2006/10/28 10:13:26 rnd Exp $

" clear any unwanted syntax defs
syn clear
syn case ignore

syn keyword	q3Todo	contained TODO FIXME
syn match	q3Comment	"//.*$" contains=q3Todo
syn keyword	q3Command	unbindall
syn keyword	q3Command	set seta setu
syn keyword	q3Command	wait screenshot messagemode vote pause
syn keyword	q3Command	centerview weapon weapprev weapnext weapongrabbed
syn keyword	q3Command	sizeup sizedown togglemenu toggleconsole
syn region	q3Binding	matchgroup=q3Command start=/\<bind\s\+/ end=/\s/ oneline
syn match	q3Action	"[+\-]\h\w*"
syn keyword	q3Cvar	sensitivity freelook
syn keyword	q3Cvar	timelimit fraglimit capturelimit dmflags snaps
syn keyword	q3Cvar	name model color sex handicap rate
syn match	q3Cvar	"\<\(m\|cg\|cl\|g\|r\|s\|com\|sv\|ui\|in\|vm\|net\|vid\|cm\)_\w\+"

"if !exists("did_q3a_syntax_inits")
    let did_q3a_syntax_inits = 1
    " The default methods for highlighting.  Can be overridden later
    hi link q3Comment	Comment
    hi link q3Todo	Todo
    hi link q3Command	Statement
    hi link q3Binding	Special
    hi link q3Action	Type
    hi link q3Cvar	Identifier
"endif

let b:current_syntax = "q3cfg"

" vim: ts=17
