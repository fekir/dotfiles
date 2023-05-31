(load "~/.config/emacs/view.el")
(load "~/.config/emacs/keys.el")

;; ------------------------------------
;; behavioural changes

;; use utf-8 by default for reading and writing, Windows included
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)


;; save history of minibuffer between instances
(setq history-length 250)
(savehist-mode 1)

;; Write auto-saves and backups to separate directory.
; FIXME: query XDG directory
(make-directory "~/.cache/emacs-auto-save/" t)
(setq auto-save-file-name-transforms '((".*" "~/.cache/emacs-auto-save/" t)))
(setq backup-directory-alist '(("." . "~/.cache/emacs-backup/")))
;; disable backup files (files affixed with ~)
(setq make-backup-files nil)
