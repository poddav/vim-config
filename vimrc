" ~/.vimrc -- user configuration file for VIM editor
" $Id: vimrc,v 1.32 2006/10/28 10:39:18 rnd Exp $

"*** VIM HOME DIRECTORY {{{1

if version < 600
    echoerr 'this configuration requires vim 6.x or later'
endif

if $USER == "root"
    let $VIMHOME=expand("~rnd/.vim")
else
    let $VIMHOME=expand("~/.vim")
endif

if stridx(&runtimepath, $VIMHOME) == -1
    set runtimepath^=$VIMHOME
    set runtimepath+=$VIMHOME/after
endif

"*** VARIOUS {{{1

runtime userinfo.vim
runtime terminal.vim
runtime defun.vim

if $OS == "Windows_NT"
"    runtime mingw.vim
"    runtime cygwin.vim
    language messages en
    let $LC_ALL="C"
endif

" default background color for syntax highlighting
set background=dark
let mysyntaxfile=$VIMHOME . "/syntax.vim"
filetype plugin indent on
syntax on

"*** OPTIONS {{{1

"**** Sessions {{{2

" use forward slash when expanding file names.
set shellslash

" disable VI compatibility mode
set nocompatible

" autoreread buffer after changes of the file outside of Vim
set autoread

" dynamic word completion searches in all loaded buffers
set complete=.,w,b,u,t,i

" options for Insert mode completion
set completeopt=menu,preview

" maximum number of items to show in the popup menu
set pumheight=10

" List of directory names for the swap file, separated with commas.
if $OS == "Windows_NT" && exists("$TEMP")
    set directory=$TEMP\\\\
endif

" number of command-lines that are remembered
set history=50

" force make to use two cpu cores
"set makeprg=make\ -j2
"set makeprg=mingw32-make
set makeprg=make

" String to be used to put the output of the :make command in the error file.
set shellpipe=2>&1\|\ tee

" number of lines in file that is checked for set commands
if $USER == 'root'
    set modelines=0 " disable modelines for root
else
    set modelines=5 " default Vim setting
endif

" save files/register history, don't save search highlighting
set viminfo='50,\"50,h

"**** Folding {{{2

" default fold method
set foldmethod=manual

" which commands force folds to be opened
set foldopen=all

" automatically close folds when cursor leave them
set foldclose=all

" close all folds upon editing new file
set foldlevelstart=0

"**** Text formatting {{{2

" allow backspacing over indent, <EOL> and start of insert
set backspace=indent,eol,start

" auto-wrap using 'textwidth', format comments
set formatoptions=crq

" Number of spaces to use for each step of (auto)indent
set shiftwidth=4

" Round indent to multiple of 'shiftwidth'
set shiftround

" <Tab> in front of a line inserts blanks according to 'shiftwidth'
set smarttab

" Number of spaces that a <Tab> counts for in INSERT mode
set softtabstop=4

" Maximum width of text line, a longer line will be broken after white space
set textwidth=78

"**** Search {{{2

" Program to use for the :grep command.
set grepprg=internal

" highlight matches with last search pattern
set nohlsearch

" incremental search (emacs-like)
set incsearch

" case insensitive search
set ignorecase

" Searches don't wrap around the end of the file
set nowrapscan

" Don't ignore case if the search pattern contains uppercase characters
set smartcase

"**** Status line {{{2

" number of lines to use for the command-line
set cmdheight=1

" status line always on
set laststatus=2

" Threshold for reporting number of lines changed (always report)
set report=0

" ruler turned on
set ruler

" don't redraw screen while executing macros
set lazyredraw

" Try to avoid `hit-RETURN' prompts
set shortmess=filmnrxOt

" Show (partial) command in status line
set showcmd

" content of the status line
if has('gui')
    set statusline=%f\ %m%r%y%=<%{&fileencoding}>\ %8{CurCharStatus()}\ %k\ %12(%l,%c%V%)%6P
else
    set statusline=%f\ %m%r%y\ %{strftime(\"[\%H:\%M]\")}%=<%{&fileencoding}>\ %{CurCharStatus()}\ %k\ %12(%l,%c%V%)%6P
endif

fun CurCharStatus()
    let char = matchstr(getline('.'),'.',col('.')-1)
    let char_nr = char2nr(char)
    if char_nr == 0
	return '<NULL>'
    endif
    if char_nr < 32
	let char = ' '
    endif
    return printf("<%s> 0x%02x", char, char_nr)
endfun

" when completing commands, show possible matches in status line
set wildmenu
" character that starts wildcard expansion within macros
set wildcharm=<C-Z>
" exclude binary files from expansion matches
set wildignore=*.o,*.obj,*.exe
" demand completion on header files
set suffixes-=.h
" exclude libraries and executables
set suffixes+=.rpo,.d,.a,.lib,.exe

"**** Visual settings {{{2

" characters included in file names and path names.
set isfname=@,48-57,/,.,-,_,+,,,#,$,%,~

" leave windows sizes intact while closing/splitting buffers
set noequalalways

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=1

" String to put at the start of lines that have been wrapped
set showbreak=>>\ 

" When a bracket is inserted, briefly jump to the matching one
set showmatch

" spliting a window will put the new window below the current one
set splitbelow

" PgUp/PgDn leave cursor at current column
set nostartofline

" Indicates a fast terminal connection
if &term != "ansi" | set ttyfast | endif

" the cursor can be positioned where there is no actual character.
set virtualedit=block

" lines not wrap and only part of long lines will be displayed.
set wrap
" The minimal number of columns to scroll horizontally.
set sidescroll=1
" characters to show that line continues beyond screen boundary.
set listchars+=precedes:<,extends:>

"**** Charsets {{{2

set encoding=utf-8
set termencoding=utf-8

" recognized charsets
set fileencodings=ucs-bom,utf-8
set fileencodings+=shift-jis
if has("win32")
    set fileencodings+=cp1251
elseif has("unix")
    set fileencodings+=koi8-r
elseif &term == "pcterm"
    set fileencodings+=cp866
endif

"**** Quickfix settings {{{2

" Perl syntax checking error messages
set errorformat+=%m\ at\ %f\ line\ %l%[.\\,]%.%#

" GCC 4.x error messages fix
"set errorformat^=In\ file\ included\ from\ %f:%l:%.%#,\^I\^Ifrom\ %f:%l%m
set errorformat^=%m\ %f:%l:%.%#,\^I\^Ifrom\ %f:%l%m

" MSBuild messages and C# compiler errors
set errorformat^=%-GBuild\ started\ %m,%-GTime\ Elapsed\ %m,%f(%l\\,%c):\ %m

"**** Plugins custom settings {{{2

let g:netrw_keepdir = 0
let g:netrw_list_hide = '^\..*[^/]$'
let g:netrw_sort_sequence = '/$,*,\.h$,\.info$,\.swp$,\.rpo$,\.o$,\.obj$'
let g:headers_are_cpp = 1

if has('win32')
    " this is how it supposed to be
"    let g:start_browser = '!start cmd /c start'
    " but, only `explorer' is able to follow `#' references within urls
"    let g:start_browser = '!start explorer'
    " but, `explorer' does not put his window on top of desktop
"    let g:start_browser='silent !start '.$PROGRAMFILES.'/Internet Explorer/iexplore.exe'
    let g:start_browser='silent !start '.$PROGRAMFILES.'/Mozilla Firefox/firefox.exe'
endif

" bufexplorer
let g:bufExplorerDefaultHelp=0

"*** KEY MAPPINGS / MACROS {{{1

"**** digraphs {{{2
if has("unix")
    dig ~@ 128  ~A 129  ~B 130  ~C 131  ~D 132  ~E 133  ~F 134  ~G 135
    dig ~H 136  ~I 137  ~J 138  ~K 139  ~L 140  ~M 141  ~N 142  ~O 143
    dig ~P 144  ~Q 145  ~R 146  ~S 147  ~T 148  ~U 149  ~V 150  ~W 151
    dig ~X 152  ~Y 153  ~Z 154  ~[ 155  ~\ 156  ~] 157  ~^ 158  ~_ 159
endif

"**** Emacs derived bindings {{{2

" display highlight ID of item under cursor
fun! SyntaxInfo()
    let synid=synID(line('.'), col('.'), 0)
    let attr=synIDattr(synid, 'name')
    let real=synIDattr(synIDtrans(synid), 'name')
    echon "\r".attr.' -> '
    exe 'echohl' real
    echon real
    echohl Normal
endfun
nmap <C-X>w :call SyntaxInfo()<CR>
" edit file
if has('gui')
    nmap <C-X><C-F> :browse :e<CR>
else
    nmap <C-X><C-F> :let w:fn=input("Edit file: ", "", "file")\|if strlen(w:fn)\|exe "e" w:fn\|en\|unl w:fn<CR>
endif
"nmap <C-X>k :q<CR>
" movement
"noremap! <C-A> <Home>
"noremap! <C-E> <End>
"noremap! <C-D> <Delete>
"imap <C-K> <C-O>D
" abort command
cmap <C-G> <Esc><Esc>

"**** Bindings {{{2

inoremap <C-Z> <C-O>:undo<CR>

" Copy/Paste
vnoremap <C-C> "*y
vnoremap c "*y

" delete indent at start of line
" since CTRL-D is GNU readline standard for delete-char, have to remap it.
inoremap <C-B> <C-D>

" per-screen-line movement
map <Up> gk
map <Down> gj
inoremap <Up> <C-O>gk
inoremap <Down> <C-O>gj
" in motion-driven commands (y,d) cursor keys should work over text lines,
" not screen.
ounmap <Up>
ounmap <Down>

" disable some CTRL hotkeys
imap <C-Home> <Home>
imap <C-End> <End>

" scroll window
map <C-Up> <C-Y>
map <C-Down> <C-E>

" put commands does not change cursor position
nnoremap p p`[h
nnoremap P P`[

" format paragraph/block with `Q'
inoremap <C-J> <C-O>gqap
nmap Q gqap
vmap Q gq

" comment out line
nmap ,c :Comm<CR>
nmap ,u :Uncomm<CR>
vmap ,c :Comm<CR>
vmap ,u :Uncomm<CR>

" digraph (mnemonic: X = eXtended mode, D = Digraph)
inoremap <C-X><C-D> <C-K>

" save buffer
noremap  <F2>	<ESC>:w<CR>
inoremap <F2>	<C-O>:w<CR>
noremap  <C-S>	:w<CR>
inoremap <C-S>	<C-O>:w<CR>

" paste mode
map <F5> :set invpaste<CR>
imap <F5> <C-O>:set invpaste<CR>
set pastetoggle=<F5>

" jump to other window
map <F6> <C-W>w
imap <F6> <ESC><C-W>w

" jump to next error
map <F8> :cn<CR>
map <F18> :cp<CR>
imap <F8> <C-O>:cn<CR>
imap <F18> <C-O>:cp<CR>

" save buffer & compile
" NOTE: 'autowrite' writes all modified buffers,
" so we use `:w' to save only current file
nmap <F9> :make<CR>
imap <F9> <C-O>:make<CR>

imap <C-Tab> <Esc>:call NextTabOrWin()<CR>
nmap <C-Tab> :call NextTabOrWin()<CR>
nmap <C-F4> :call CloseTabOrWin()<CR>

fun NextTabOrWin() "{{{
    if tabpagenr('$') == 1 " if there's no tabs
	wincmd w
    else
	tabnext
    endif
endfun "}}}
fun CloseTabOrWin() " {{{
    if tabpagenr('$') == 1 " if there's no tabs
	confirm quit
    else
	confirm tabclose
    endif
endfun " }}}

" menu in console
if !has('gui')
map <F10> :emenu <C-Z>
endif

map <F11> :setlocal invmodifiable<CR>

" popup menu of tags for word under cursor
map <C-\> :exec 'tjump' expand('<cword>')<CR>

" tweak popup menu
vnoremenu 1.5 PopUp.Lookup\ &Google		:call LookupInternetVMode()<CR>

" other window scrolling
noremap <C-W><PageUp>	<C-W>p<PageUp><C-W>p
noremap <C-W><PageDown>	<C-W>p<PageDown><C-W>p
noremap <C-W><C-Y>	<C-W>p<C-Y><C-W>p
noremap <C-W><C-E>	<C-W>p<C-E><C-W>p

" dynamic abbreviation (M-\)
"inoremap <Esc>\ <C-P>
" filename completion
inoremap <C-F> <C-X><C-F>
" whole line completion
inoremap <C-L> <C-X><C-L>

" xml plugin completion key
let g:xml_tag_completion_map = '<C-L>'

command Chx silent !chmod +x %

"**** Visual mode with Shift-movement keys {{{2

nmap <S-Left> vh
nmap <S-Right> vl
nmap <S-Up> Vk
nmap <S-Down> Vj
nmap <S-PageUp> V<PageUp>
nmap <S-PageDown> V<PageDown>
nmap <S-End> v$
nmap <S-Home> v^
imap <S-Left> <C-O>vh
imap <S-Right> <C-O>vl
imap <S-Up> <C-O>Vk
imap <S-Down> <C-O>Vj
imap <S-PageUp> <C-O>V<PageUp>
imap <S-PageDown> <C-O>V<PageDown>
imap <S-End> <C-O>v$
imap <S-Home> <C-O>v^
vmap <S-Left> h
vmap <S-Right> l
vmap <S-Up> k
vmap <S-Down> j
vmap <S-PageUp> <PageUp>
vmap <S-PageDown> <PageDown>

" selection insert
inoremap <S-Insert> <MiddleMouse>

"**** fix common typos {{{2
command W w
command -bang Wq wq<bang>
command -bang Q q<bang>
cab E edit
" disable F10
nmap <F10> <Shift>

"**** include file under cursor {{{2

function IncFile(...)
    if getline('.') =~ '^\s*!'
	let command = getline('.')
	call append(line('.'), '- - - 8< - - -')
	exe 's/^\s*!\s*\(.*\)$/\% \1/'
	exe 'read' command
    else
	let filename_under_cursor=glob(expand("<cfile>"))
	if filereadable(filename_under_cursor)
	    call SaveRep()
	    if a:0 > 0 " &ft == 'mail'
		exe ".!shar -fc ".filename_under_cursor
		.s/-/=/g
	    else
		call append(line("."), '- - - - - - - 8< - - - - - - -')
"    		exe ".s/^.*$/===> ".expand("<cfile>:t")." <===/"
		exe ".s/^.*$/- - - 8< - - - ".escape(filename_under_cursor,"/~")." - - - 8< - - -/"
		exe "read ".filename_under_cursor
	    endif
	    call RestRep()
	elseif strlen(filename_under_cursor)
	    echohl ErrorMsg | echo "File `".filename_under_cursor."' not found" | echohl None
	else
	    echohl ErrorMsg | echo "Need filename under cursor" | echohl None
	endif
    endif
endfunction

" include file which name is under cursor
map <F3> :call IncFile()<CR>
imap <F3> <C-O>:call IncFile()<CR>
" same, but include it as shar archive
map <F13> :call IncFile(1)<CR>
imap <F13> <C-O>:call IncFile(1)<CR>

"**** language mapping {{{2
map ё `
map й q
map ц w
map у e
map к r
map е t
map н y
map г u
map ш i
map щ o
map з p
map х [
map ъ ]

map ф a
map ы s
map в d
map а f
map п g
map р h
map о j
map л k
map д l
map ж ;
map э '

map я z
map ч x
map с c
map м v
map и b
map т n
map ь m
map б ,
map ю .

map Ё ~
map Й Q
map Ц W
map У E
map К R
map Е T
map Н Y
map Г U
map Ш I
map Щ O
map З P
map Х {
map Ъ }

map Ф A
map Ы S
map В D
map А F
map П G
map Р H
map О J
map Л K
map Д L
map Ж :
map Э "

map Я Z
map Ч X
map С C
map М V
map И B
map Т N
map Ь M
map Б <
map Ю >

"*** ABBREVS {{{1
exe 'iab IAM' FullName '<'.Email.'>'

"*** DATE/TIME {{{1

" use english for date/time everywhere
language time C

iab SDATE <C-R>=DateString('short')<CR>
" Example: 02/12/02
iab DATE <C-R>=DateString('normal')<CR>
" Example: Tue Jan  2 2001
iab VDATE <C-R>=DateString('vim')<CR>
" Example: 2006 Oct 28
iab FDATE <C-R>=DateString('full')<CR>
" Example: Mon Dec 25 08:08:55 SAMT 2000

map ,L  1G/Last\supdate:\s*/e+1<CR>CVDATE<ESC>
map ,,L 1G/Last\schange:\s*/e+1<CR>CVDATE<ESC>

function LastModSeek(start_line, end_line) "{{{2
    let pattern = '^\(.*Last \([Cc]hanged\=\|[Uu]pdated\=\|[Mm]odified\):\s*\).*'

    let current_line = a:start_line
    while current_line <= a:end_line
	let test_string = getline(current_line)
	if test_string =~ pattern
	    let current_date = DateString('vim')
	    let test_string = substitute(test_string, pattern, "\\1".current_date, "")
	    call setline(current_line, test_string)
	endif
	let current_line = current_line + 1
    endwhile
endfunction "}}}2

function LastChange() "{{{2
    if &filetype !~ '^\(vim\|txt\|c\|cpp\|perl\|sh\|html\)$'
	return
    endif

    call LastModSeek(1,10)
    let linestart = line("$") - 10
    let lineend = line("$")
    if lineend < 11
	return
    endif
    if linestart < 11
	let linestart = 11
    endif
    call LastModSeek(linestart, lineend)
endfunction "}}}2

au BufWritePre *		call LastChange()

" }}}================================================================

" jump to last known file position
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

if &updatecount == 10000 " invoked as `view'
    so $VIMHOME/../.viewrc
endif

runtime extra.vim

" vim: fdm=marker
