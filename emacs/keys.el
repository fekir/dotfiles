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

;; open context menu on right click
(when (display-graphic-p)
  (context-menu-mode))

; use alt+arrow to switch window
(windmove-default-keybindings 'meta)

;; ctrl-+ and ctrl-- like other applications
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

; Use C-, for custom key bindings
(global-set-key (kbd "C-, C-t") 'tab-new)
(global-set-key (kbd "C-, C-w") 'tab-close)
(global-set-key (kbd "C-, C-c") 'compile)
(global-set-key (kbd "C-, C-g") 'goto-line)

;; ctrl-c for stopping compilation, but only when buffer has focus
(defun my-kill-compilation ()
  (local-set-key (kbd "C-c C-c") 'kill-compilation))
(add-hook 'compilation-mode-hook #'my-kill-compilation)
