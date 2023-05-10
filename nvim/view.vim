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

" switch to nonrelative when focus lost -> breaks welcome screen
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,WinLeave   * if &nu | set nornu | endif
augroup END

" mark "extra" whitespace as error, ie trailing whitespace of any kind, and
" space followed by tabs
:highlight ExtraWhitespace ctermbg=red guibg=red
if exists(":match") " missing from minimal vim installations
	:match ExtraWhitespace / \+\t\|\s\+$/
endif
" Listchars - how to represent whitespace
" still have open issues with windows cmd/powershell and UTF-8
if has('win32')
  " Not using whitespace as second char for tab, otherwise it gets confused with the normal whitespace
  :set listchars=tab:\|_,eol:¶,nbsp:~,trail:^,extends:>,precedes:<,conceal:*,nbsp:·
  :set showbreak=\\
else
  :set listchars=tab:‣·,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨,conceal:*,nbsp:·
  :set showbreak=↪
endif
:set list

if has("statusline")
  :set statusline=%<%f
  :set statusline+=%{&modified?\"*\":\"\"}
  :set statusline+=%{&readonly?\"\|RO\":\"\"}
  ":set statusline+=%{(&filetype==\"\"?\"\":\"\ \|\")}%{&filetype}
  :set statusline+=\ %y
  :set statusline+=%= " right-aligned
  :set statusline+=%{wordcount().words}\ words\|
  :set statusline+=%{(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\")}\| " encoding
  :set statusline+=%{&fileformat==\"dos\"?\"dos\|\":\"\"} "good enought ATM, does not show mac
  ":set statusline+=%{&fileformat==\"unix\"?\"\":&fileformat\|} " does not work as expected
  :set statusline+=ln\ %l\/%L\|col\ %c%V\|%P " ruler
endif

" show search-replace in separate window while typing
if has("nvim")
	":set inccommand=split
else
	:set laststatus=2
	:set hlsearch
	:syntax on
	" nvim does this automatically
	" in vim, this causes issues from cmd
	" powershell/gvim seem to change cursor automatically
	if has("unix")
		let &t_SI = "\<esc>[5 q"
		let &t_SR = "\<esc>[5 q"
		let &t_EI = "\<esc>[2 q"
	endif
endif
