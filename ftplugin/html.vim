" HTML editing mappings and abbreviations
" $Id: html.vim,v 1.2 2006/10/28 09:34:05 rnd Exp $

" make selected region a link
iab  <buffer> Yhref <a href=""></a><ESC>?""<CR>a
vmap <buffer> ,h "zdi<a href=""><C-R>z</a><ESC>F"i

" make selected URL a link
vmap <buffer> ,l "zdi<a href="<C-R>z"><C-R>z</a><ESC>F>

" make selected e-mail a link
iab  <buffer> Ymail <a href="mailto:"></a><ESC>?:<CR>a
vmap <buffer> ,m "zdi<a href="mailto:<C-R>z"><C-R>z</a><ESC>F<

iab  <buffer> Ybold <b></b><ESC>?><CR>a
vmap <buffer> ,b "zdi<b><C-R>z</b><ESC>F<

" <a name> tag
iab  <buffer> Yname <a name=""/><ESC>?""<CR>a

" <img> tag
iab  <buffer> Yimg <img alt="[]"<C-M>   align=<C-M>     src=""><ESC>?""<CR>a

let b:did_indent = 1

setlocal iskeyword+=-

fun! HTMLLookupHelp(word)
    return LookupInternet(&ft.' '.a:word.' site:w3.org',1)
endfun

unlet! b:context_help_fun
let b:context_help_fun = function('HTMLLookupHelp')
let b:unaryTagsStack = ''
