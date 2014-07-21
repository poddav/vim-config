" Vim syntax file
" Language:	x86 Assembler (AT&T syntax)
" Maintainer:	rnd@DARKTOWER
" Created:	2006 Dec 28

syn clear

syn case ignore

syn keyword	asmType		byte word dword near far short para
syn keyword	asmDirective	org assume extrn public end include if endif
syn keyword	asmDirective	db dw dd ends
syn region	asmDeclaration	matchgroup=asmIdentifier start=/\<\w\+/ matchgroup=asmDirective end=/\<\(segment\|ends\|group\|struc\|union\|proc\|endp\|macro\|endm\|label\|equ\|db\|dw\|dd\)\>/ oneline
syn keyword	asmOperator	offset seg ptr dup
syn match	asmOperator	/\W$\W/hs=s+1,he=e-1
syn match	masmDirective	/\s\.\(model\|startup\|code\|data\|stack\|[234]86\)\>/hs=s+1
syn match	asmLabel	/\s@@[a-z0-9$_@?]\+/hs=s+1
syn match	asmLabel	/[a-z_@][a-z0-9$_@?]*:/he=e-1
syn match	asmRegister	/%\<e\=\([abcd]x\|[ds]i\|[bs]p\)\>/
syn match	asmRegister	/\<[abcd][hl]\>/
syn match	asmSegRegister	/\<[cdefgs]s\>/
syn match	asmDecNumber	/\<\d\+\>/
syn match	asmHexNumber	/\<[0-9][0-9a-f]*h\>/he=e-1
syn region	asmString	start=+'+ end=+'+
syn keyword	asmTodo		contained TODO FIXME
syn match	asmComment	/;.*/ contains=asmTodo

if !exists("did_asm_gnu_syntax_inits")
  let did_asm_gnu_syntax_inits = 1

  " The default methods for highlighting.  Can be overridden later
  hi link asmDecNumber	Number
  hi link asmHexNumber	Number
  hi link asmString	String
  hi link asmType	Type
  hi link asmLabel		PreProc
  hi link asmIdentifier		Identifier
  hi link asmComment		Comment
  hi link asmTodo		Todo
  hi link asmDirective		Statement
  hi link masmDirective		Statement
  hi link asmOperator		Special
  hi link asmRegister		Identifier
  hi link asmSegRegister	Identifier
endif

let b:current_syntax = "asmgnu"
