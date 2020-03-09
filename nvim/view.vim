
:set scrolloff=5

" Set line numbers
:set number
:set relativenumber

" highlight current one
:highlight CursorLineNr cterm=bold ctermfg=012
":highlight LineNr cterm=bold ctermfg=012 " applies to all lines :-( should fill a bug?
" FIXME CursorLineNr should works without setting cursorline, but then only with relativenumber
" thus remove underline
:highlight clear CursorLine
:set cursorline

" switch to nonrelative when focus lost
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,WinLeave   * if &nu | set nornu | endif
augroup END

" Listchars - how to represent whitespace
" Fixme: replace unicode chars with ascii escape sequences
" Not using whitespace as second char for tab, otherwise it gets confused with the normal whitespace
:set listchars=tab:‣·,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
:set showbreak=↪
" ascii variant, check https://github.com/neovim/neovim/issues/9937 and https://github.com/neovim/neovim/issues/3902
" for setting it as fallback
":set listchars=tab:\|_,eol:$,nbsp:~,trail:^,extends:>,precedes:<
":set showbreak=\\
:set list

" https://vim.fandom.com/wiki/Show_fileencoding_and_bomb_in_the_status_line
if has("statusline")
  :set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
endif

