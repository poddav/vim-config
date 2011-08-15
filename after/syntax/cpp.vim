" c++ syntax tweaks
" Last change: 2011 Aug 13
" $Id: cpp.vim,v 1.5 2006/10/30 15:59:30 rnd Exp $

" STL types
syn keyword	cType		vector string wstring deque pair
syn keyword	cType		stringstream istringstream ostringstream
syn keyword	cType		wstringstream wistringstream wostringstream
syn keyword	cType		wfstream wifstream wofstream
syn keyword	cType		unique_ptr shared_ptr
syn keyword	cType		streamoff streamsize
syn match	cType		/::\(const_\)\=iterator\>/hs=s+2
syn match	cType		/::[a-z]\+_type\>/hs=s+2
syn keyword	cType		CComPtr CComBSTR
syn keyword	cFunction	getline make_pair
syn keyword	cFunction	for_each find find_if count count_if search
syn keyword	cFunction	copy swap transform replace fill sort

syn keyword	cppIdentifier	boost
syn keyword	cppIdentifier	cin cout cerr clog wcout wcerr wclog wcin
syn keyword	cppStdSpecial	dec hex oct setw setprecision left internal right endl ends
				\ contained
syn keyword	cppStdSpecial	setfill uppercase fixed showpos noshowpos skipws ws
				\ showbase noshowbase contained
syn match	cppStdIdent	/\<[io]\=\%(f\|string\)\=stream\>/ contained
syn keyword	cppStdIdent	exception runtime_error logic_error length_error contained
syn keyword	cppStdIdent	list set map multiset multimap contained
syn match	cppStdNamespace	/\<std::/he=e-2 nextgroup=cppStdIdent,cppStdSpecial skipwhite
syn match	cppIosBase	/\<ios\%(_base\)\=::/he=e-2 nextgroup=cppIosConst skipwhite
syn keyword	cppIosConst	in out app ate trunc binary goodbit badbit failbit eofbit
				\ floatfield scientific fixed adjustfield basefield
				\ beg cur end contained
syn cluster	cParenGroup	add=cppIosConst,cppStdIdent
syn clear	cppOperator
"syn match	cppOperator	/\<operator\s*\%(<<\)\=/he=s+8
syn match	cppOperator	/\<operator\%(\s*\W\|\s\+\i\)\@=/he=s+8
syn keyword	cppOperator	typeid
syn keyword	cppOperator	and bitor or xor compl bitand and_eq or_eq xor_eq not not_eq
"syn region	cppOutput	matchgroup=cppShiftOp start=/<</ end=/<<\|[;{}]/me=s-1 contains=cParenGroup,cCppString,cCharacter,cSpecialCharacter,cppStdNamespace

" C++/CLR extensions
syn keyword	cIdentifier	ref property
syn keyword	cIdentifier	Console System Exception
syn keyword	cStatement	gcnew
syn keyword	cConstant	nullptr
syn keyword	cType		pin_ptr String
syn keyword	cFunction	Write WriteLine
syn match	cInclude	display "^\s*\(%:\|#\)\s*using\>\s*["<]" contains=cIncluded

hi cppShiftOp		guifg=gray50
hi link cppIdentifier	Identifier
hi link cppIosConst	Special
hi link cppIosBase	Type
hi link cppStdNamespace	Identifier
hi link cppStdIdent	Type
hi link cppStdSpecial	Special
hi link cppFuntion	Function

" vim: wrap
