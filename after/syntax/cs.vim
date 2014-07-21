" C# syntax tweaks
" Last Change:	2011 Aug 21
" $Id$

syn keyword	csType			var Object String IntPtr
syn keyword	csType			Int32 UInt32
syn keyword	csType			List IList IEnumerable Dictionary HashSet Stack
syn keyword	csFunction		IsNullOrEmpty
syn keyword	csUnspecifiedStatement	set get from join where orderby select into default
syn keyword	csStorage		event
syn clear	csOperatorError
syn region	csSquareBrackets	start='\[' end='\]' contains=csAttribute,csAttributeEx,csString,csConstant,csNumber,csType,csUnspecifiedStatement
syn keyword	csAttribute		contained DllImport Flags StructLayout MarshalAs
syn keyword	csAttributeEx		contained EntryPoint CharSet SetLastError
syn region	csPreProc		start="^\s*\(%:\|#\)\s*\(pragma\>\|line\>\|warning\>\|warn\>\|error\>\)" skip="\\$" end="$" keepend
syn match	csNumber		/\<\(0x[0-9a-fA-F]\+\|[0-9]\+\)[uUlL]/he=e-1
syn match	csSpecialChar		contained /\\x[[:xdigit:]]\+/

hi link csModifier	Identifier
hi link csFuntion	Function
hi link csAttribute	Special
hi link csAttributeEx	Identifier
hi link csXmlTag	NonText
hi link csStorage	Identifier
hi link csPreProc	PreProc
