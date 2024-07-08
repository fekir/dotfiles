; FIXME: XDG_CACHE_HOME could have windows path
(defvar xdg-cache-home (or (getenv "XDG_CACHE_HOME") (expand-file-name "~/.cache/"))
  "XDG_CACHE_HOME, defaults to ~/.cache")

;; save history of minibuffer between instances
(setq savehist-file (expand-file-name "emacs-savehist" xdg-cache-home))
(setq history-length 250)
(savehist-mode 1)

;; open recent files
(setq recentf-save-file (expand-file-name "emacs-recentf" xdg-cache-home))
(recentf-mode 1)

(setq ido-save-directory-list-file (expand-file-name "emacs-ido-last" xdg-cache-home))

;; Write temporary files to separate directory
(let ((emacs-auto-save-dir (expand-file-name "emacs-auto-save/" xdg-cache-home)))
  (if (not (file-exists-p emacs-auto-save-dir))
    (make-directory emacs-auto-save-dir t))
  (setq auto-save-file-name-transforms `((".*" ,emacs-auto-save-dir t)))
  (print auto-save-file-name-transforms #'external-debugging-output)
)

;(defvar --backup-directory (concat user-emacs-directory "backups"))
;(if (not (file-exists-p --backup-directory))
;        (make-directory --backup-directory t))
;(setq backup-directory-alist `(("." . ,--backup-directory)))

(let ((emacs-backup-dir (expand-file-name "emacs-backup/" xdg-cache-home)))
  (if (not (file-exists-p emacs-backup-dir))
    (make-directory emacs-backup-dir t))
  (setq backup-directory-alist `((".*" . ,emacs-backup-dir)))
  ;; copy file instead of moving during backup
  ;;(setq backup-by-copying t)
  ;; disable backup files
  ;;(setq make-backup-files nil)
  (setq version-control t     ;; Use version numbers for backups.
    kept-new-versions 10  ;; Number of newest versions to keep.
    kept-old-versions 0   ;; Number of oldest versions to keep.
    ;delete-old-versions t ;; Don't ask to delete excess backup versions.
    backup-by-copying t  ;; Copy all files, don't rename them.
    vc-make-backup-files t
  )
)

(let ((emacs-lock-dir (expand-file-name "emacs-lock/" xdg-cache-home)))
  (if (not (file-exists-p emacs-lock-dir))
    (make-directory emacs-lock-dir t))
  (setq lock-file-name-transforms `((".*" ,emacs-lock-dir t)))
)
