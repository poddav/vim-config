" extension of the perl syntax distributed with Vim.
" Last change: 2011 Jul 04
" $Id: perl.vim,v 1.4 2006/10/28 10:20:38 rnd Exp $

syn region perlQQ	matchgroup=perlStringStartEnd start="\<q\s*\z([!#$%&*+,./:;=?@^_|~]\)" end=+\z1+ contains=@perlInterpSQ
syn region perlQQ	matchgroup=perlStringStartEnd start="\<q[qx]\s*\z([!#$%&*+,./:;=?@^_|~]\)" end=+\z1+ contains=@perlInterpDQ
syn region perlMatch	matchgroup=perlMatchStartEnd start="\<\(m\|qr\)\s*\z([!#$%&*+,.:;=?@^_|~]\)" end=+\z1[cgimosx]*+ keepend contains=@perlInterpMatch

syn region perlMatch	matchgroup=perlMatchStartEnd start="\<s\s*\z([!#$%&*+,.:;=?@^_|~]\)" end=/\z1/me=e-1 contains=@perlInterpSQ nextgroup=perlSubstitutionAny
syn region perlSubstitutionAny	matchgroup=perlMatchStartEnd start="\z([!#$%&*+,.:;=?@^_|~]\)" end=/\z1[ecgimosx]*/ contained contains=@perlInterpSQ

if exists("perl_fold")
    syntax region perlDATA	start=/^__END__$/ end=/^\(sub\|package\)/me=s-1 contains=perlPOD fold
else
    syntax region perlDATA	start=/^__END__$/ end=/^\(sub\|package\)/me=s-1 contains=perlPOD
endif

hi link perlFiledescStatement	Special
hi link perlFunctionName	Type
hi link perlMethod		Type
