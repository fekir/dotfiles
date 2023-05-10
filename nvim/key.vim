" ease working with buffers
" notice that gb works differently in the file manager (handles bookmarks)
:set hidden
:nnoremap gb :ls<CR>:b

" use ctrl+s for saving, supposing that stty -ixon in *shrc
 noremap <silent> <C-S>              :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" use CTRL-F for searching
 noremap <expr> <C-F> "/"
inoremap <expr> <C-F> "\<C-\>\<C-O>/"
cnoremap <expr> <C-F> "\<C-\>\<C-O>/"

" scroll up/down by screen line and not by logical line
" but only in insert mode
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

if has("nvim")
	" no specific changes necessary for nvim
else
	:map  <esc>OH <home>
	:cmap <esc>OH <home>
	:imap <esc>OH <home>
	:map  <esc>OF <end>
	:cmap <esc>OF <end>
	:imap <esc>OF <end>

	if has("gui_running") " gvim
	else
		" https://vi.stackexchange.com/questions/11668/control-arrow-to-skip-over-text
		" ctrl+arrow does not work oob in insert and esc mode
		" seems that TERM=screen-color and TERM!=xterm causes this issue
		:execute "set <xUp>=\e[1;*A"
		:execute "set <xDown>=\e[1;*B"
		:execute "set <xRight>=\e[1;*C"
		:execute "set <xLeft>=\e[1;*D"
	endif
endif
