" Vim syntax file
" Language:	QuakeC
" Maintainer:	<rnd@chat.ru>
" $Id: quakec.vim,v 1.1 2006/10/28 10:13:26 rnd Exp $

" clear any unwanted syntax defs
syn clear

" shut case off
syn case match

syn keyword	quakeCStatement	if else while do return
syn keyword	quakeCType	void float string vector entity local
syn keyword	quakeCTodo	contained TODO FIXME XXX
syn match	quakeCNumber	/\<\d\+\(.\d\+\)\=\>/
syn match	quakeCFrame	/[$]\w\+\>/
" use uppercase identifiers as constants
syn match	quakeCConst	/\<[A-Z_]\{2}[A-Z0-9_]\+\>/
syn region	quakeCString	start=+"+ skip=+\\\\\|\\"+ end=+"+
syn region	quakeCVector	start=/'/ end=/'/
syn region	quakeCComment	start="/\*" end="\*/" contains=quakeCTodo
syn match	quakeCComment	"//.*" contains=quakeCTodo
syn match	cCommentError	"\*/"

"catch errors caused by wrong parenthesis
syn cluster	cParenGroup	contains=cParenError,cIncluded,quakeCTodo
syn region	cParen		transparent start='(' end=')' contains=ALLBUT,@cParenGroup
syn match	cParenError	")"
syn match	cInParen	contained "[{}]"

syn region	cPreCondit	start="^\s*#\s*\(if\>\|ifdef\>\|ifndef\>\|elif\>\|else\>\|endif\>\)" skip="\\$" end="$" contains=quakeCComment,quakeCString,cCommentError
syn region	cIncluded	contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match	cIncluded	contained "<[^>]*>"
syn match	cInclude	"^\s*#\s*include\>\s*["<]" contains=cIncluded
"syn match cLineSkip	"\\$"
syn cluster	cPreProcGroup	contains=cPreCondit,cIncluded,cInclude,cDefine,cInParen
syn region	cDefine		start="^\s*#\s*\(define\>\|undef\>\)" skip="\\$" end="$" contains=ALLBUT,@cPreProcGroup
syn region	cPreProc	start="^\s*#\s*\(pragma\>\|line\>\|warning\>\|warn\>\|error\>\)" skip="\\$" end="$" contains=ALLBUT,@cPreProcGroup

if !exists("did_quakec_syntax_inits")
    let did_quakec_syntax_inits = 1
    " The default methods for highlighting.  Can be overridden later
    hi link quakeCType		Type
    hi link quakeCStatement	Statement
    hi link quakeCNumber	Number
    hi link quakeCVector	Number
    hi link quakeCString	String
    hi link quakeCConst		PreProc
    hi link quakeCFrame		Special
    hi link quakeCComment	Comment
    hi link quakeCTodo		Todo
    hi link cCommentError	Error
    hi link cParenError		Error
    hi link cInParen		Error
    hi link cInclude		Include
    hi link cPreProc		PreProc
    hi link cDefine		Macro
    hi link cIncluded		String
endif

let b:current_syntax = "quakec"
