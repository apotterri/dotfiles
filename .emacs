;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;(require 'package)
;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;(package-initialize)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-timeout 600)
 '(before-save-hook nil)
 '(blink-cursor-mode nil)
 '(confirm-kill-emacs 'y-or-n-p)
 '(custom-enabled-themes nil)
 '(enh-ruby-deep-indent-construct nil)
 '(grep-find-command
   "find . -type f -a ! \\( -name '*~' \\) -print0 | xargs -0 grep -nH -e ")
 '(groovy-indent-offset 2)
 '(js-indent-level 2)
 '(js2-global-externs '("URL" "chrome" "setTimeout" "clearTimeout"))
 '(js2-mode-assume-strict t)
 '(magit-auto-revert-immediately nil)
 '(magit-auto-revert-mode nil)
 '(magit-auto-revert-tracked-only nil)
 '(ns-command-modifier 'meta)
 '(package-selected-packages
   '(poetry python-docstring flymake-python-pyflakes flymake-eslint xah-lookup ws-butler enh-ruby-mode js2-mode web-mode exec-path-from-shell ag flycheck go-mode haml-mode magit yaml-mode groovy-mode markdown-mode feature-mode company))
 '(poetry-tracking-mode nil)
 '(prog-mode-hook '(flyspell-prog-mode linum-mode subword-mode))
 '(ruby-deep-arglist nil)
 '(safe-local-variable-values
   '((eval add-hook 'python-mode-hook #'flymake-python-pyflakes-load)
     (eval add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
     (poetry-tracking-mode . t)
     (encoding . binary)
     (whitespace-line-column . 80)
     (encoding . utf-8)))
 '(scroll-bar-mode nil)
 '(sh-basic-offset 2)
 '(sh-indentation 2)
 '(smie-indent-basic 2)
 '(split-height-threshold nil)
 '(split-width-threshold nil)
 '(tab-width 4)
 '(text-mode-hook '(turn-on-flyspell text-mode-hook-identify))
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(vc-follow-symlinks nil)
 '(web-mode-markup-indent-offset 2))
;(custom-set-faces
; ;; custom-set-faces was added by Custom.
; ;; If you edit it by hand, you could mess it up, so be careful.
; ;; Your init file should contain only one such instance.
; ;; If there is more than one, they won't work right.
; '(default ((t (:inherit nil :stipple nil :background "White" :foreground "Black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "nil" :family "Menlo")))))


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
(global-unset-key [f10])

(global-set-key (kbd "C-M-SPC") 'fixup-whitespace)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(require 'go-mode)
(defun my-go-mode-hook ()
  ;; (setq gofmt-command "/Users/ajp/go/bin/goimports")
  (setq tab-width 2)
  (setq flyspell-prog-text-faces '(font-lock-comment-face font-lock-doc-face))
  (add-hook 'before-save-hook #'gofmt-before-save)
  (flycheck-mode)
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

; (exec-path-from-shell-initialize)
;; (add-hook 'after-init-hook #'global-flycheck-mode)

  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(put 'set-goal-column 'disabled nil)

(add-hook 'ruby-mode-hook (lambda()
                            (set-register ?z "require 'pry'; binding.pry")))
;; (setcdr (cl-rassoc 'ruby-mode auto-mode-alist) 'enh-ruby-mode)
(put 'narrow-to-region 'disabled nil)

(server-start)

(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 4)))

(require 'ws-butler)
(add-hook 'prog-mode-hook #'ws-butler-mode)

(setq default-frame-alist '((font . " -*-Menlo-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(python-docstring-install)

(require 'flymake-python-pyflakes)
;; (add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

(setq flymake-python-pyflakes-executable "flake8")

(add-hook 'python-mode-hook (lambda()
                              (set-register ?z "import pdb; pdb.set_trace()")
                              (setq display-fill-column-indicator-column 79)
                              (set-face-foreground 'fill-column-indicator "light grey")
                              (display-fill-column-indicator-mode)))


;; Used this in a .dir-locals.el for appmap-python. Not exactly what I
;;wanted: I'd really like flake8 enabled for my files, not for all
;;python files.
;; ((python-mode (eval add-hook 'python-mode-hook
;;#'flymake-python-pyflakes-load)))
