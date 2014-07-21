" Vim functions definitions
" Copyright (c) 2001 ****** ********* <***@************>
" $Id: defun.vim,v 1.2 2006/10/28 09:51:15 rnd Exp $

fun! MoveToFirstChar() "{{{
    let pos = col('.')
    normal ^
    if pos == col('.')
	normal 0
    endif
endfun "}}}

fun! DateString(kind) "{{{
    if a:kind ==? 'short'
	return strftime('%d/%m/%y')
    elseif a:kind ==? 'vim'
	return strftime('%Y %b %d')
    elseif a:kind ==? 'full'
	return strftime("%a %b %d %H:%M:%S %Y")
    else
	return strftime('%a %b %d %Y')
    endif
endfun "}}}

fun! SaveRep() "{{{
    let g:oldrep=&report | set report=9999
    let g:oldshm=&shortmess | set shortmess=sWAtaO
endfun

fun! RestRep()
    let &report=g:oldrep | unlet g:oldrep
    let &shortmess=g:oldshm | unlet g:oldshm
endfun "}}}

fun! SystemChop(cmd) "{{{
    " execute `cmd' as shell command and return its output as string

    let rc = system(a:cmd)
    let len = strlen(rc) - 1
    if char2nr(strpart(rc, len, 1)) == 10
	let rc = strpart(rc, 0, len)
    endif
    return rc
endfun "}}}

fun! SafeCursorPos(cmd) "{{{
    " execute ex `cmd' without moving cursor position

    let cursor_line = line('.')
    let cursor_column = col('.') - 1
    silent exe a:cmd
    exe cursor_line
    normal 0
    if cursor_column > 0
	exe 'normal' cursor_column.'l'
    endif
endfun "}}}

fun! GlobExe(glob, command) "{{{
    " apply ex `command' to files matched by `glob'

    let filelist = glob(a:glob)

    while strlen(filelist)
	let fileend = matchend(filelist, "[^\n]\\+\\(\n\\|$\\)")
	if fileend == -1
	    break
	endif
	let file = strpart(filelist, 0, fileend)
	let filelist = strpart(filelist, fileend)

	exe a:command 'file'
    endwhile
endfun "}}}

" BackupFile()
" Effects: create backup of the current file in form 'FILENAME;NUM'

fun! BackupFile() "{{{
    let filename = expand('%')
    let backup_list = split(glob(filename.';*'), '\n')
    let backup_num = 0
    for file in backup_list
	let m = matchlist(file, ';\(\d\+\)$')
	if !empty(m)
	    let num = str2nr(m[1])
	    if num > backup_num
		let backup_num = num
	    endif
	endif
    endfor
    let backup_num = backup_num + 1
    let backup_name = filename.';'.backup_num
"    call rename(filename, backup_name)
"    silent write
    let fl = readfile(filename, 'b')
    call writefile(fl, backup_name, 'b')
    let v:statusmsg = 'Created backup "'.expand(backup_name,':t').'", '.v:statusmsg
    echomsg v:statusmsg
endfun "}}}

command! Backup call BackupFile()
