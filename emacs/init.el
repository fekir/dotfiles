(load "~/.config/emacs/view.el")

;; ------------------------------------
;; behavioural changes

; use alt+F4 for closing, might want to restrict on windows
; as in gnome/kde/mate work oob
(global-set-key [M-f4] 'save-buffers-kill-emacs)

; https://www.emacswiki.org/emacs/CuaMode
 (cua-mode t)
 (setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
 (transient-mark-mode 1) ;; No region when it is not highlighted
 (setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

;; use utf-8 by default for reading and writing, Windows included
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)

;; disable startup screen
;(setq inhibit-startup-screen t)

;; save history of minibuffer between instances
(setq history-length 25)
(savehist-mode 1)


;; Write auto-saves and backups to separate directory.
; FIXME: query XDG directory
(make-directory "~/.cache/emacs-auto-save/" t)
(setq auto-save-file-name-transforms '((".*" "~/.cache/emacs-auto-save/" t)))
(setq backup-directory-alist '(("." . "~/.cache/emacs-backup/")))
;; disable backup files (files affixed with ~)
(setq make-backup-files nil)
