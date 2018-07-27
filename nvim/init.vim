" avoid cluttering home
:let g:netrw_home=expand('~/.cache/nvim/')
if !empty($XDG_CACHE_HOME)
  :let g:netrw_home=$XDG_CACHE_HOME.'/nvim/'
endif

" Set tab width to 4 spaces (no replace)
:set tabstop=4
:set shiftwidth=0

" Set line numbers
:set number

:set mouse=a
