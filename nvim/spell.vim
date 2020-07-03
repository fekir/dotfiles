" Spell settings

:hi clear SpellBad
:hi SpellBad cterm=undercurl,bold

:hi clear SpellCap
:hi SpellCap cterm=undercurl,bold

:set spelllang=en " FIXME: would be nice to autodetect languages
:set spell " FIXME: makes little sense to enable it when opening binary file

" spellcheck settings: avoid checking urls
:syn match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell
