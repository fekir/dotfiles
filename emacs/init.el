;; load custom config files


(load "~/.config/emacs/functions.el")
(load "~/.config/emacs/view.el")
(load "~/.config/emacs/keys.el")

;; ------------------------------------
;; behavioural changes

(when scroll-bar-mode
   (setq scroll-step 1) ; scroll like other applications
   (setq scroll-margin 3)
)
;; (setq pixel-scroll-precision-mode t) ; scroll by pixel and not lines, might be useful for images

;; use utf-8 by default for reading and writing, Windows included
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)

;; files should end with newline
(setq require-final-newline t)

;; save history of minibuffer between instances
(setq history-length 250)
(savehist-mode 1)

;; Write auto-saves and backups to separate directory.
; FIXME: query XDG directory
(make-directory "~/.cache/emacs-auto-save/" t)
(make-directory "~/.cache/emacs-backup/" t)
(setq auto-save-file-name-transforms '((".*" "~/.cache/emacs-auto-save/" t)))
(setq backup-directory-alist '(("." . "~/.cache/emacs-backup/")))
;; copy file instead of moving during backup
;;(setq backup-by-copying t)
;; disable backup files
(setq make-backup-files nil)
