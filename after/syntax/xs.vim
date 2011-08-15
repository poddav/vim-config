" extension of the XS syntax distributed with Vim.
" Last change: 2001 Dec 17
" $Id: xs.vim,v 1.2 2006/10/28 10:20:26 rnd Exp $

syn match xsComment	/^#.*/ contains=cDefine,cInclude,cPreCondit,cPreProc
syn keyword xsType	SV AV HV GV CV MAGIC STRLEN
syn keyword xsMacro	ST

hi def link xsComment   Comment
hi def link xsType      Type
