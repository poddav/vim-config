" Smart keyboard layout switching
" Created: 2010 Jul 21
" Last change: 2014 Feb 02
" Copyright (c) 2010 **************** <poddav@gmail.com>
" $Id$

if $OS != "Windows_NT"
    finish
endif

"finish " disable

if !exists("g:kbm_default_layout")
    let g:kbm_default_layout = 67699721 " en_US
endif

if !exists("g:kbm_plugin_path")
    let g:kbm_plugin_path = $VIMHOME."/plugin/keybmode.dll"
endif

fun! KBM_SaveCurrentLayout()
    let t:kbm_current_layout = libcallnr(g:kbm_plugin_path, "get_keyboard_layout", "")
    call libcallnr(g:kbm_plugin_path, "set_keyboard_layout", g:kbm_default_layout)
    return t:kbm_current_layout
endfun

fun! KBM_SetDefaultLayout()
    return libcallnr(g:kbm_plugin_path, "set_keyboard_layout", g:kbm_default_layout)
endfun

fun! KBM_RestoreLayout()
    if exists("t:kbm_current_layout")
	return libcallnr(g:kbm_plugin_path, "set_keyboard_layout", t:kbm_current_layout)
    else
	return KBM_SetDefaultLayout()
    endif
endfun

autocmd VimEnter	* silent! call KBM_SetDefaultLayout()
autocmd InsertLeave	* silent! call KBM_SaveCurrentLayout()
autocmd InsertEnter	* silent! call KBM_RestoreLayout()

nnoremap :		:silent! call KBM_SetDefaultLayout()<CR>:
onoremap :		:silent! call KBM_SetDefaultLayout()<CR>:
vnoremap :		:<C-U>silent! call KBM_SetDefaultLayout()<CR>:'<,'>
