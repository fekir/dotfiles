;; functions, should not change global status

(defun fek-compile-project-rename-buffer (command)
  "Compiles the project using COMMAND in its own buffer."
  (interactive
   (list
    (read-string "Compile command: " "make" 'compile-history)))
   (let* ((compilation-buffer-name-function-original compilation-buffer-name-function))
     (setq-local compilation-buffer-name-function
                 (lambda (mode)
                   (concat "*" (downcase mode) " - " command "*")))
     (compile command)
     (setq-local compilation-buffer-name-function compilation-buffer-name-function-original)))
