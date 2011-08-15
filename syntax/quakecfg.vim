" Vim syntax file
" Language:	Configuration File (ini file) for Quake
" Maintainer:	<rnd@chat.ru>
" Last change: 2001 Aug 27
" $Id: quakecfg.vim,v 1.4 2006/10/28 10:20:55 rnd Exp $

" clear any unwanted syntax defs
syn clear

" shut case off
syn case ignore

syn keyword	quakeTodo	contained TODO FIXME
syn match	quakeComment	"//.*$" contains=quakeTodo
syn region	quakeMsg	contained matchgroup=quakeQuote start=/\s\+"\=/ matchgroup=quakeQuote end=/;\|"\|$/ contains=qw262MsgMacro,qw262Var oneline
syn match	quakeString	contained /[^"][^" 	]\+/
syn match	quakeString	contained /"[^"]\+"/
syn keyword	quakeCommand	exec nextgroup=quakeString skipwhite
syn keyword	quakeCommand	say say_team echo nextgroup=quakeMsg
syn keyword	quakeCommand	alias nextgroup=quakeAlias,quakeAction skipwhite
syn keyword	quakeCommand	bind unbind nextgroup=quakeBinding skipwhite
syn keyword	quakeCommand	wait color name pause quit bgmvolume
syn keyword	quakeCommand	impulse play togglemenu toggleconsole sizeup
syn keyword	quakeCommand	sizedown screenshot
syn keyword	quakeCommand	unbindall messagemode messagemode2 fov
syn keyword	quakeCommand	sensitivity volume crosshair crosshaircolor
syn keyword	quakeCommand	record stop lookstrafe lookspring viewsize gamma
syn keyword	quakeCommand	setinfo noaim noskins show_fps
syn keyword	quakeCommand	map timelimit fraglimit
syn keyword	quakeCommand	connect password
syn keyword	qwCommand	rcon rate pushlatency topcolor bottomcolor
syn keyword	qwCommand	msg team skin localinfo serverinfo
syn match	quakeCommand	/\<\(v\|d\|m\|r\|scr\|con\|_snd\|vid\|cl\|sv\)_\w\+/
syn match	quakeBinding	contained /[^; 	]\+/
syn match	quakeAlias	contained "[^; 	+\-]\+"
syn match	quakeAction	"[+\-]\h\w*"
syn keyword	qw262Command	hud_add nextgroup=qwHud skipwhite
syn match	qwHud		contained "\h\w*" nextgroup=qwHudType skipwhite
syn keyword	qwHudType	contained str std
syn keyword	qw262Command	hud_position nextgroup=quakeAlias skipwhite
syn keyword	qw262Command	hud_bg hud_enable hud_disable nextgroup=quakeAlias skipwhite
syn keyword	qw262Command	re_trigger nextgroup=qwTriggerDef skipwhite
syn keyword	qw262Command	re_trigger_options nextgroup=qwTrigger skipwhite
syn keyword	qw262Command	re_trigger_enable re_trigger_disable skipwhite
syn keyword	qwTriggerOpt	contained final mask remove noaction notfinal noremove
\				nextgroup=qwTriggerOpt skipwhite
syn match	qwTrigger	contained "\w\+" nextgroup=qwTriggerOpt skipwhite
syn match	qwTriggerDef	contained "\w\+" nextgroup=qwRegexp skipwhite
syn region	qwRegexp	contained start="\s" end=";\|$" oneline contains=qwRegexpSpec,qw262Var
syn match	qwRegexpSpec	contained "\\\l"
syn match	qwRegexpSpec	contained /[^\\][|()]/lc=1,hs=s+1
syn keyword	qw262Command	register
syn keyword	qw262Command	set set_ex nextgroup=qw262VarName skipwhite
syn match	qw262Var	"@\w\+"
syn match	qw262VarName	"\h\w\+" contained
syn match	qw262Special	"@[-+]\d\+"
syn match	qw262Special	"@\d\+"
syn match	qw262MsgMacro	"%\a"

hi def link quakeComment	Comment
hi def link quakeMsg		String
hi def link quakeString		String
hi def link quakeAction		Type
hi def link quakeAlias		PreProc
hi def link quakeBinding	Special
hi def link quakeCommand	Statement
hi def link quakeQuote		Normal
hi def link qwCommand		Statement
hi def link quakeTodo		Todo
hi def link qw262Command	qwCommand
hi def link qwTrigger		quakeAlias
hi def link qwHud		quakeAlias
hi def link qwTriggerDef	qwTrigger
hi def link qwTriggerOpt	Type
hi def link qwHudType		Type
hi def link qw262Var		Identifier
hi def link qw262Special	Special
hi def link qwRegexpSpec	Special
hi def link qw262MsgMacro	Special
hi def link qw262VarName	Identifier

let b:current_syntax = "quake"
