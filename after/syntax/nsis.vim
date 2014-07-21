" Vim syntax file
" Language:	NSIS script, for version of NSIS 3.0+
" Maintainer:	poddav <poddav@gmail.com>
" Last Change:	2014 Jan 26

syn keyword nsisAttribute	RequestExecutionLevel Unicode

syn match nsisSysVar	    /$\\"/
syn match nsisPreCondit	    "!if\>"

" vim: ts=16
