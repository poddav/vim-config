" CVS interface for Vim
" Copyright (c) 2001 rnd <rnd@softhome.net>
" $Id: cvs.vim,v 1.19 2006/11/29 00:33:10 rnd Exp $

if exists("loaded_cvs")
    finish
endif
let loaded_cvs = 1

command! Cin	call CVSCheckIn()
command! Cout	call CVSCheckOut()
" diff against last version or specified revision
command! -nargs=* Cdiff		call CVSDiff(<f-args>)
command! Cstat	call CVSStatus()
command! Cadd	call CVSAdd()
command! Clog	call CVSLog()
command! Diff	call DiffBuffers()
command! Cup	call CVSUpdate()
"command! Rcslog	exe '0r!rcs2log -u "rnd	'.FullName.'	'.Email.'"'
command! Rcslog	exe "0r!cvs2cl.pl -P -U $CVSROOT/CVSROOT/users --stdout --fsf --accum 2> /dev/null"

fun! CVSCheckIn()
    let filename = expand('%:t')
    let dir = expand('%:p:h')
    call CVSDiff()
    let diff_buffnr = v:shell_error > 1 ? 0 : bufnr('%')
    if winheight(0) < 5
	resize 5
    endif
    let logname = escape(fnamemodify(fnamemodify(resolve(tempname()),':~'),':p'),' ')
"    let logname = resolve(tempname())
    exe '5new' logname
    setlocal modifiable noro
    exe 'au BufUnload' logname 'nested call s:CVSCommitChanges("'.dir.'","'.filename.'",'.diff_buffnr.')'
    set tw=0
    append

CVS: ----------------------------------------------------------------------
CVS: Enter Log.  Lines beginning with `CVS:' are removed automatically
CVS: ----------------------------------------------------------------------
.
    1
    normal 0
    set ft=cvs
    startinsert
endfun

fun! s:CVSCommitChanges(dir, filename, diff_buffnr)
    let logname = expand('<afile>:p')

    " remove autocommand that called this function
    exe 'au! BufUnload' escape(logname, ' ')

    if a:diff_buffnr
	exec 'silent! bdelete' a:diff_buffnr
    endif

    if !filereadable(logname)
	echohl Error | echo 'Log file unreadable: no commit is possible'
	echohl None
	return
    endif

    let response = confirm(a:filename.': commit changes?', "&Yes\n&No")
    if response == 1
	exe 'cd' a:dir
	let templog = tempname()
	exe "!grep -v '^CVS:'" escape(logname,' ') '>' templog
		    \'; cvs ci -F' templog a:filename '2>&1' 
		    \'; rm -f' templog
    endif
    exe 'silent !rm' escape(logname,' ')
    " re-read file so $-keywords would be updated
    exe 'normal' bufwinnr(a:filename).'w'
    silent edit
"    doau BufRead
endfun

fun! CVSAdd()
    let response = inputdialog('Enter file description: ')
    if response != ''
	exe "!cvs add -m '".response."'" expand('%')
    else
	echo "file didn't added"
    endif
endfun

fun! CVSCheckOut()
endfun

fun! CVSUpdate()
    silent! call OpenHelpWin('cvs -n update -l', 'txt', 'CVS update')
    let b:cvs_up_dir = getcwd()
    setlocal modifiable
    delete
    insert
Select file and press <Enter> to examine it.
.
    setlocal nomodifiable cursorline
    map <silent> <buffer> <CR> :<C-U>call ExamineFile(getline('.'))<CR>
    map <buffer> <C-R> :Cup<CR>
    only
    2
endfun

fun! ExamineFile(cvsline)
    let words = split(a:cvsline)
    if len(words) == 2 && exists('b:cvs_up_dir')
	exe 'cd' b:cvs_up_dir
	only
	let splitright = &splitright
	set splitright
	let width = &columns - 21
	exe width.'vnew' words[1]
	if words[0] == 'M'
	    call CVSDiff()
	endif
	let &splitright = splitright
    endif
endfun

fun! CVSDiff(...)
    if a:0
	let revision = '-r '.a:1.' '
    else
	let revision = ''
    endif
    silent! call OpenHelpWin('cvs diff -upsb '.revision.expand('%'), 'diff', 'CVS diff')
    setlocal modifiable
    %s/\r$//e
    g/^RCS file: .*,v$/d
    g/^retrieving revision/d
    setlocal nomod nomodifiable
    1
endfun

fun! CVSStatus()
    silent! call OpenHelpWin('cvs status '.expand('%'), 'txt', 'CVS status')
endfun

fun! CVSLog()
    silent! call OpenHelpWin('cvs log '.expand('%'), 'cvslog', '')
endfun

fun! DiffBuffers()
    let file1 = bufname(winbufnr(1))
    let file2 = bufname(winbufnr(2))
    if !filereadable(file1)
	echo file1 'is unreadable'
	return
    endif
    if !filereadable(file2)
	echo file2 'is unreadable'
	return
    endif
    silent! call OpenHelpWin('diff -ups "'.file1.'" "'.file2.'"', 'diff', 'Diff')
endfun
