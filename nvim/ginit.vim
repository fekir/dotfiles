" solarized not avaiable
:colorscheme desert

" gui should always support utf8 symbols, even on windows
:set listchars=tab:‣·,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
:set showbreak=↪

" mswin defines most keybindings used in graphical text editors,
" like undo (CTRL-Z), redo (CTRL-Y), select all (CTRL-A), copy (CTRL-C)
" paste (CTRL-V), cut (CTRL-X), save (CTRL+S)
source $VIMRUNTIME/mswin.vim
