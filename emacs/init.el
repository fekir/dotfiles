
; use utf-8 by default for reading and writing
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

; disable blinking cursors
(blink-cursor-mode -1)

; use alt+f4 for closing, like all other apps do, necessary for windows
(global-set-key [M-f4] 'save-buffers-kill-emacs)
