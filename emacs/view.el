;; view related settings

;; disable blinking cursors
(blink-cursor-mode -1)
;; cursor like in other graphical/non-modal editors; a bar instead of a box
(setq-default cursor-type 'bar)

;; show line numbers by default
;(global-linum-mode)
;; show relative line numbers by default
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; remove toolbar (big gnome-like icons, menu bar should be sufficient)
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; dark mode by default
(when (display-graphic-p) ; detect if graphic or terminal emacs
  (invert-face 'default)
  (set-variable 'frame-background-mode 'dark)
)

;; disable startup screen if any argument given to Emacs
(when (cdr command-line-args)
  (setq inhibit-startup-screen t))

; M-x compile settings
; auto-scroll when using M-x compile
(setq compilation-scroll-output 1)
; support for colored output:
;  https://stackoverflow.com/questions/3072648/cucumbers-ansi-colors-messing-up-emacs-compilation-buffer/3072831#3072831
(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

(setq-default frame-title-format '("%b"))
