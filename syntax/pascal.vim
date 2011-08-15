" Vim syntax file
" Language:	Borland Pascal
" Maintainer:	rnd@softhome.net
" Last change:	2000 September 18

" Remove any old syntax stuff hanging around
syn clear

syn case ignore

syn keyword bpStatement	program unit begin end uses
syn keyword bpStatement	interface implementation nextgroup=bpMistype
syn match   bpMistype	contained +;+
syn keyword bpLabel	case goto
syn keyword bpConditional	if else then
syn keyword bpRepeat	do for while to until
syn keyword bpStatement	asm assembler far forward

syn region  bpTypeSection	matchgroup=bpStatement start=/\<type\>/ end=/\<\(var\|const\|begin\|procedure\|function\)\>/me=s-1 contains=bpComment,bpRecordSection,bpType
syn region  bpVarSection	matchgroup=bpStatement start=/\<var\>/ end=/\<\(type\|const\|begin\|procedure\|function\)\>/me=s-1 contains=bpComment,bpDeclarationLHS
syn region  bpConstSection	matchgroup=bpStatement start=/\<const\>/ end=/\<\(var\|type\|begin\|procedure\|function\)\>/me=s-1 contains=bpComment,bpNumber,bpString,bpNumber,bpByte

syn region  bpRecordSection	matchgroup=bpStatement start=/\<record\>/ end=/\<end\>/ contains=bpDeclarationLHS

syn keyword bpStatement	procedure function nextgroup=bpProcedure
syn match   bpProcedure	contained /\s*\<[A-Za-z][A-Za-z0-9_]*\>/ nextgroup=bpParameters
syn region  bpParameters	contained start=/(/ end=/)/ contains=bpComment,bpVarStatement,bpDeclarationLHS
syn keyword bpVarStatement	contained var

syn match   bpDeclarationLHS	contained /\<[A-Za-z][A-Za-z0-9_]*\>\s*/ nextgroup=bpDeclarationComma,bpDeclarationRHS
syn match   bpDeclarationComma	contained /,\s*/ nextgroup=bpDeclarationLHS
syn match   bpDeclarationRHS	contained /:\s*\<[A-Za-z][A-Za-z0-9_]*\>/hs=s+1

syn keyword bpTodo contained	TODO FIXME

" String
syn region  bpString	start=+'+  end=+'+
"syn match  bpIdentifier	"\<[a-zA-Z_][a-zA-Z0-9_]*\>"
"syn match  bpDelimiter	"[()]"

syn match  bpMatrixDelimiter	"[][]"

"if you prefer you can highlight the range
"syn match  bpMatrixDelimiter	"[\d\+\.\.\d\+]"

"syn match  bpNumber	"-\=\<\d\+\.\d\+[dD]-\=\d\+\>"
"syn match  bpNumber	"-\=\<\d\+\.\d\+[eE]-\=\d\+\>"
"syn match  bpNumber	"-\=\<\d\+\.\d\+\>"
syn match  bpNumber	"-\=\<\d\+\>"
syn match  bpByte	"\$[0-9a-fA-F]\+\>"

" If you don't like tabs
"syn match bpShowTab	"\t"
"syn match bpShowTabc	"\t"

syn region bpComment	start="(\*"  end="\*)" contains=bpTodo
syn region bpComment	start="{"  end="}" contains=bpTodo

syn keyword bpOperator	and array boolean div downto
syn keyword bpOperator	false file get in input insert
syn keyword bpOperator	interactive keyboard label maxint
syn keyword bpOperator	mod not of or output packed
syn keyword bpOperator	put repeat
syn keyword bpOperator	reset rewrite seek set
syn keyword bpOperator	with write writeln

syn keyword bpInternalProc	new dispose inc dec exit halt
syn keyword bpInternalProc	read readln write writeln ioresult
syn keyword bpInternalProc	paramcount paramstr lo hi
syn keyword bpInternalProc	ord chr val
syn keyword bpInternalProc	assign close reset rewrite eof
syn keyword bpInternalProc	getmem freemem

syn keyword bpSpecial	nil true false

syn keyword bpType	shortint integer longint byte word
syn keyword bpType	real single double extended comp
syn keyword bpType	char string boolean pointer text

syn sync lines=250

if !exists("did_bpascal_syntax_inits")
  let did_bpascal_syntax_inits = 1
  " The default methods for highlighting.  Can be overridden later
  hi link bpStatement	Statement
  hi link bpLabel	Label
  hi link bpConditional	Conditional
  hi link bpRepeat	Repeat
  hi link bpTodo		Todo
  hi link bpString	String
  hi link bpMatrixDelimiter	Identifier
  hi link bpNumber	Number
  hi link bpByte		Number
  hi link bpOperator	Operator
  hi link bpProcedure	Function
  hi link bpVarStatement	Statement
  hi link bpType		Type
  hi link bpComment	Comment
  hi link bpStatement	Statement
  hi link bpMistype	Error
  hi link bpDeclarationLHS	Identifier
  hi link bpDeclarationRHS	Type
  hi link bpSpecial	Special
  hi link bpInternalProc	Function

"optional highlighting
  "hi link bpDelimiter	Identifier
  "hi link bpShowTab	Error
  "hi link bpShowTabc	Error
  "hi link bpIdentifier	Identifier
endif

let b:current_syntax = "bpascal"

" vim: ts=17
