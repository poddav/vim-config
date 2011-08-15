" Language:	terminfo database entry
" Maintainer:	rnd <rnd@softhome.net>
" Last change:	August 6, 2000

syn clear
syn case match

syn match tiComment	/^#.*/
syn match tiTermDefinition	/^[-A-Za-z0-9]\+.*/ contains=tiTermName,tiTermLongname
syn match tiTermLongname	/|[^|]*,/hs=s+1,he=e-1 contained
syn match tiTermName	/[-A-Za-z0-9]\+/ contained
syn keyword tiStringCap	acsc bel blink bold civis clear cnorm cr csr
syn keyword tiStringCap	cub cub1 cud cud1 cuf cuf1 cup cuu cuu1 dch
syn keyword tiStringCap	dch1 dim dl dl1 ech ed el el1 enacs flash home
syn keyword tiStringCap	hpa ht hts ich ich1 il il1 ind invis is2 kb2
syn keyword tiStringCap	kbs kcbt kcub1 kcud1 kcuf1 kcuu1 kdch1
syn keyword tiStringCap	kbeg kend kfnd khome
syn match tiStringCap	/kf\([0-9]\|[1-5][0-9]\|6[0-3]\)\>/
syn keyword tiStringCap	kich1 kmous knp kpp kslt kspd nel op rc rev
syn keyword tiStringCap	ri rmacs rmcup rmir rmkx rmpch rmso rmul rs1
syn keyword tiStringCap	rs2 sc setab setaf sgr sgr0 smacs smcup smir
syn keyword tiStringCap	smkx smpch smso smul tbc u6 u7 u8 u9 vpa
syn keyword tiNumCap	cols lines colors it pairs
syn keyword tiBoolCap	am bce eo km mir msgr xenl xon
syn match tiUseCap	/use=/he=e-1 nextgroup=tiUseParam
syn match tiUseParam	contained /[^,]\+/
syn match tiStringDef	/=.\{-}[^\\],/ contains=tiEscape,tiParameter
"syn match tiEscape	/\\[0-7]\{3}\|\\E\|\^[A-Z]/ contained
syn match tiEscape	/\\[0-7]\{3}/ contained
syn match tiParameter	/%[idcl]\|%[pPg][1-9a-zA-Z]/ contained

if !exists("did_terminfo_syntax_inits")
    let did_terminfo_syntax_inits = 1

    hi link tiComment	Comment
    hi link tiTermName	Identifier
    hi link tiTermLongname	String
    hi link tiStringCap	Statement
    hi link tiNumCap	Number
    hi link tiBoolCap	Type
    hi link tiEscape	Special
    hi link tiParameter	Special
    hi link tiCancelCap	Type
    hi link tiUseCap	Include
    hi link tiUseParam	String
endif

let b:current_syntax = "terminfo"

" vim: ts=17
