;;; init-evil --- my configuration
;;; Commentary:
;;; pys1024 2018/12/26

;;; Code:
;;; init-evil.el

;; (add-to-list 'load-path "~/.emacs.d/elpa-26.1/evil")
;;; config evil-leader
(require-package 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "i" 'evil-jump-forward
  "o" 'evil-jump-backward
  "u" 'undo
  "." 'evil-scroll-page-down
  "," 'evil-scroll-page-up
  "<SPC>" 'execute-extended-command
  "<tab>" 'counsel-switch-buffer
  "!" 'shell-command
  ";" 'comment-line
  "/" 'helm-do-ag
  "tn" 'visual-line-mode
  "tt" 'neotree-toggle
  "tw" 'whitespace-mode
  "to" 'lsp-ui-imenu
  "thp" 'highlight-phrase
  "thr" 'highlight-regexp
  "thl" 'highlight-lines-matching-regexp
  "0" 'select-window-0
  "1" 'select-window-1
  "2" 'select-window-2
  "3" 'select-window-3
  "ff" 'counsel-find-file
  "fs" 'save-buffer
  "fx" 'execute-this-buffer
  "fr" 'rename-this-file-and-buffer
  "fd" 'delete-this-file
  "bk" 'kill-buffer
  "bb" 'switch-to-buffer
  "pR" 'projectile-regenerate-tags
  "pa" 'projectile-add-known-project
  "pj" 'projectile-find-tag
  "pf" 'projectile-find-file
  "pd" 'projectile-find-dir
  "pp" 'projectile-switch-project
  "pib" 'platformio-build
  "piu" 'platformio-upload
  "pic" 'platformio-clean
  "pid" 'platformio-update
  "pim" 'platformio-device-monitor
  "xl" 'pp-eval-last-sexp
  )
;;; remove default evil-toggle-key C-z, manually setup later
(setq evil-toggle-key "")
;;; don't bind [tab] to evil-jump-forward
(setq evil-want-C-i-jump nil)
(require-package 'evil)
(evil-mode 1)

;;; remove all keybindings from insert-state keymap, use emacs-state when editing
(setcdr evil-insert-state-map nil)

;;; ESC to switch back normal-state
(define-key evil-insert-state-map [escape] 'evil-normal-state)

;;; TAB to indent in normal-state
(define-key evil-normal-state-map (kbd "TAB") 'evil-indent-line)

(define-key evil-normal-state-map (kbd ",") 'scroll-down-line)
(define-key evil-normal-state-map (kbd ".") 'scroll-up-line)
(define-key evil-normal-state-map (kbd "e") 'forward-word)
(define-key evil-normal-state-map (kbd "b") 'backward-word)
(define-key evil-normal-state-map (kbd "M-.") 'xref-find-definitions)
(define-key evil-normal-state-map (kbd "C-r") 'isearch-backward)

;;; user j/k to move one visual line instead of gj/gk
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>")
  'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>")
  'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>")
  'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>")
  'evil-previous-visual-line)

;; (setq evil-default-state 'emacs)
(setq evil-default-state 'normal)

(provide 'init-evil)
;;; init-evil ends here
