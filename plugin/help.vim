" help subsystem
" $Id: help.vim,v 1.18 2006/10/30 13:31:19 rnd Exp $

if exists('MSYS_DIR') || exists('$CYGWIN') || has('unix')
    let s:man_post_proc='|col -b|uniq'
else
    let s:man_post_proc='|col -b|uniq'
endif

let s:sh_builtin='^\%(alias\|bg\|bind\|break\|builtin\|case\|cd\|co\%(mmand\|ntinue\)\|declare\|dirs\|echo\|enable\|eval\|ex\%(ec\|it\|port\)\|fc\|fg\|for\|function\|getopts\|hash\|help\|history\|if\|jobs\|kill\|let\|lo\%(cal\|gout\)\|popd\|pushd\|pwd\|read\%(\|only\)\|return\|se\%(lect\|t\)\|shift\|source\|suspend\|test\|times\|trap\|ty\%(pe\|peset\)\|ulimit\|umask\|un\%(alias\|set\|til\)\|variables\|wait\|while\)$'

let s:perl_builtin='^\%(abs\|accept\|alarm\|atan2\|bind\|binmode\|bless\|caller\|chdir\|chmod\|chom\=p\|chown\|chr\|chroot\|close\|closedir\|connect\|continue\|cos\|crypt\|dbmclose\|dbmopen\|defined\|delete\|die\|do\|dump\|each\|end\%(grent\|hostent\|netent\|protoent\|pwent\|servent\)\|eof\|eval\|exec\|exp\|exists\|exit\|fcntl\|fileno\|flock\|fork\|format\|formline\|getc\|getgrent\|getgrgid\|getgrnam\|gethostbyaddr\|gethostbyname\|gethostent\|getlogin\|getnetby\%(addr\|name\)\|getnetent\|getp\%(eername\|grp\|pid\)\|getpriority\|getprotoby\%(name\|number\)\|getprotoent\|getpw\%(ent\|nam\|uid\)\|getservbyname\|getservbyport\|getservent\|getsock\%(name\|opt\)\|glob\|gmtime\|goto\|grep\|hex\|import\|index\|int\|ioctl\|join\|keys\|kill\|last\|lc\%(first\)\=\|length\|link\|listen\|local\%(time\)\=\|log\|lstat\|map\|mkdir\|msg\%(ctl\|get\|rcv\|snd\)\|my\|next\|no\|open\|opendir\|ord\|our\|pack\%(age\)\=\|pipe\|po[ps]\|printf\=\|prototype\|push\|quotemeta\|rand\|read\%(dir\|link\)\=\|recv\|redo\|ref\|rename\|require\|reset\|return\|reverse\|rewinddir\|rindex\|rmdir\|scalar\|seek\%(dir\)\=\|select\|sem\%(ctl\|get\|op\)\=\|send\|set\%(gr\|host\|net\)ent\|setp\%(grp\|riority\|rotoent\|went\)\|setservent\|setsockopt\|shift\|shm\%(ctl\|get\|read\|write\)\|shutdown\|sin\|sleep\|socket\%(pair\)\=\|sort\|splice\|split\|sprintf\|sqrt\|srand\|stat\|study\|sub\%(str\)\=\|symlink\|sys\%(call\|read\|seek\|write\|tem\)\|tell\%(dir\)\=\|tied\=\|times\=\|truncate\|uc\%(first\)\=\|umask\|un\%(def\|link\|pack\|shift\|tie\)\|use\|utime\|values\|vec\|wait\%(pid\)\=\|wa\%(ntarray\|rn\)\|write\)$'

fun! OpenHelpWin(cmd, ft, ...)
    let buf_name = a:0? a:1 : 'Help'
    exe 'silent new' escape(buf_name, '\ ')
    if version >= 600
	setlocal modifiable buftype=nofile noswapfile
    endif
    let &ft = a:ft
    exe "silent 0r!".a:cmd
    set nomod
    let helpsize = line('$')
    if helpsize > &helpheight
	let helpsize = &helpheight
    endif
    if winheight(2) != -1
	exe 'resize' helpsize
    endif
    1
    if version >= 600
	noremap <buffer> <Space> <C-F>
	noremap <buffer> <Backspace> <C-B>
	noremap <buffer> q :bdel<CR>
	setlocal nomodifiable
    else
	set readonly
    endif
endfun

fun! EscapeURI(uri)
    let uri = substitute(a:uri, ':', '\%3A', 'g')
    let uri = substitute(  uri, ' ', '+', 'g')
    return uri
endfun

fun! OpenURL(url)
    if has('win32')
	exe g:start_browser escape(a:url, '%')
    else
	exe 'silent !xdg-open' escape(a:url, '%') '&'
    endif
    return 1
endfun

fun! LookupInternet(word, ...)
    let postfix = a:0? '&btnI': ''
    let url = 'http://google.com/search?q='.EscapeURI(a:word).postfix
    return OpenURL(url)
endfun

fun! LookupInternetVMode() range
    if a:firstline != a:lastline
	return
    endif
    try
	let save_a = @a
	silent normal! gv"ay
    	let text = @a
	return LookupInternet(text)
    finally
	let @a = save_a
    endtry
endfun

fun! Man(page, ...)
    if a:0
	let page = a:1
	let section = '-S '.a:page.' '
    else
	let page = a:page
	let section = v:count? '-S '.v:count.' ': ''
    endif
    call OpenHelpWin('man '.section.page.' 2>&1 '.s:man_post_proc, 'man', 'Man '.page)
    if v:shell_error || getline(1) =~ '^No manual'
	bdel
	return 0
    endif
    return 1
endfun

fun! Perldoc(word)
    let move_to_pattern = ''
    let filetype = 'man'
    if a:word =~ s:perl_builtin
	let cmd = 'perldoc -t -f '.a:word
    elseif a:word =~# '^\(s\|m\)$'
	let cmd = 'perldoc perlop'
	let move_to_pattern = '/^ \+'.a:word.'\/PATTERN\//'
    elseif a:word =~# '^\(tr\|y\)$'
	let cmd = 'perldoc perlop'
	let move_to_pattern = '/^ \+'.a:word.'\/SEARCHLIST\//'
    elseif a:word =~# '^q[qxwr]\=$'
	let cmd = 'perldoc perlop'
	let move_to_pattern = '/^ \+'.a:word.'\/STRING\//'
    elseif a:word =~# '^\(y\|tr\)$'
	let cmd = 'perldoc perlop'
	let move_to_pattern = '/^ \+'.a:word.'\/SEARCHLIST\//'
    else
	let cmd = 'perldoc '.a:word
    endif
"    call OpenHelpWin(cmd.' 2>/dev/null '.s:man_post_proc, filetype, 'Perldoc '.a:word)
    call OpenHelpWin(cmd, filetype, 'Perldoc '.a:word)
    if v:shell_error || getline(1) =~ '^No documentation'
	bdel
	return 0
    endif
    if move_to_pattern != ''
	silent exec move_to_pattern
	normal z
    endif
    return 1
endfun

fun! ShBuiltin(word)
    let WORD = expand("<cWORD>")
    if a:word =~ s:sh_builtin
	let cmd = "bash -c 'help ".a:word."'"
    elseif WORD == '\[' || WORD =~ '^-[a-z]$'
	let cmd = "bash -c 'help test'"
    elseif WORD == ':' || WORD == '.' || WORD == '{'
	let cmd = "bash -c 'help ".WORD."'"
    else
	return Man('1:5:8', a:word)
    endif
    call OpenHelpWin(cmd, 'man')
    return !v:shell_error
endfun

fun! WinHelp(word, path)
    exe 'silent !start winhlp32 -k' a:word a:path
    return 1
"    return LookupInternet(a:word, 1)
endfun

fun! Help(word)
    if exists("b:context_help_fun") && b:context_help_fun(a:word)
	return
    endif

    if &ft =~ 'perl'
	if Perldoc(a:word) == 0
	    redraw | echohl Error | echo 'No documentation on "'.a:word.'"' | echohl None
	endif

    elseif &ft =~ '^z\=sh'
	call ShBuiltin(a:word)

    elseif a:word !~ '^\i\+'
	echohl Error | echo 'No identifier under cursor' | echohl None

    elseif &ft == 'vim' || &ft == 'help'
	exe "help" a:word

    elseif Man(a:word) == 0
	redraw | echohl Error | echo 'No information on "'.a:word.'"' | echohl None

    endif	
endfun

command! -nargs=* Man	    call Man(<f-args>)
command! -nargs=1 Perldoc   call Perldoc(<f-args>)

map K :<C-U>call Help(expand("<cword>"))<CR>

let $MANPL='1100i' " no page breaks inside man pages

if has('win32')
    let $PERLDOC='-t'
endif
