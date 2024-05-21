" To keep vim and nvim in sync
" ln -s ~/.config/nvim/ ~/.vim
" on windows, for covering "native" and cygwin-like
" junction C:\Users\xxx\.vim C:\Users\xxx\.config\nvim\
" junction C:\Users\xxx\vimfiles C:\Users\xxx\.config\nvim\
" junction C:\Users\xxx\AppData\Local\nvim C:\Users\xxx\.config\nvim\
" (also mklink /J from cmd works)
" from vimrc:
"     :source ~/.config/nvim/init.vim
" from gvimrc:
"     :source ~/.config/nvim/init.vim
"     :source ~/.config/nvim/ginit.vim


runtime fm.vim
if filereadable('/usr/share/doc/fzf/examples/fzf.vim')
	source /usr/share/doc/fzf/examples/fzf.vim
end

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
"highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
if has("nvim")
	set diffopt+=algorithm:patience
	if has('nvim-0.9')
		set diffopt+=linematch:60
	endif
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
