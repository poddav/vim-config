" Graphic VIM init
" $Id: gvimrc,v 1.3 2006/10/28 10:37:04 rnd Exp $

if has("x11")
    set guifont=Monospace\ 12
elseif has("win32")
"    set guifont=Lucida\ Console:h12:cRUSSIAN
"    set guifont=Andale\ Mono:h12:cRUSSIAN
    set guifont=Consolas:h12:cRUSSIAN
    set linespace=3
endif

" disable toolbar & menubar
set guioptions-=T
set vb t_vb=
set lines=50 columns=110
set mousemodel=popup_setpos

"silent! colorscheme rnd-gui
let s:hour = strftime('%H')
if s:hour > 7 && s:hour < 18
    colorscheme metallic
    highlight Function		guifg=#006080 gui=bold
    highlight MatchParen	guibg=#b4b0a8
    highlight SpecialKey	guifg=#b4b0a8
    highlight NonText		guifg=#b4b0a8
else
    colorscheme darkblue
    highlight Normal		guifg=#e0e0c0
    highlight Visual		guibg=#000040
    highlight Todo		guifg=Yellow
    highlight StatusLine	gui=bold guibg=gray80 guifg=darkblue
    highlight MatchParen	guibg=#667989
    highlight CursorColumn	guibg=#101060
    highlight CursorLine	guibg=#101060
    highlight Function		guifg=#ffffff
    highlight NonText		guifg=#505090
    highlight SpecialKey	guifg=#505090
endif

highlight Comment		gui=italic

if has('multi_byte_ime')
highlight CursorIM	guibg=Purple guifg=NONE | endif
if has('keymap')
highlight lCursor	guibg=Purple guifg=NONE | endif
