set encoding=utf-8
scriptencoding utf-8

:set scrolloff=5
:set tabpagemax=500

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

:set listchars=tab:‣·,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨,conceal:*,nbsp:·
:set showbreak=↪
" Listchars - how to represent whitespace
" issues with windows cmd/powershell and UTF-8
if has('win32')
  " Not using whitespace as second char for tab, otherwise it gets confused with the normal whitespace
  :set listchars=tab:\|_,eol:¶,nbsp:~,trail:^,extends:>,precedes:<,conceal:*,nbsp:·
  :set showbreak=\\
endif
:set list

" https://vim.fandom.com/wiki/Show_fileencoding_and_bomb_in_the_status_line
if has("statusline")
  :set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
endif
