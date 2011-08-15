" custom content-dependent file types
" $Id: scripts.vim,v 1.3 2006/10/28 09:51:33 rnd Exp $

" emacs-style filetypes
if getline(1) =~ '-\*- quake-cfg -\*-'
    set filetype=quakecfg
elseif getline(1) =~ '^Path: '
    set filetype=mail
elseif getline(1) =~ '-\*- C -\*-'
    set filetype=c
elseif getline(1) =~ '-\*- C++ -\*-'
    set filetype=cpp
elseif getline(2).getline(line("$")-1).getline(line("$")-2) =~ 'mode:C++'
    set filetype=cpp
endif
