;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(package-initialize)
(add-to-list 'package-archives 
	     '("melpa" . "http://melpa.milkbox.net/packages/")
	     'APPEND)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(before-save-hook nil)
 '(blink-cursor-mode nil)
 '(confirm-kill-emacs (quote y-or-n-p))
 '(grep-find-command
   "find . -type f -a ! \\( -name '*~' \\) -print0 | xargs -0 grep -nH -e ")
 '(groovy-indent-offset 2)
 '(ns-command-modifier (quote meta))
 '(package-selected-packages
   (quote
    (exec-path-from-shell ag go-projectile projectile flycheck go-mode haml-mode magit yaml-mode groovy-mode markdown-mode feature-mode company)))
 '(prog-mode-hook (quote (flyspell-prog-mode linum-mode)))
 '(safe-local-variable-values (quote ((encoding . utf-8))))
 '(scroll-bar-mode nil)
 '(sh-basic-offset 2)
 '(sh-indentation 2)
 '(smie-indent-basic 2)
 '(split-height-threshold nil)
 '(split-width-threshold nil)
 '(tab-width 4)
 '(text-mode-hook (quote (turn-on-flyspell text-mode-hook-identify)))
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "White" :foreground "Black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "nil" :family "Menlo")))))


(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-auto-merge-work-directories-length -1)
(ido-mode 1)

(setq-default indent-tabs-mode nil)

(defun ditto()
  (interactive "*")
  (previous-line)
  (kill-line 1)
  (yank)
  (yank))
(global-set-key "\M-\"" 'ditto)

(global-set-key [f11] 'revert-buffer)
(global-set-key [f2] 'goto-line)
(global-unset-key "\C-z")

(global-set-key (kbd "C-M-SPC") 'fixup-whitespace)

(require 'go-mode)
(defun my-go-mode-hook ()
  ;; (setq gofmt-command "/Users/ajp/go/bin/goimports")
  (setq tab-width 2)
  (setq flyspell-prog-text-faces '(font-lock-comment-face font-lock-doc-face))
  (projectile-mode)
  (flycheck-mode)
  (add-hook 'before-save-hook #'gofmt-before-save)
  )
(add-hook 'go-mode-hook 'my-go-mode-hook)

(require 'markdown-mode)
(defun md-mode-hook ()
  (auto-fill-mode)
  (setq fill-column 90))
(add-hook 'markdown-mode-hook 'md-mode-hook)

;;(setq gofmt-command "goimports")
;;(add-to-list 'load-path "/home/you/somewhere/emacs/")
;;(require 'go-mode-autoloads)
;;(add-hook 'before-save-hook 'gofmt-before-save)

(exec-path-from-shell-initialize)
;; (add-hook 'after-init-hook #'global-flycheck-mode)
