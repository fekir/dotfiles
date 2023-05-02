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
