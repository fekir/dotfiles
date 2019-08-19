" solarized not avaiable
:colorscheme desert

" gui should always support utf8 symbols, evne on windows
:set listchars=tab:‣·,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
:set showbreak=↪

" copy and paste like in gui programs, middlemouse works OOB
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa
