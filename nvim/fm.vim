" avoid cluttering home
:let g:netrw_home=expand('~/.cache/nvim/')
if !empty($XDG_CACHE_HOME)
  :let g:netrw_home=$XDG_CACHE_HOME.'/nvim/'
endif

" remove banner
:let g:netrw_banner = 0

" 4 open files in previous windows tab, 3 opens in new tab
:let g:netrw_browse_split = 4

" most of the time filenames are not that long (% of screen)
:let g:netrw_winsize = 20

" open on the right by default, unfortunately Vexplore! does not work anymore
:cnoreabbrev Vexplore Lexplore!
