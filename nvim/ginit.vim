" solarized not avaiable
:colorscheme desert

" gui should always support utf8 symbols, even on windows
:set listchars=tab:‣·,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
:set showbreak=↪

" mswin defines most keybindings used in graphical text editors,
" like undo (CTRL-Z), redo (CTRL-Y), select all (CTRL-A), copy (CTRL-C)
" paste (CTRL-V), cut (CTRL-X), save (CTRL+S)
:source $VIMRUNTIME/mswin.vim

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
endif
