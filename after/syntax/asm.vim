" GNU assembler syntax highlight tweaks
" Last change: 2007 Jan 14
" $Id$

syn match	asmComment	/#.*/
syn region	asmComment	start=,/\*, end=,\*/,
syn match	asmRegister	/\<e\=\([abcd]x\|[ds]i\|[bs]p\)\>/
syn match	asmRegister	/\<[abcd][hl]\>/
syn match	asmSegRegister	/\<[cdefgs]s\>/
syn match	asmLabel	/[A-Za-z_@][A-Za-z0-9$_@?]*:/he=e-1
syn match	asmDirective	"\.[a-z][a-z_0-9]\+"

hi link asmIdentifier	Normal
hi link asmRegister	Identifier
hi link asmSegRegister	Identifier
hi link asmLabel	PreProc
