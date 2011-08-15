" intel x86 assembler syntax highlight tweaks
" Last change: 2007 May 16
" $Id$

syn keyword	asmRepeat	rep repe repz repne repnz
syn match	asmStringEsc	contained /\\./
syn region	asmString	start=+"+ end=+"+ contains=asmStringEsc

if exists('asm_gnu_as_syntax')
syn match	asmComment	/#.*/
syn match	asmHexNumber	/\<0x[0-9a-f]\+/
syn match	asmDirective	/\s\.\%(asci[iz]\|byte\|short\|int\|long\)\>/hs=s+2
syn match	asmDirective	/\s\.\%(text\|data\|section\|rdata\)\>/hs=s+2
syn match	asmDirective	/\s\.\%(equ\|comm\|lcomm\|globa\=l\)\>/hs=s+2
syn match	asmDirective	/\s\.\%(align\|p2align\)\>/hs=s+2
endif

hi link asmRepeat       Special
hi link asmStringEsc    Special
