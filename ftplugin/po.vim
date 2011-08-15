" PO mode for Vim.
" $Id: po.vim,v 1.2 2006/11/29 00:31:56 rnd Exp $

let s:pofile = expand('%')

augroup po
    exe 'au! BufWritePre' s:pofile
    exe 'au  BufWritePre' s:pofile 'call SafeCursorPos("call PoUpdateRevisionDate()")'
augroup END

map <buffer> ]] /^msgstr ""\n\n<CR>
map <buffer> [[ ?^msgstr ""\n\n<CR>

if exists('po_mode_initialized')
    finish
endif

fun! PoUpdateRevisionDate()
    1
    let current_line = search('^msgid ""$', 'W') 
    if current_line == 0
	return
    endif
    while 1
	let current_line = current_line + 1
	let test_string = getline(current_line)
	if test_string =~ '^\s*$'
	    return
	endif
	if test_string =~ '^"PO-Revision-Date: .*\\n"'
	    if has('win32')
		" MSVCRT strftime %z doesnt match unix %z
		let current_date = strftime("%Y-%m-%d %H:%M+0400")
	    else
		let current_date = strftime("%Y-%m-%d %H:%M%z")
	    endif
	    call setline(current_line, '"PO-Revision-Date: '.current_date.'\n"')
	    return
	endif
    endwhile
endfun

let po_mode_initialized = 1
