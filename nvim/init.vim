
" avoid cluttering home
:let g:netrw_home=expand('~/.cache/nvim/')
if !empty($XDG_CACHE_HOME)
  :let g:netrw_home=$XDG_CACHE_HOME.'/nvim/'
endif
" other file manager settings
:let g:netrw_banner = 0
 " 4 open files in preivous windows tab, 3 opens in new tab
:let g:netrw_browse_split = 4
" most of the time filenames are not that long
:let g:netrw_winsize = 20
 " open on the right by default, unfortunately Vexplore! does not work anymore
 :cnoreabbrev Vexplore Lexplore!

" Set tab width to 4 spaces (no replace)
:set tabstop=4
:set shiftwidth=0

" Set line numbers
:set number
:set relativenumber

" Enable mouse support
:set mouse=a

" disable modeline, otherise words like ex: or vim: gets interpreted
:set nomodeline

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

" scroll up/down by screen line and not by logical line
" does not work in edit mode
:map <up> gk
:map <down> gj


" temp disable current search highlight (activates again when searching or pressing n)
:nnoremap <return> :nohlsearch<return><return>
:nnoremap <esc> :nohlsearch<return><esc>

" Spell settings
:hi clear SpellBad
:hi clear SpellCap
:hi SpellBad cterm=underline,bold
:hi SpellCap cterm=underline,bold
" https://github.com/neovim/neovim/issues/7479
:hi SpellCap cterm=underline,bold
:hi SpellBad cterm=underline,bold
:set spelllang=en " FIXME: would be nice to autodetect languages
:set spell " FIXME: makes little sense to enable it when opening binary file

" spellcheck settings: avoid checking urls
:syn match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell

" diff hard to read, not a real fix
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
set diffopt+=algorithm:patience

" in terminal mode, press esc to get normal mode
tnoremap <Esc> <C-\><C-n>
" and ctrl-v esc (mnemonic: Verbatim escape), to send esc to underlygin program
tnoremap <C-v><Esc> <Esc>

" https://vim.fandom.com/wiki/Show_fileencoding_and_bomb_in_the_status_line
if has("statusline")
  :set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
endif
