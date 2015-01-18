(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("gnu" ."http://elpa.gnu.org/packages/"))
(package-initialize)

(let ((packages '(cider
		  paredit
		  company
		  zenburn-theme
		  midje-mode
		  rainbow-delimiters
		  projectile
		  helm
		  helm-projectile
		  dtrt-indent
		  ggtags
		  flycheck
		  yasnippet
		  rust-mode
		  toml-mode
		  cmake-mode
		  helm-gtags
                  multiple-cursors)))
  (dolist (pkg packages)
    (unless (package-installed-p pkg)
      (package-install pkg))))

(require 'dtrt-indent)
(dtrt-indent-mode 1)

(require 'helm-config)
(require 'helm-projectile)
(helm-mode 1)

(require 'yasnippet)
(yas-global-mode 1)

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(require 'toml-mode)
(require 'cmake-mode)

(setq flycheck-display-errors-delay 0.2)
(setq flycheck-clang-language-standard "c++11")

;; Need for this is ridiculous..
(define-key global-map (kbd "RET") 'newline-and-indent)

(global-set-key (kbd "M-h") 'backward-char)
(global-set-key (kbd "M-j") 'next-line)
(global-set-key (kbd "M-k") 'previous-line)
(global-set-key (kbd "M-l") 'forward-char)
(global-set-key (kbd "C-M-l") 'paredit-forward)
(global-set-key (kbd "C-M-h") 'paredit-backward)

(global-set-key (kbd "M-^") 'join-line)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c o") 'helm-occur)
(global-set-key (kbd "C-c <SPC>") 'helm-all-mark-rings)

(global-set-key (kbd "M-.") 'helm-gtags-dwim)
(global-set-key (kbd "M-,") 'helm-gtags-pop-stack)
(global-set-key (kbd "C-c <") 'helm-gtags-previous-history)
(global-set-key (kbd "C-c >" ) 'helm-gtags-next-history)

(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-*") 'mc/mark-all-like-this)

(load-theme 'zenburn t)
(set-face-attribute 'default nil
		    :family "Source Code Pro"
		    :foundry "adobe"
		    :slant 'normal
		    :weight 'normal
		    :height 72
		    :width 'normal)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode 0)

(show-paren-mode 1)
(setq inhibit-splash-screen t)
(setq major-mode 'text-mode)
(defalias 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode t)
(setq window-combination-resize t)
(setq scroll-conservatively 5)
(set-language-environment "UTF-8")


;; Default indentations


(setq-default indent-tabs-mode nil)
(setq c-default-style
      '((java-mode . "java") (awk-mode . "awk") (other . "bsd"))
      c-basic-offset 4)

(defun my-c-mode-setup ()
  (subword-mode 1)
  (c-set-offset 'innamespace 0))
(add-hook 'c-mode-common-hook 'my-c-mode-setup)


;; Custom stuff


(defun vj/open-line-after ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(defun vj/zap-up-to-char (arg char)
  "Zap up to a character."
  (interactive "p\ncZap up to char: ")
  (zap-to-char arg char)
  (insert char)
  (forward-char -1))

(global-set-key (kbd "C-o") 'vj/open-line-after)
(global-set-key (kbd "M-z") 'vj/zap-up-to-char)

;; Hooking
(add-hook 'clojure-mode-hook 'midje-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'lisp-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)

(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'after-init-hook 'global-company-mode)

(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)

;; Save all tempfiles in $TMPDIR/emacs$UID/
(defconst emacs-tmp-dir (format "%s/%s%s/" temporary-file-directory "emacs" (user-uid)))
(setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
      emacs-tmp-dir)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(custom-safe-themes
   (quote
    ("dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" default)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "adobe" :slant normal :weight normal :height 68 :width normal)))))
