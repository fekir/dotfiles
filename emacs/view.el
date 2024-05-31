;; view related settings

;; disable blinking cursors
(blink-cursor-mode -1)
;; cursor like in other graphical/non-modal editors; a bar instead of a box
(setq-default cursor-type 'bar)
;; wrap lines by word and not character
(setq-default word-wrap t)

(defun fek-file-view ()
  "change view for real file: line numbers, trailing space, ...
Do not do it for compilation/term mode as it has performance issue
Also in calendar it looks bad
"
  (setq show-trailing-whitespace t)
  ;; show line numbers
  (setq display-line-numbers-type 'relative)
  (display-line-numbers-mode 1)
  (setq indicate-empty-lines t)
  )
(add-hook 'find-file-hook 'fek-file-view)

;; remove toolbar (big gnome-like icons, menu bar should be sufficient)
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; dark mode by default on graphical emacs
(when (display-graphic-p)
  (load-theme 'tango-dark)
  ;;(load-theme 'wombat)
  ;; in case theme is not available
  ;; (invert-face 'default)
  ;;(set-variable 'frame-background-mode 'dark)
)

;; disable startup screen if any argument given to Emacs
(when (cdr command-line-args)
	(setq inhibit-startup-screen t)
)
;; show some help
(add-hook 'after-init-hook 'help-quick)

; really slow, at least on windows
; https://emacs.stackexchange.com/questions/52227/emacs-shell-slow-compile
; M-x compile settings
; auto-scroll when using M-x compile
;(setq compilation-scroll-output 'first-error) ; does not seem to work
(setq compilation-scroll-output t)
; support for colored output:
;  https://stackoverflow.com/questions/3072648/cucumbers-ansi-colors-messing-up-emacs-compilation-buffer/3072831#3072831
(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

;; syntax highlighting for all languages by default
;; https://www.emacswiki.org/emacs/GenericMode
(require 'generic-x)

;; show file name in title bar
(setq frame-title-format
	'(:eval (if (buffer-file-name)(abbreviate-file-name (buffer-file-name))"%b"))
)

;; (add-hook 'compilation-mode-hook 'fek-inhibit-global-linum-mode)
;; (add-hook 'term-mode-hook 'fek-inhibit-global-linum-mode)
