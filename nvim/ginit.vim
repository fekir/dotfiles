" solarized not available
:colorscheme desert

" mswin defines most keybindings used in graphical text editors,
" like undo (CTRL-Z), redo (CTRL-Y), select all (CTRL-A), copy (CTRL-C)
" paste (CTRL-V), cut (CTRL-X), save (CTRL+S)
:source $VIMRUNTIME/mswin.vim

:set title titlestring=%F
:set mouse=a

if has("nvim")
	:nnoremap <silent><RightMouse>      :call GuiShowContextMenu()<CR>
	:inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
	:xnoremap <silent><RightMouse>      :call GuiShowContextMenu()<CR>gv
	:snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv

	call GuiWindowMaximized(1)

	" Enable GUI ScrollBar
	if exists(':GuiScrollBar')
		:GuiScrollBar 1
	endif

	" Prefer graphical tabs
	if exists(':GuiTabLine')
		:GuiTabline 1
	endif

	" gui in nvim should always support utf8 symbols, even on windows
	:set listchars=tab:‣·,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
	:set showbreak=↪
elseif has("gui_running") " gvim
	if has('win32')
		:set guifont=Consolas:h13
		" gvim, windows only: https://vi.stackexchange.com/questions/1937/how-do-i-get-gvim-to-start-maximised-in-windows
		autocmd GUIEnter * simalt ~x
	endif
	" on windows
	"   :browse e
	" opens explorer file dialog for opening files
endif

" tab navigation with ctrl+tab
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>
