" Language:	m4 macro processor
" Maintainer:	rnd <rnd@softhome.net>
" Last change:	$Date: 2006/10/28 10:13:26 $

syn clear
syn case match

syn match m4Comment	/#.*/ contains=sendmailTodo
syn region m4Comment	matchgroup=m4Statement start=/dnl/ end=/$/ oneline contains=sendmailTodo
syn keyword m4Statement	divert undivert define
syn keyword m4Include	include
syn region m4QuotedString	start=/`/ end=/'/ contains=m4QuotedString
syn keyword sendmailMacro	VERSIONID OSTYPE FEATURE MAILER
syn keyword sendmailMacro	LOCAL_RULE_3 MASQUERADE_AS
syn keyword sendmailTodo	contained TODO FIXME

if !exists("did_m4_syntax_inits")
    let did_m4_syntax_inits = 1

    hi link m4Comment	Comment
    hi link m4Statement	Statement
    hi link m4Include	Include
    hi link m4QuotedString	String
    hi link sendmailMacro	Function
    hi link sendmailTodo	Todo
endif

let b:current_syntax = "m4"

" vim: ts=17
