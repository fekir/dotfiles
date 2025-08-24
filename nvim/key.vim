" ease working with buffers
" notice that gb works differently in the file manager (handles bookmarks)
:set hidden
:nnoremap gb :ls<CR>:b

" use ctrl+s for saving, supposing that stty -ixon in *shrc
: noremap <silent> <C-S>      :update<CR>
:vnoremap <silent> <C-S> <C-C>:update<CR>
:inoremap <silent> <C-S> <Esc>:update<CR>gi

" use CTRL-S for saving, also in insert mode
" (<C-O> doe not work well with completions)
: noremap <C-S>      :update<CR>
:vnoremap <C-S> <C-C>:update<CR>
:cnoremap <C-S> <Esc>:update<CR>gi

" use CTRL-F for searching
: noremap <expr> <C-F> "/"
:inoremap <expr> <C-F> "\<C-\>\<C-O>/"
:cnoremap <expr> <C-F> "\<C-\>\<C-O>/"

" use CTRL-L like easy-vim (vim-only) for consistency
if &insertmode
  " easy mode _probably_ enabled, to nothing as <esc> does not work
else
  :inoremap <C-L> <Esc>
endif

" use F10 for closing, like mc
" does not work that well when using -R or -m
: noremap <F10>      :confirm quitall<enter>
:inoremap <F10> <esc>:confirm quitall<enter>
:cnoremap <F10> <esc>:confirm quitall<enter>

" use ctrl+w for managing windows also in insert mode
" unfortunately exits from insert mode
:inoremap <C-w> <esc><C-w>

" scroll up/down by screen line and not by logical line
" but only in insert mode
:noremap <up>   gk
:noremap <down> gj

" use U for undoing undo (redo)
" prevent to use U by accident to introduce new change
:nnoremap U <C-R>

" newline from normal mode
:nnoremap ,o o<esc>
" missing showbreak
:nnoremap <silent> ,p :set number!<enter>:set relativenumber!<enter>:set list!<enter>

if exists(':nohlsearch')
	" missing on vim.tiny
	" temp disable current search highlight (activates again when searching or pressing n)
	:nnoremap <silent> <return> :nohlsearch<return><return>
	:nnoremap <silent> <esc>    :nohlsearch<return><esc>
endif

if has("nvim")
	" in terminal mode, press esc to get normal mode
	:tnoremap <Esc> <C-\><C-n>
	" and ctrl-v esc (mnemonic: Verbatim Escape), to send esc to underlying program
	:tnoremap <C-v><Esc> <Esc>

	" relevant only for windows in cmd/powershell
	if has('win32')
		:execute 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
	endif

else
	: noremap <esc>OH <home>
	:lnoremap <esc>OH <home>
	: noremap <esc>OF <end>
	:lnoremap <esc>OF <end>
	" should not be necessary, but vim packaged for git
	" has issues with term set to screen/tmux
	:inoremap <esc>OH <home>
	:inoremap <esc>OF <end>

	if has("gui_running") " gvim
	else
		" https://vi.stackexchange.com/questions/11668/control-arrow-to-skip-over-text
		" ctrl+arrow does not work oob in insert and normal mode
		" seems that TERM=screen-color and TERM!=xterm causes this issue
		:execute "set <xUp>=\e[1;*A"
		:execute "set <xDown>=\e[1;*B"
		:execute "set <xRight>=\e[1;*C"
		:execute "set <xLeft>=\e[1;*D"
	endif
endif
