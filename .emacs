
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
 '(blink-cursor-mode nil)
 '(confirm-kill-emacs (quote y-or-n-p))
 '(menu-bar-mode nil)
 '(ns-command-modifier (quote meta))
 '(package-selected-packages (quote (markdown-mode feature-mode company)))
 '(scroll-bar-mode nil)
 '(sh-basic-offset 2)
 '(split-height-threshold nil)
 '(split-width-threshold nil)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-set-key [f11] 'revert-buffer)
(global-unset-key "\C-z")

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(defun ditto(begin end)
  (interactive "*r")
  (previous-line)
  (kill-line 1)
  (yank)
  (yank))
(global-set-key "\M-\"" 'ditto)

(setq-default indent-tabs-mode nil)
