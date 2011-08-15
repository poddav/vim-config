" Vim terminal initialization
" $Id: terminal.vim,v 1.3 2006/10/28 09:51:52 rnd Exp $

" use system termcap database
set notbi
" disable sound bell & visual bell
set vb t_vb=

if $LANG =~ 'UTF-8'
    set termencoding=utf-8
endif

if &term == 'builtin_gui'
    finish
endif

if &term == "xterm"
    " set icon title to name of file
    set icon
    " set window title to `VIM - <name_of_file>'
    set title

    " restore screen after exit
"    set t_ti=7[r[?47h t_te=[?47l8

    " fix cursor keys & keypad
"    set t_ks= t_ke=
    " xterm F1-F4 FIXME
"     set t_k1=OP
"     set t_k2=OQ
"     set t_k3=OR
"     set t_k4=OS
    set t_F3=[25~ " <F13>
    set t_F8=[32~ " <F18>
    set t_kh=[1~ t_#2=[1$
    set t_@7=[4~ t_*7=[4$
    set t_kb=
    fixdel

    " enable mouse
    set mouse=a

    if !has("x11")
" trick for restoring title when support for X11 does not compiled in
"	let title=system("xprop -id $WINDOWID -notype -f WM_NAME 8s ' $0' WM_NAME")
"	exe "let &titleold=".strpart(title, matchend(title, 'WM_NAME'), strlen(title))
"	unlet title
	set titleold=xterm
    endif
    nmap O5A <C-W><Up>
    nmap O5B <C-W><Down>
elseif &term == "linux"
    set t_F3=[25~ " <F13>
    set isprint=@,139-140,152-255
elseif &term == "pcterm"
    set guicursor=n-v-c-o:hor50,i-ci:hor10,r-cr-sm:block
endif

" force colors
if exists("&t_Co") && &t_Co == ''
    set t_Co=8
    if has("terminfo")
    " NOTE: see :help coloring for details
    	set t_Sf=[3%p1%dm
    	set t_Sb=[4%p1%dm
    else
    	set t_Sf=[3%dm
    	set t_Sb=[4%dm
    endif
endif
