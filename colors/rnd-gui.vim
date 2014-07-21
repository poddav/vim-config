" Vim color file
" Maintainer:	Slavik Gorbanyov <rnd@web-drive.ru>
" Last Change:	2006 Oct 28
" $Id: rnd-gui.vim,v 1.2 2006/10/30 15:53:20 rnd Exp $

" This color scheme uses a dark grey background.

" First remove all existing highlighting.
set background=dark
hi clear
if exists('syntax_on')
    syntax reset
endif

let g:colors_name = 'rnd-gui'

highlight Normal	guibg=#364959 guifg=Wheat
highlight Cursor	guibg=Red guifg=NONE
highlight Visual	gui=NONE guibg=gray55 guifg=NONE
highlight IncSearch	gui=NONE guibg=DarkCyan guifg=NONE
highlight Search	gui=NONE guibg=Yellow guifg=black
highlight StatusLine	gui=bold guibg=gray80 guifg=black
highlight StatusLineNC	gui=bold guibg=gray70 guifg=gray40
highlight ModeMsg	gui=bold guifg=Yellow
highlight MatchParen	guibg=#667989
