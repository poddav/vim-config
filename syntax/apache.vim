" extension of the apache config syntax.
"
" $Log: apache.vim,v $
" Revision 1.3  2006/10/28 10:10:57  rnd
" Restored repository.
"
" Revision 1.2  2001/12/17 17:43:50  rnd
" removed all code that duplicates original apache.vim.
"
" Revision 1.1  2001/08/27 20:20:48  rnd
" added mod_perl and mod_charset directives.
"

"let apache_perl_conf = 1

syn case match
"syn clear apacheFixme
syn keyword apacheFixme FIXME TODO XXX NOT contained
syn case ignore

if exists('apache_perl_conf')
    let s:current_syntax = b:current_syntax
    unlet b:current_syntax
"    runtime! syntax/perl.vim
    syn include @apachePerlScript syntax/perl.vim
    let b:current_syntax = s:current_syntax

    syn keyword apacheDeclaration PerlHandler PerlSetVar PerlAddVar
    syn cluster apachePerlScript remove=perlFunctionName
    syn region  apachePerlSection keepend matchgroup=apacheSection start=+<Perl>+ end=+</Perl>+ contains=@apachePerlScript
endif

" mod_charset (Russian Apache)
syn keyword apacheDeclaration CharsetSourceEnc CharsetDecl CharsetRecodeTable CharsetAlias CharsetPriority CharsetDefault CharsetByExtension CharsetSelectionOrder CharsetAgent CharsetBadAgent CharsetRecodeHeaders CharsetRecodeFilenames CharsetDisable CharsetAutoRedirect CharsetByPort CharsetNormalizeToUrl CharsetBrokenAccept CharsetStrictURIMatch CharsetRecodeMultipartForms
