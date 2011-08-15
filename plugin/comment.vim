" generic comment handling
" $Id: comment.vim,v 1.4 2006/10/28 10:01:41 rnd Exp $

let s:commentstart="#"
let s:commentend=""
let s:commentspace=0

function! CommentLine()
    call SaveRep()

    if exists("b:commentstart")
	let cs=b:commentstart
    else
	let cs=s:commentstart
    endif

    if exists("b:commentend")
	let ce=b:commentend
    else
	let ce=s:commentend
    endif

    if exists("b:commentspace")
	let space=b:commentspace
    else
	let space=s:commentspace
    endif

    if cs != "" && space | let cs=cs." " | endif
    if ce != "" && space | let ce=" ".ce | endif

    exe ".s/^.\\+$/".escape(cs,'/')."&".escape(ce,'/')."/e"
    call RestRep()
endf

function! UnCommentLine()
    call SaveRep()

    if exists("b:commentstart")
	let cs=b:commentstart
    else
	let cs=s:commentstart
    endif

    if exists("b:commentend")
	let ce=b:commentend
    else
	let ce=s:commentend
    endif

    exe ".s/\\(\\s*\\)".escape(cs,'/*.')."\\(.\\{-}\\)\\s*".escape(ce,'/*.')."\\s*$/\\1\\2/e"
"    exe ".s/\\(\\s*\\)".escape(cs,'/*.')." \\=\\(.\\{-}\\)\\s*".escape(ce,'/*.')."\\s*$/\\1\\2/e"
    call RestRep()
endf

command! -range Comm <line1>,<line2>call CommentLine()
command! -range Uncomm <line1>,<line2>call UnCommentLine()
