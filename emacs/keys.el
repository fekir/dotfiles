;; settings related to keybindings

; use alt+F4 for closing emacs on Windows too
; in gnome/kde/mate/... it works out of the box
 (global-set-key [M-f4] 'save-buffers-kill-emacs)

; ignore ctrl+win on Windows too
; combination is used on Windows for switching between virtual desktops
 (global-set-key (kbd "<C-lwindow>") 'ignore)
; on Linux, apps seems to be mapped directly to M-x
 (global-set-key (kbd "<apps>") 'ignore)



; https://www.emacswiki.org/emacs/CuaMode
 (cua-mode t)
 (setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
 (transient-mark-mode 1) ;; No region when it is not highlighted
 (setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

; use alt+arrow to switch window
(windmove-default-keybindings 'meta)

; Use C-, for own key bindings
(global-set-key (kbd "C-, C-t") 'tab-new)
(global-set-key (kbd "C-, C-c") 'compile)
