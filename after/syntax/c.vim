" Vim syntax file
" Last change:	2014 Jul 15
" $Id: c.vim,v 1.3 2006/10/28 10:19:22 rnd Exp $

" this is missing from official c.vim
syn keyword	cConstant	LC_MESSAGES

" standard functions
syn keyword	cFunction	memset memcpy memcmp strlen strcpy strcmp printf assert

syn match	cFormat		display /%\d\+%/ contained

" Compiler extensions
syn keyword	cStatement	__attribute__ __volatile__ __declspec
syn keyword	cStatement	__asm__

syn clear	cParen
syn region	cParen		transparent start='(' end=')' contains=ALLBUT,@cParenGroup,cCppParen,cCppString,@Spell,cInlineAsm,cInlineGNUAsm,cGAsmString,@x86Asm,@GNUAsm
syn clear	cDefine
syn region	cDefine		start="^\s*\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$" keepend contains=ALLBUT,@cPreProcGroup,@Spell,cInlineAsm,cInlineGNUAsm,@x86Asm,@GNUAsm

syn include     @x86Asm		syntax/asmintel.vim
syn case match
syn keyword	cAsmStatement	__asm nextgroup=cInlineAsm skipwhite
syn region	cInlineAsm	contained keepend start=/{/ end=/}/ contains=@x86Asm,cNumber,cComment,cCommentL containedin=cAsmStatement

"syn include	@GNUAsm		syntax/asmgnu.vim
"syn case match
"syn keyword	cGAsmStatement	__asm__ nextgroup=cInlineGNUAsm skipwhite
"syn region	cInlineGNUAsm	contained keepend start=/(/ end=/)/ contains=cGAsmString,cComment,cCommentL
"syn region	cGAsmString	contained keepend start=/"/rs=e+1 end=/"/re=s-1 contains=@GNUAsm,cSpecial

" various ISO/POSIX types
syn match	cType		/\<\l\i*_t\>/
syn keyword	cConstant	O_RDONLY O_WRONLY O_TRUNC O_CREAT O_APPEND O_RDWR O_EXCL
syn keyword	cConstant	FD_READ FD_WRITE FD_ACCEPT FD_CONNECT FD_CLOSE FD_READ_BIT FD_WRITE_BIT
syn keyword	cConstant	AF_UNSPEC AF_INET AF_INET6 SOCK_STREAM SOCK_DGRAM SOCK_RAW
syn keyword	cConstant	IPPROTO_TCP IPPROTO_ICMP IPPROTO_UDP IPPROTO_ICMPV6 AI_PASSIVE
syn keyword	cConstant	EWOULDBLOCK WSAEWOULDBLOCK

syn match	cIdentifier	/\<\%(Enter\|Leave\|TryEnter\)CriticalSection\>/

" win32 macros
syn match	cIdentifier	/\<HKEY_\%(CLASSES_ROOT\|CURRENT_USER\|LOCAL_MACHINE\|USERS\)/
syn keyword	cIdentifier	SUCCEEDED FAILED TRUE FALSE INVALID_HANDLE_VALUE NO_ERROR
syn keyword	cIdentifier	SOCKET_ERROR INVALID_SOCKET WSA_INVALID_EVENT
syn keyword	cDefine		WINAPI

" win32 types
syn keyword	cType		CHAR UCHAR WCHAR TCHAR BSTR LPCSTR LPCWSTR LPCTSTR LPSTR LPWSTR LPTSTR
syn keyword	cType		SHORT USHORT LONG ULONG DWORD INT UINT BOOL LONGLONG ULONGLONG
syn keyword	cType		LARGE_INTEGER UINT_PTR LPVOID
syn keyword	cType		MSG WPARAM LPARAM RECT LPRECT FILETIME SYSTEMTIME DATE
syn keyword	cType		HANDLE HINSTANCE HMODULE HWND HDC HGLRC HMENU HICON HCURSOR HBRUSH
syn keyword	cType		HKEY HGLOBAL HLOCAL HRESULT SOCKET WSAEVENT SOCKADDR_IN

" win32 constants
syn keyword	cConstant	MAX_PATH
syn keyword	cConstant	IDOK IDCANCEL IDABORT IDRETRY IDIGNORE IDYES IDNO IDCLOSE IDHELP
syn keyword	cConstant	WM_ACTIVATE WM_CLOSEWM_QUIT WM_ERASEBKGND WM_ACTIVATE
	    \ WM_ACTIVATEAPP WM_AFXFIRST WM_AFXLAST WM_APP WM_ASKCBFORMATNAME
	    \ WM_CANCELJOURNAL WM_CANCELMODE WM_CAPTURECHANGED WM_CHANGECBCHAIN
	    \ WM_CHAR WM_CHARTOITEM WM_CHILDACTIVATE WM_CLEAR WM_CLOSE
	    \ WM_COMMNOTIFY WM_COMPACTING WM_COMPAREITEM WM_CONTEXTMENU WM_COPY WM_COPYDATA
	    \ WM_CREATE WM_CTLCOLORBTN WM_CTLCOLORDLG WM_CTLCOLOREDIT WM_CTLCOLORLISTBOX
	    \ WM_CTLCOLORMSGBOX WM_CTLCOLORSCROLLBAR WM_CUT WM_DEADCHAR WM_DELETEITEM
	    \ WM_DESTROY WM_DESTROYCLIPBOARD WM_DEVICECHANGE WM_DEVMODECHANGE
	    \ WM_DISPLAYCHANGE WM_DRAWCLIPBOARD WM_DRAWITEM WM_DROPFILES WM_ENABLE
	    \ WM_ENDSESSION WM_ENTERIDLE WM_ENTERMENULOOP WM_ENTERSIZEMOVE WM_EXITMENULOOP
	    \ WM_EXITSIZEMOVE WM_FONTCHANGE WM_GETDLGCODE WM_GETFONT WM_GETHOTKEY WM_GETICON
	    \ WM_GETMINMAXINFO WM_GETTEXT WM_GETTEXTLENGTH WM_HANDHELDFIRST WM_HANDHELDLAST
	    \ WM_HELP WM_HOTKEY WM_HSCROLL WM_HSCROLLCLIPBOARD WM_ICONERASEBKGND
	    \ WM_INITDIALOG WM_INITMENU WM_INITMENUPOPUP WM_INPUTLANGCHANGE
	    \ WM_INPUTLANGCHANGEREQUEST WM_KEYDOWN WM_KEYLAST WM_KEYUP WM_KILLFOCUS
	    \ WM_LBUTTONDBLCLK WM_LBUTTONDOWN WM_LBUTTONUP WM_MBUTTONDBLCLK WM_MBUTTONDOWN
	    \ WM_MBUTTONUP WM_MDIACTIVATE WM_MDICASCADE WM_MDICREATE WM_MDIDESTROY
	    \ WM_MDIGETACTIVE WM_MDIICONARRANGE WM_MDIMAXIMIZE WM_MDINEXT WM_MDIREFRESHMENU
	    \ WM_MDIRESTORE WM_MDISETMENU WM_MDITILE WM_MEASUREITEM WM_MENUCHAR
	    \ WM_MENUSELECT WM_MOUSEACTIVATE WM_MOUSEHOVER WM_MOUSELEAVE WM_MOUSEMOVE
	    \ WM_MOUSEWHEEL WM_MOVE WM_MOVING WM_NCACTIVATE WM_NCCALCSIZE WM_NCCREATE
	    \ WM_NCDESTROY WM_NCLBUTTONDBLCLK WM_NCLBUTTONDOWN WM_NCLBUTTONUP
	    \ WM_NCMBUTTONDBLCLK WM_NCMBUTTONDOWN WM_NCMBUTTONUP WM_NCMOUSEMOVE WM_NCPAINT
	    \ WM_NCRBUTTONDBLCLK WM_NCRBUTTONDOWN WM_NCRBUTTONUP WM_NEXTDLGCTL WM_NEXTMENU
	    \ WM_NOTIFY WM_NOTIFYFORMAT WM_NULL WM_PAINT WM_PAINTCLIPBOARD WM_PAINTICON
	    \ WM_PALETTECHANGED WM_PALETTEISCHANGING WM_PASTE WM_PENWINFIRST WM_PENWINLAST
	    \ WM_POWER WM_POWERBROADCAST WM_PRINT WM_PRINTCLIENT WM_QUERYDRAGICON
	    \ WM_QUERYENDSESSION WM_QUERYNEWPALETTE WM_QUERYOPEN WM_QUEUESYNC WM_QUIT
	    \ WM_RBUTTONDBLCLK WM_RBUTTONDOWN WM_RBUTTONUP WM_RENDERALLFORMATS
	    \ WM_RENDERFORMAT // WM_SETCURSOR WM_SETFOCUS WM_SETFONT WM_SETHOTKEY WM_SETICON
	    \ WM_SETREDRAW WM_SETTEXT WM_SETTINGCHANGE WM_SHOWWINDOW WM_SIZE
	    \ WM_SIZECLIPBOARD WM_SIZING WM_SPOOLERSTATUS WM_STYLECHANGED WM_STYLECHANGING
	    \ WM_SYNCPAINT WM_SYSCHAR WM_SYSCOLORCHANGE WM_SYSCOMMAND WM_SYSDEADCHAR
	    \ WM_SYSKEYDOWN WM_SYSKEYUP WM_TCARD WM_THEMECHANGED WM_TIMECHANGE WM_TIMER
	    \ WM_UNDO WM_USER WM_USERCHANGED WM_VKEYTOITEM WM_VSCROLL WM_VSCROLLCLIPBOARD
	    \ WM_WINDOWPOSCHANGED WM_WINDOWPOSCHANGING WM_COMMAND

hi link cIdentifier	Identifier
hi link cFunction	Function
hi link cAsmStatement	cStatement
hi link cGAsmStatement	cStatement
hi link cAsmAttributes	cStatement
