" avoid cluttering home

if has("nvim")
	" https://github.com/neovim/neovim/issues/12161
else
	if empty($XDG_CACHE_HOME)  | let $XDG_CACHE_HOME  = $HOME."/.cache"       | endif
	if empty($XDG_CONFIG_HOME) | let $XDG_CONFIG_HOME = $HOME."/.config"      | endif
	if empty($XDG_DATA_HOME)   | let $XDG_DATA_HOME   = $HOME."/.local/share" | endif
	if empty($XDG_STATE_HOME)  | let $XDG_STATE_HOME  = $HOME."/.local/state" | endif

	:let g:netrw_home=$XDG_CACHE_HOME.'/nvim/'

	:set directory="$XDG_CACHE_HOME/vim/swap//" | call mkdir(&directory, 'p')
	:set backupdir="$XDG_CACHE_HOME/vim/backup//" | call mkdir(&backupdir, 'p')
	:set undodir="$XDG_DATA_HOME/nvim/undo//" | call mkdir(&undodir,   'p')
	:set viewdir="$XDG_DATA_HOME/nvim/view//" | call mkdir(&undodir,   'p')
endif

" remove banner
:let g:netrw_banner = 0

" 4 open files in previous windows tab, 3 opens in new tab
:let g:netrw_browse_split = 3

" most of the time filenames are not that long (% of screen)
:let g:netrw_winsize = 20

:let g:netrw_liststyle = 3
