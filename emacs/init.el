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
(load "~/.config/emacs/paths.el")
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

(ido-mode t)


;; where to get plugins

(setq package-archives
 '(("gnu" . "http://elpa.gnu.org/packages/")
  ("melpa" . "http://melpa.org/packages/")))
