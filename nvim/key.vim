" use ctrl+s for saving, supposing that stty -ixon in *shrc
noremap  <silent> <C-S>              :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" use CTRL-F for searching
noremap  <expr> <C-F> "/"
inoremap <expr> <C-F> "\<C-\>\<C-O>/"
cnoremap <expr> <C-F> "\<C-\>\<C-O>/"

" scroll up/down by screen line and not by logical line
" does not work in edit mode
:map <up> gk
:map <down> gj

" use U for undoing undo (redo)
" prevent to use U by accident to introduce new change
nnoremap U <C-R>

if has("nvim")
	" temp disable current search highlight (activates again when searching or pressing n)
	:nnoremap <return> :nohlsearch<return><return>
	:nnoremap <esc> :nohlsearch<return><esc>

	" in terminal mode, press esc to get normal mode
	:tnoremap <Esc> <C-\><C-n>
	" and ctrl-v esc (mnemonic: Verbatim escape), to send esc to underlying program
	:tnoremap <C-v><Esc> <Esc>
endif
