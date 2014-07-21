" mail/news article editing settings
" $Id: mail.vim,v 1.12 2006/10/28 10:02:11 rnd Exp $

let random_cookie = 'prcookie'
let generate_msgid = '/home/rnd/src/misc/gen-msgid'

function! MailCommonSettings()
    setlocal textwidth=72 expandtab nomodeline
    setlocal formatoptions=tcrq1
    call TextMode()
"    let b:formatprg="/home/rnd/perl/quoting.form"

"    exe '1;/^$/s/^\(Organization:\).*/\1 '.system('prcookie').'/e'
" или (без error handling)
"    normal 1G/^Organization:/ea:.!/home/rnd/perl/prcookiekJ
endfunction

function! NewsSettings()
    call MailCommonSettings()
    let body = SetupHeaders()
    exe body.',$call SetQuoteComments()'
    silent! normal gq/^-- $/
endfunction

function! NewsPanSettings()
    call MailCommonSettings()
    %call SetQuoteComments()
    call append(line('$'), '')
    call append(line('$'), '-- ')
    silent $r!signature
    call cursor(line('$') - 2, 0)
endfunction

function! MailSettings()
    call MailCommonSettings()
    %call SetQuoteComments()
    /^$/
    silent! normal gq/^-- $/
    1
endfunction

" Hайти все последовательности цитирования в письме и составить из них опцию
" comments для удобства форматирования
" (c) Artem Chuprina <2:5020/371.32@fidonet>
function! SetQuoteComments () range abort
    let quote_re = '[A-Za-zёЁю-Ъ]\{1,6}>' " Sorry, for koi8-r
    let &comments = "n:>"
    let end_line = a:lastline
    let current_line = a:firstline
    while current_line <= end_line
	let test_string = getline(current_line)
	let maxlen = strlen(test_string)
	let match_end_pos = matchend(test_string, '^[ \t>]*'.quote_re)
	while match_end_pos > 0
	    let prefix = matchstr(test_string, quote_re)
	    let test_string = strpart(test_string, match_end_pos, maxlen)
	    let match_end_pos = matchend(test_string,'^[\s>]*'.quote_re)
	    if &comments !~ ':'.prefix.'\($\|,\)'
		let &comments = &comments.',n:'.prefix
	    endif
	endwhile
	let current_line = current_line + 1
    endwhile
endfunction

function! SetupHeaders()
    let current_line = 1
    let end_line = line('$')

    while current_line <= end_line
	let test_string = getline(current_line)

	if test_string =~ '^$'
	    break | endif

"	if test_string =~ '^Newsgroups: fido\..*'
"	    if executable(g:generate_msgid) == 1
"		call append(current_line - 1, SystemChop(g:generate_msgid))
"		let current_line = current_line + 1
"	    endif
	if test_string =~ '^Organization:'
	    if executable(g:random_cookie) == 1
		call setline(current_line, 'Organization: '.SystemChop(g:random_cookie))
	    endif
	endif

	let current_line = current_line + 1
    endwhile

    return current_line
endfunction
