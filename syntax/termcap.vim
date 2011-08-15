" Language:	termcap database
" Maintainer:	rnd <rnd@softhome.net>
" Last change:	August 6, 2000

syn clear
syn case match

syn match tcComment	/^#.*/
syn match tcTermDefinition	/^[-a-z0-9]\+[^:]*:/me=e-1 contains=tcTermName,tcTermLongname
syn match tcTermLongname	/|[^|:]*:/hs=s+1,me=e-1 contained
syn match tcTermName	/[-a-z0-9]\+/ contained
syn match tcBoolCap	/:..:/ms=s+1,me=e-1
syn match tcNumCap	/:..#[0-9]\+:/ms=s+1,me=e-1,he=s+3
syn match tcStringCap	/:..=.\{-}:/ms=s+1,me=e-1,he=s+3 contains=tcEscape,tcParameter
syn match tcImportEntry	/:tc=[^:]\+:/ms=s+1,me=e-1,he=s+3 contains=tcImportTermName
syn match tcImportTermName	/=[^:]\+:/ms=s+1,me=e-1 contained
syn match tcCancelCap	/:..@:/ms=s+1,me=e-1,he=s+3
"syn match tcEscape	/\\[0-7]\{3}\|\\E\|\^[A-Z]/ contained
syn match tcEscape	/\\[0-7]\{3}/ contained
syn match tcParameter	/%[id]/ contained

if !exists("did_termcap_syntax_inits")
    let did_termcap_syntax_inits = 1

    hi link tcComment	Comment
    hi link tcTermName	Identifier
    hi link tcTermLongname	String
    hi link tcStringCap	Statement
    hi link tcNumCap	Number
    hi link tcBoolCap	Type
    hi link tcEscape	Special
    hi link tcParameter	Special
    hi link tcImportEntry	Include
    hi link tcImportTermName	String
    hi link tcCancelCap	Type
endif

let b:current_syntax = "termcap"

" vim: ts=17
