" Spell settings

:hi clear SpellBad
" gui=underline works in tmux only if set accordingly, guisp=red works currently only outside of tmux
:hi SpellBad cterm=undercurl gui=underline guisp=red

:hi clear SpellCap
:hi SpellCap cterm=undercurl,bold gui=underline guisp=red

:set spelllang=en " FIXME: would be nice to autodetect languages
:set spell " FIXME: makes little sense to enable it when opening binary file
":set termguicolors

"" Both do not seems to work from the configuration file, but if given manually yes

" spellcheck settings: avoid checking urls
:syn match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell

" Don't count acronyms / abbreviations as spelling errors
" (all upper-case letters, at least three characters)
" Also will not count acronym with 's' at the end a spelling error
" Also will not count numbers that are part of this
" Recognizes the following as correct:
:syn match AcronymNoSpell '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell
