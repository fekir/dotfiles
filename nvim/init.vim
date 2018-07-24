:set fileencoding=utf-8 " The encoding written to file.

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
:set relativenumber

" Enable mouse support
:set mouse=a

" Listchars - how to represent whitespace
" Fixme: replace unicode chars with ascii escape sequences
" Not using whitespace as second char for tab, otherwise it gets confused with the normal whitespace
:set listchars=tab:‣·,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
:set showbreak=↪
" ascii variant
":set listchars=tab:\|_,eol:$,nbsp:~,trail:^,extends:>,precedes:<
":set showbreak=\\
:set list

" scroll up/down by screen line and not by logical line
" does not work in edit mode
:map <up> gk
:map <down> gj


" temp disable current search highlight (activates again when searching or pressing n)
:nnoremap <return> :nohlsearch<return><return>
:nnoremap <esc> :nohlsearch<return><esc>
