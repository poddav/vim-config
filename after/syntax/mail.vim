" extend mail syntax
" $Id: mail.vim,v 1.1 2006/10/28 10:13:26 rnd Exp $

syn clear mailQuoted1
syn clear mailQuoted2
syn clear mailQuoted3
syn clear mailQuoted4
syn clear mailQuoted5
syn clear mailQuoted6

syn match mailQuoted1	"^\s\{,2}\([A-Za-z]\+>\|[]|>]\).*$"
syn match mailQuoted2	"^\s\{,2}\(\([A-Za-z]\+>\|[]|>]\)[ \t]*\)\{2}.*$"
syn match mailQuoted3	"^\s\{,2}\(\([A-Za-z]\+>\|[]|>]\)[ \t]*\)\{3}.*$"
syn match mailQuoted4	"^\s\{,2}\(\([A-Za-z]\+>\|[]|>]\)[ \t]*\)\{4}.*$"
syn match mailQuoted5	"^\s\{,2}\(\([A-Za-z]\+>\|[]|>]\)[ \t]*\)\{5}.*$"
syn match mailQuoted6	"^\s\{,2}\(\([A-Za-z]\+>\|[]|>]\)[ \t]*\)\{6}.*$"
