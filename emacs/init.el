;; conditionally convert windows paths to cygwin
(when (and (cdr command-line-args) (fboundp 'cygwin-convert-file-name-from-windows))
  (let ((args command-line-args) processed-args)
    ;; process each arg
    (while args
      (let ((arg (pop args)))
        ;; FIXME: cygwin-convert might be slow, and relative paths with '/' works -> apply only if arg contains '\' or drive letter
        (if (and (stringp arg) (file-exists-p (cygwin-convert-file-name-from-windows arg)))
          (progn
            (setq arg (cygwin-convert-file-name-from-windows arg))
            (push arg processed-args)
          )
          (push arg processed-args)
        )
      )
    )
    (setq command-line-args (nreverse processed-args))
  )
)

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

; FIXME: XDG_CACHE_HOME could have windows path
(defvar xdg-cache-home (or (getenv "XDG_CACHE_HOME") (expand-file-name "~/.cache"))
  "XDG_CACHE_HOME, defaults to ~/.cache")

;; save history of minibuffer between instances
(setq savehist-file (expand-file-name "emacs-savehist" xdg-cache-home))
(setq history-length 250)
(savehist-mode 1)

;; open recent files
(setq recentf-save-file (expand-file-name "emacs-recentf" xdg-cache-home))
(recentf-mode 1)

;; Write temporary files to separate directory
(let ((emacs-auto-save-dir (expand-file-name "emacs-auto-save/" xdg-cache-home)))
	(if (not (file-exists-p emacs-auto-save-dir))
	  (make-directory emacs-auto-save-dir t))
	(setq auto-save-file-name-transforms `((".*" ,emacs-auto-save-dir t)))
)

(let ((emacs-backup-dir (expand-file-name "emacs-backup/" xdg-cache-home)))
	(if (not (file-exists-p emacs-backup-dir))
	  (make-directory emacs-backup-dir t))
	(setq backup-directory-alist `((".*" ,emacs-backup-dir t)))
	;; copy file instead of moving during backup
	;;(setq backup-by-copying t)
	;; disable backup files
	;;(setq make-backup-files nil)
)

(let ((emacs-lock-dir (expand-file-name "emacs-lock/" xdg-cache-home)))
	(if (not (file-exists-p emacs-lock-dir))
	  (make-directory emacs-lock-dir t))
	(setq lock-file-name-transforms `((".*" ,emacs-lock-dir t)))
)

;; where to get plugins

(setq package-archives
 '(("gnu" . "http://elpa.gnu.org/packages/")
  ("melpa" . "http://melpa.org/packages/")))
