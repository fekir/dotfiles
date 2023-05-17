
runtime fm.vim

" Set tab width to 4 spaces (no replace)
:set tabstop=4
:set shiftwidth=0

runtime view.vim

" Enable mouse support
:set mouse=a

" disable modeline, otherwise words like ex: or vim: gets interpreted
:set nomodeline

runtime key.vim
runtime spell.vim

" diff hard to read, not a real fix
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
if has("nvim")
	set diffopt+=algorithm:patience
	if has('nvim-0.9')
		set diffopt+=linematch:60
	endif
else
	if has("win32")
		" and !has("win32unix")
		" vim in cygwin and git-bash work out of the box
		let &t_SI = "\<esc>[5 q"
		let &t_EI = "\<esc>[2 q"
	endif
	" prefer underline when in replace mode
	let &t_SR = "\<esc>[4 q"
endif

" search settings, case insensitive unless searching upper-case (make case
" sensitive with \C
:set ignorecase
:set smartcase

if has('win32')
	" actually, should check if posix shell not available but powershell (cygwin, ...)
	set shell=powershell.exe\ -NoLogo
	set shellxquote=
	let &shellcmdflag = '-NoLogo -NoProfile -NonInteractive -ExecutionPolicy RemoteSigned -Command '
	let &shellquote   = ''
	let &shellpipe    = '| Out-File -Encoding UTF8 %s'
	let &shellredir   = '| Out-File -Encoding UTF8 %s'
	if has("gui_running") " gvim
		:set noshelltemp " do not open separate cmd window when executed from gvim
	endif

	" prefer for new/empty buffer \n to \r\n also on Windows
	set fileformats=unix,dos
endif
