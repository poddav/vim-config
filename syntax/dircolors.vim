" Language:	color ls definitions
" Maintainer:	rnd <rnd@softhome.net>
" Last change:	2006 Oct 28 12:56

syn clear
syn case match

syn match dircComment	/#.*/
syn keyword dircDirective	COLOR OPTIONS TERM
syn keyword dircFileSpec	NORMAL FILE DIR LINK FIFO SOCK BLK contained
syn keyword dircFileSpec	CHR ORPHAN EXEC contained
syn match dircSpecBrown	/\s\(00\=;\)\=33\>/ms=s+1 contained
syn match dircSpecCyan	/\s\(00\=;\)\=36\>/ms=s+1 contained
syn match dircSpecBrightRed	/0\=1;31/ contained
syn match dircSpecBrightGreen	/0\=1;32/ contained
syn match dircSpecBrightMagenta	/0\=1;35/ contained
syn match dircSpecBrightCyan	/0\=1;36/ contained
syn match dircSpecWhite	/0\=1;37/ contained
syn match dircDefinition	/[a-zA-Z0-9.]\+\s\+[0-9;]\+/ contains=dircSpec.*,dircFileSpec,dircExtSpec

if !exists("did_dircolors_syntax_inits")
    let did_dircolors_syntax_inits = 1

    hi link dircComment	Comment
    hi link dircDirective	Statement
    hi link dircFileSpec	Statement
    hi dircSpecBrown	ctermfg=Brown
    hi dircSpecCyan	ctermfg=Cyan
    hi dircSpecBrightGreen	ctermfg=LightGreen
    hi dircSpecBrightRed	ctermfg=LightRed
    hi dircSpecBrightMagenta	ctermfg=LightMagenta
    hi dircSpecBrightCyan	ctermfg=LightCyan
    hi dircSpecWhite	ctermfg=White
endif

let b:current_syntax = "dircolors"

" vim: ts=17
