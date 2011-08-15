" Language:	XFree86 configuration file
" Maintainer:	rnd <rnd@softhome.net>
" Last change:	August 7, 2000

syn clear
syn case ignore

syn match xf86Comment	/#.*/
syn region xf86FilesSection	contains=xf86Comment,xf86Files,xf86String keepend matchgroup=xf86SectKeyword start=/Section\s\+"Files"/me=s+7 end=/EndSection/
syn region xf86SrvFlagsSection	contains=xf86Comment,xf86SrvFlags,xf86String keepend matchgroup=xf86SectKeyword start=/Section\s\+"ServerFlags"/ end=/EndSection/
syn region xf86KeyboardSection	contains=xf86Comment,xf86Keyboard,xf86String keepend matchgroup=xf86SectKeyword start=/Section\s\+"Keyboard"/ end=/EndSection/
syn region xf86PointerSection	contains=xf86Comment,xf86Pointer,xf86String keepend matchgroup=xf86SectKeyword start=/Section\s\+"Pointer"/ end=/EndSection/
syn region xf86MonitorSection	contains=xf86Comment,xf86Monitor,xf86String keepend matchgroup=xf86SectKeyword start=/Section\s\+"Monitor"/ end=/EndSection/
syn region xf86DeviceSection	contains=xf86Comment,xf86Device,xf86String keepend matchgroup=xf86SectKeyword start=/Section\s\+"Device"/ end=/EndSection/
syn region xf86ScreenSection	contains=xf86DisplaySection,xf86Comment,xf86Screen,xf86String keepend matchgroup=xf86SectKeyword start=/Section\s\+"Screen"/ end=/EndSection/
syn region xf86DisplaySection	contains=xf86Comment,xf86Display,xf86String contained keepend matchgroup=xf86SectKeyword start=/SubSection\s\+"Display"/ end=/EndSubSection/
syn region xf86String	start=/"/  skip=/\\"/  end=/"/
syn keyword xf86Files	FontPath RgbPath contained
syn keyword xf86Keyboard	contained Protocol LeftAlt RightAlt RightCtl
\		ScrollLock
syn keyword xf86Keyboard	contained XLeds AutoRepeat
syn match xf86Keyboard	/Xkb[a-zA-Z]\+/ contained
syn keyword xf86Pointer	Protocol Device BaudRate contained
syn keyword xf86Pointer	Emulate3Buttons Emulate3Timeout contained
syn keyword xf86Pointer	Resolution Buttons contained
syn keyword xf86Monitor	Identifier VendorName ModelName contained
syn keyword xf86Monitor	HorizSync VertRefresh contained
syn match xf86Monitor	/Modeline\s.*/he=s+8 contained contains=xf86String,xf86MModifier
syn keyword xf86MModifier	hsync vsync doublescan contained
syn keyword xf86Device	Identifier VendorName BoardName contained
syn keyword xf86Screen	Driver Device Monitor contained
syn keyword xf86Screen	DefaultColorDepth contained
syn keyword xf86Display	Depth Modes contained

if !exists("did_xf86config_syntax_inits")
    let did_xf86config_syntax_inits = 1

    hi link xf86Comment	Comment
    hi link xf86Keyword	Statement
    hi link xf86Files	xf86Keyword
    hi link xf86SrvFlags	xf86Keyword
    hi link xf86Keyboard	xf86Keyword
    hi link xf86Pointer	xf86Keyword
    hi link xf86Monitor	xf86Keyword
    hi link xf86Device	xf86Keyword
    hi link xf86Screen	xf86Keyword
    hi link xf86Display	xf86Keyword
    hi link xf86MModifier	Type
    hi link xf86String	String
    hi link xf86SectKeyword	Identifier
endif

let b:current_syntax = "xf86config"

" vim: ts=17
