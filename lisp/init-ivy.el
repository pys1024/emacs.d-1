;;; -*- lexical-binding: t -*-
(when (maybe-require-package 'ivy)
  (add-hook 'after-init-hook 'ivy-mode)
  (after-load 'ivy
    (setq-default ivy-use-virtual-buffers t
                  ivy-virtual-abbreviate 'fullpath
                  ivy-count-format ""
                  projectile-completion-system 'ivy
                  ivy-magic-tilde nil
                  ivy-dynamic-exhibit-delay-ms 150
                  ivy-initial-inputs-alist
                  '((Man-completion-table . "^")
                    (woman . "^")))

    ;; IDO-style directory navigation
    (define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done)
    (dolist (k '("C-j" "C-RET"))
      (define-key ivy-minibuffer-map (kbd k) #'ivy-immediate-done))

    (define-key ivy-minibuffer-map (kbd "<up>") #'ivy-previous-line-or-history)

    (when (maybe-require-package 'diminish)
      (diminish 'ivy-mode)))

  (defun sanityinc/enable-ivy-flx-matching ()
    "Make `ivy' matching work more like IDO."
    (interactive)
    (require-package 'flx)
    (setq-default ivy-re-builders-alist
                  '((t . ivy--regex-fuzzy)))))

(when (maybe-require-package 'ivy-historian)
  (add-hook 'after-init-hook 'ivy-historian-mode))

(when (require-package 'counsel)
  (setq-default counsel-mode-override-describe-bindings t)
  (when (maybe-require-package 'diminish)
    (after-load 'counsel
      (diminish 'counsel-mode)))
  (add-hook 'after-init-hook 'counsel-mode)

  (when (maybe-require-package 'projectile)
    (let ((search-function
           (cond
            ((executable-find "rg") 'counsel-rg)
            ((executable-find "ag") 'counsel-ag)
            ((executable-find "pt") 'counsel-pt)
            ((executable-find "ack") 'counsel-ack))))
      (when search-function
        (defun sanityinc/counsel-search-project (initial-input &optional use-current-dir)
          "Search using `counsel-rg' or similar from the project root for INITIAL-INPUT.
If there is no project root, or if the prefix argument
USE-CURRENT-DIR is set, then search from the current directory
instead."
          (interactive (list (thing-at-point 'symbol)
                             current-prefix-arg))
          (let ((current-prefix-arg)
                (dir (if use-current-dir
                         default-directory
                       (condition-case err
                           (projectile-project-root)
                         (error default-directory)))))
            (funcall search-function initial-input dir)))))
    (after-load 'ivy
      (add-to-list 'ivy-height-alist (cons 'counsel-ag 20)))
    (global-set-key (kbd "M-?") 'sanityinc/counsel-search-project)))


(when (maybe-require-package 'swiper)
  (after-load 'ivy
    (defun sanityinc/swiper-at-point (sym)
      "Use `swiper' to search for the symbol at point."
      (interactive (list (thing-at-point 'symbol)))
      (swiper sym))

    (define-key ivy-mode-map (kbd "M-s /") 'sanityinc/swiper-at-point)))


(when (maybe-require-package 'ivy-xref)
  (setq xref-show-xrefs-function 'ivy-xref-show-xrefs))


(provide 'init-ivy)
