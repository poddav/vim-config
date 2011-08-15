" custom filetypes & filetype-specific autocommands
" $Id: filetype.vim,v 1.36 2006/10/30 15:47:18 rnd Exp $

if version < 600
  augroup filetype "{{{
    au  BufNewFile,BufRead *.in		exe "doau filetype BufRead" expand("<afile>:r")
else
  augroup filetypedetect
endif
    au  BufNewFile,BufRead *.spec		setf spec
    au  BufNewFile,BufRead ~/perl/*		setf perl
    au  BufNewFile,BufRead *.txt		setf text
    au  BufNewFile,BufRead /etc/z*		setf zsh
    au  BufNewFile,BufRead csh.*		setf csh
    au  BufNewFile,BufRead /etc/profile,bashrc	setf sh
    au  BufNewFile,BufRead *.el,.emacs		setf lisp
    au! BufNewFile,BufRead *.tf
    au  BufNewFile,BufRead */qw/*.cfg,*/id1/*.cfg,*/fortress/*.cfg,*.tf,*/Quake/*.cfg
\						setf quakecfg
    au  BufNewFile,BufRead *.qc,*.pqc		setf quakec
    au! BufNewFile,BufRead *.asm
    au  BufNewFile,BufRead *.asm		setf asmintel
    au  BufNewFile,BufRead named.conf		setf named
    au  BufNewFile,BufRead /var/named/*,/etc/namedb/*	setf bindzone
    au  BufNewFile,BufRead /etc/sendmail.cf,*/sendmail-cf/*.cf
\						setf sm
    au  BufNewFile,BufRead /tmp/pan_edit*	setf mail
    au  BufNewFile,BufRead *.msg		setf mail

    " Active Server Pages
    au! BufNewFile,BufRead *.inc
    au  BufNewFile,BufRead *.asp,*.inc		setf aspperl
    au  BufNewFile,BufRead global.asa		setf perl

    " Apache config files
    au  BufNewFile,BufRead httpd.conf,.htaccess	setf apache

    " Termcap/Terminfo databases
    au  BufNewFile,BufRead *.ti,*.terminfo	setf terminfo
    au  BufNewFile,BufRead /etc/termcap*,*.termcap
\						setf termcap

    " XF86Config
    au  BufNewFile,BufRead XF86Config		setf xf86config

    " sendmail's m4
    au  BufNewFile,BufRead *.mc			setf m4sm

    " proftpd config
    au  BufNewFile,BufRead proftpd.conf		setf apachestyle

    " x bitmap
    au  BufNewFile,BufRead *.xbm		setf c

    au	BufNewFile,BufRead */include/*		if exists('headers_are_cpp')
	\					| setf cpp | else | setf c | endif

    au  BufNewFile,BufRead *.h			if getline(1) =~ '-\*- C++ -\*-'
	\					    || exists('headers_are_cpp')
	\					| exe 'setf cpp' | endif
    " autoconf files
    au  BufNewFile,BufRead acinclude.m4,aclocal.m4 setf config

    " LEX sources for c++
    au  BufNewFile,BufRead *.ll			let lex_uses_cpp=1 | setf lex

    " YACC sources for c++
    au  BufNewFile,BufRead *.yy			let lex_uses_cpp=1 | setf yacc

    " GNU ld script
    au  BufNewFile,BufRead *.ld			setf ld

    " documentation files
    au  BufNewFile,BufRead README,INSTALL,NEWS	setf text

    " Parser HTML preprocessor
    au  BufNewFile,BufRead *.phtml
	\ if getline(1).getline(2).getline(3) =~ "<?" |
	\   setf php |
	\ else |
	\   setf parser |
	\ endif

    au  BufNewFile,BufRead typemap		setf typemap

    " GNU gettext
    au  BufNewFile,BufRead *.pox,*.pot		setf po

    " C# XaML
    au  BufNewFile,BufRead *.xaml		setf xml
augroup END "}}}

" FileType autocommands {{{

if version < 600
au FileType c		so $VIMHOME/ftplugin/c.vim
au FileType cpp		so $VIMHOME/ftplugin/c.vim
au FileType perl	so $VIMHOME/ftplugin/perl.vim
au FileType help	so $VIMHOME/ftplugin/help.vim
endif

au FileType lua		let b:commentstart="--"
au FileType sh		let b:commentstart="#"
au FileType csh		let b:commentstart="#"
au FileType zsh		let b:commentstart="#"
au FileType make	let b:commentstart="#"
au FileType apache	let b:commentstart="#" | let b:closetag_html_style=1
au FileType asm		let b:commentstart='#' | setlocal autoindent sw=8 sts=0
au FileType asmintel	if exists('asm_gnu_as_syntax') | let b:commentstart='#' |
			\ else | let b:commentstart=';' | endif | setlocal autoindent sw=8 sts=0
au FileType text	setlocal textwidth=78 formatoptions=tcnrq | call TextMode()
" FIXME :t only for au BufEnter * cd <dir-withfile> (see below)
au FileType terminfo	let b:makeprg="tic " . expand("<afile>:t")
au FileType m4sm	let b:makeprg="make " . expand("<afile>:t:r") . ".cf" |
    \			let b:commentstart='dnl'
au FileType named	let b:commentstart="//"
au FileType bindzone	let b:commentstart=";"
au FileType aspperl	so $VIMHOME/ftplugin/perl.vim | let b:closetag_html_style=1
au FileType conf	setlocal textwidth=0
au FileType vim		let b:commentstart='"'
    \			| setlocal autoindent foldmethod=marker
au FileType html	let b:commentstart='<!--' | let b:commentend='-->' |
    \			let b:closetag_html_style=1 | setlocal noautoindent |
    \			let b:xml_use_xhtml=0 | so $VIMHOME/closetag.vim
au FileType parser	let b:commentstart='#' | let b:commentend='' | let b:commentspace=0 |
    \			let b:closetag_html_style=1
au FileType xdefaults	let b:commentstart='!'
au FileType spec	let b:commentstart='#' | set tw=70
au FileType cvs		setlocal tw=71 formatoptions=tcrq
au FileType quakecfg	let b:commentstart='//'
au FileType changelog	setlocal autoindent tw=78 formatoptions=tcrq
au FileType config	setlocal comments+=b:dnl formatoptions=crq
au FileType m4		setlocal comments+=b:dnl formatoptions=crq
au FileType yacc	let b:commentstart="/*" | let b:commentend="*/" |
    \			setlocal cindent
au FileType lex		let b:commentstart="//" | let b:commentend="" |
    \			setlocal cindent
au FileType python	setlocal autoindent
au FileType automake	let b:commentstart='##' | let b:commentend='' | let b:commentspace=0
au FileType xs		setlocal autoindent
au FileType cs		let b:commentstart="//" | setlocal ts=4 expandtab |
    \			so $VIMHOME/closetag.vim
au FileType xml		setlocal expandtab textwidth=0 |
    \			let b:commentstart='<!--' | let b:commentend='-->' |
    \			so $VIMHOME/closetag.vim

"}}}

fun! TextMode() " default settings for Text filetype
"    inoremap <buffer> .<Space> .<Space><Space>
"    inoremap <buffer> !<Space> !<Space><Space>
"    inoremap <buffer> -<Space> --<Space>
"    inoremap <buffer> .<Esc> .<Esc>
endfun

augroup chdir "{{{
    au!
    if version < 600
	au BufEnter *	let __dir=expand("%:p:h") | if isdirectory(__dir) |
    \			exe "cd ".escape(__dir,' ') | endif | unlet __dir
    else
	au BufEnter *	silent! cd %:p:h
    endif
augroup END "}}}

augroup post "{{{
  au!
  au  BufReadPre /tmp/pan_edit*	set encoding=koi8-r | call SetupFont()
  au  BufRead pico.*,.letter.*	call MailSettings()
  au  BufRead .article.*	call NewsSettings()
  au  BufRead /tmp/pan_edit*	call NewsPanSettings()
  au  BufEnter pico.*,.letter.*	set titlestring=VIM:\ Mail\ message\ edit
  au  BufEnter .article.*	set titlestring=VIM:\ Article\ edit
  au  BufEnter /tmp/pan_edit*	set titlestring=VIM:\ Article\ edit
augroup END "}}}

"if has('iconv')
"    augroup charset "{{{
"	au!
"	au BufReadPre,BufNewFile *	call CharsetDetect(expand('<afile>:p'))
"    augroup END "}}}
"endif

" do not create swap file for files larger than 2MB
"au BufReadPre * if getfsize(expand('<afile>')) > 2000000 | setlocal noswapfile | endif

if version < 600 "|| !exists('#BufReadPre#*.gz')
  augroup gzip "{{{
    au!

    " Enable editing of gzipped files
    "	  read:	set binary mode before reading the file
    "		uncompress text in buffer after reading
    "	 write:	compress file after writing
    "	append:	uncompress file, append, compress file
      if version >= 600
	autocmd BufReadPre,FileReadPre	*.gz let b:_modifiable=&modifiable
	autocmd BufReadPre,FileReadPre	*.gz setlocal bin modifiable
	autocmd BufReadPost,FileReadPost *.gz silent '[,']!gunzip
	autocmd BufReadPost,FileReadPost *.gz setlocal nobin
	autocmd BufReadPost,FileReadPost *.gz exe if !b:_modifiable | setlocal nomodifiable | endif
      else
	autocmd BufReadPre,FileReadPre	*.gz set bin
	autocmd BufReadPost,FileReadPost *.gz let ch_save = &ch|set ch=5
	autocmd BufReadPost,FileReadPost *.gz '[,']!gunzip
	autocmd BufReadPost,FileReadPost *.gz set nobin
	autocmd BufReadPost,FileReadPost *.gz let &ch = ch_save|unlet ch_save
      endif
    autocmd BufReadPost,FileReadPost	*.gz execute ":doautocmd BufReadPost " . expand("%:r")

    autocmd BufWritePost,FileWritePost	*.gz silent !mv <afile> <afile>:r
    autocmd BufWritePost,FileWritePost	*.gz silent !gzip <afile>:r

    autocmd FileAppendPre		*.gz silent !gunzip <afile>
    autocmd FileAppendPre		*.gz silent !mv <afile>:r <afile>
    autocmd FileAppendPost		*.gz silent !mv <afile> <afile>:r
    autocmd FileAppendPost		*.gz silent !gzip <afile>:r
  augroup END
endif "}}}
