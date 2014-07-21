" Highlight word under cursor.
" Last change: 2012 Aug 04
" Copyright (c) 2011 **************** <poddav@gmail.com>
" $Id$

fun! s:Setup_Highlight()
    let color = s:Guess_Highlight()
    if !empty(color)
	exe 'hi PreviewKeyword guibg='.color
    else
	hi PreviewKeyword NONE
    endif
endfun

" Determine appropriate color for preview highlighting according to current
" color scheme.
" Returns: color value as string '#RRGGBB'
fun! s:Guess_Highlight()
    let normalbg = synIDattr(synIDtrans(hlID('Normal')),'bg#')
    let rgb = matchlist(normalbg, '^#\(\x\x\)\(\x\x\)\(\x\x\)')
    if empty(rgb)
	return ''
    endif

    " prevailing color
    let prevailing = 0
    if rgb[1] > rgb[2] && rgb[1] > rgb[3]
	let prevailing = 1
    elseif rgb[2] > rgb[1] && rgb[2] > rgb[3]
	let prevailing = 2
    elseif rgb[3] > rgb[1] && rgb[3] > rgb[2]
	let prevailing = 3
    endif

    for i in [1, 2, 3]
	let rgb[i] = str2nr(rgb[i], 16)
	if &background == 'dark'
	    let rgb[i] += 0x20
	    if i == prevailing
		let rgb[i] += 0x10
	    endif
	    if rgb[i] > 0xff
		let rgb[i] = 0xff
	    endif
	else
	    let rgb[i] -= 0x10
	    if rgb[i] < 0
		let rgb[i] = 0
	    endif
	endif
    endfor
    return printf('#%02x%02x%02x', rgb[1], rgb[2], rgb[3])
endfun

fun! s:Highlight_Keyword(keyword)
    " do not highlight regular keywords
    let synid = synIDtrans(synID(line('.'), col('.'), 0))
    if synid == hlID('Statement') || synid == hlID('Type') || synid == hlID('Identifier')
	match none
	return
    endif

    " character under cursor
    let c = getline('.')[col('.')-1]
    if c =~ '\w'
	exe 'match PreviewKeyword /\<'.escape(a:keyword,'.*[]/\').'\>/'
    else
	match none
    endif
endfun

call s:Setup_Highlight()

augroup HighlightKeyword
    au!
    au BufAdd			* call s:Setup_Highlight()
    au WinLeave			* match none
    au WinEnter,CursorMoved,CursorMovedI * call s:Highlight_Keyword(expand('<cword>'))
augroup END
