
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
else
	" causes issues wit vim called from cmd/directly (or powershell inside cmd), works in ps, git-bash and cygwin (+tmux, +zsh)
	if has("unix")
		" in powershell seems to change automatically
		let &t_SI = "\<esc>[5 q"
		let &t_SR = "\<esc>[5 q"
		let &t_EI = "\<esc>[2 q"
	endif
endif

" search settings, case insensitive unless searching upper-case (make case
" sensitive with \C
:set ignorecase
:set smartcase

if has('win32')
	" actually, should check if posix shell not avaiable but powershell (cygwin, ...)
	set shell=powershell.exe\ -NoLogo
	set shellxquote=
	let &shellcmdflag = '-NoLogo -NoProfile -NonInteractive -ExecutionPolicy RemoteSigned -Command '
	let &shellquote   = ''
	let &shellpipe    = '| Out-File -Encoding UTF8 %s'
	let &shellredir   = '| Out-File -Encoding UTF8 %s'
endif

nnoremap ^[[1;6I :tabprevious<CR>
nnoremap ^[[1;5I :tabnext<CR>
inoremap ^[[1;6I <Esc>:tabprevious<CR>
inoremap ^[[1;5I <Esc>:tabnext<CR>
