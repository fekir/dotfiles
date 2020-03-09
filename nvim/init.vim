
runtime fm.vim

" Set tab width to 4 spaces (no replace)
:set tabstop=4
:set shiftwidth=0

runtime view.vim

" Enable mouse support
:set mouse=a

" disable modeline, otherise words like ex: or vim: gets interpreted
:set nomodeline

runtime key.vim

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

