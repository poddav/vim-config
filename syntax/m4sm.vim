" Language:	sendmail m4 configuration
" Maintainer:	rnd <rnd@softhome.net>
" Last change:	Wed Dec 27 01:03:16 SAMT 2000

syn clear
so $VIMRUNTIME/syntax/m4.vim

syn match sendmailComment	/#.*/ contains=sendmailTodo
syn region m4Comment		start=/dnl\>/ end=/$/ oneline contains=sendmailTodo
syn region sendmailMacroParm	matchgroup=sendmailMacro start=/\<[_A-Z0-9]\+(/ end=/)/ contains=m4String
syn keyword sendmailMacro	LOCAL_RULE_0 LOCAL_RULE_3 LOCAL_CONFIG
syn keyword sendmailMacro	LOCAL_RULESETS
syn keyword sendmailTodo	contained TODO FIXME NOTE XXX

"if !exists("did_m4sm_syntax_inits")
"    let did_m4sm_syntax_inits = 1
    hi link sendmailComment	Comment
    hi link sendmailMacro	Type
    hi link sendmailTodo	Todo
"endif

let b:current_syntax = "m4sm"

" vim: ts=17
