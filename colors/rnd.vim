" Vim color file
" Maintainer:	Slavik Gorbanyov <rnd@web-drive.ru>
" Last Change:	Wed Dec 18 22:20:34 2002
" $Id: rnd.vim,v 1.1.1.1 2006/10/28 09:27:16 rnd Exp $

" This color scheme uses a light grey background.

" First remove all existing highlighting.
set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "rnd"

hi Normal guibg=#364959 guifg=Wheat

hi ErrorMsg	guibg=Red guifg=White
hi Search	gui=NONE guibg=Yellow guifg=black
hi IncSearch	gui=NONE guibg=DarkCyan guifg=NONE
hi ModeMsg	gui=bold guifg=Yellow
hi StatusLine	gui=bold guibg=gray80 guifg=black
hi StatusLineNC	gui=bold guibg=gray70 guifg=gray40
hi VertSplit	gui=reverse
hi Visual	gui=NONE guibg=gray55 guifg=NONE
hi VisualNOS	gui=underline,bold
hi Cursor	guibg=Red guifg=NONE
hi lCursor	guibg=Cyan guifg=NONE
hi NonText	gui=bold guifg=Blue

" Colors for syntax highlighting
hi Comment	term=bold ctermfg=White guifg=White
hi Constant	ctermfg=Green guifg=SpringGreen2
hi Special	term=bold ctermfg=LightRed guifg=HotPink
hi Statement	term=bold ctermfg=Yellow guifg=#ffff60
hi Ignore	ctermfg=LightGrey guifg=grey90
hi Identifier	term=underline cterm=bold ctermfg=DarkCyan guifg=LightSteelBlue3
hi PreProc	term=underline ctermfg=Brown guifg=Orange
hi Type		term=underline ctermfg=Magenta guifg=aquamarine3
