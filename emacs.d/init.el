(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("gnu" ."http://elpa.gnu.org/packages/"))
(package-initialize)

(let ((packages '(company
		  dtrt-indent
		  flycheck
		  ggtags
		  helm
		  helm-gtags
		  helm-projectile
		  midje-mode
		  paredit
		  projectile
		  rainbow-delimiters
		  rust-mode
		  toml-mode
		  yasnippet
		  zenburn-theme
                  alchemist
                  cider
                  company-irony
                  elixir-mode
                  emmet-mode
                  exec-path-from-shell
                  expand-region
                  flycheck-irony
                  irfc
                  irony
                  less-css-mode
                  markdown-mode
                  multiple-cursors
                  web-mode
                  cmake-mode)))
  (dolist (pkg packages)
    (unless (package-installed-p pkg)
      (package-install pkg))))

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

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

(require 'irfc)
(setq irfc-directory "~/Documents/rfcs")
(setq irfc-assoc-mode t)

(require 'emmet-mode)
(require 'web-mode)

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

(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-*") 'mc/mark-all-like-this)

(global-set-key (kbd "M-[") 'er/contract-region)
(global-set-key (kbd "M-]") 'er/expand-region)

(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.jsm\\'" . js-mode))

(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))


;;
;; Default indentations
;;


(setq-default indent-tabs-mode nil)
(setq c-default-style
      '((java-mode . "java") (awk-mode . "awk") (other . "bsd"))
      c-basic-offset 4)

(defun my-c-mode-setup ()
  (subword-mode 1)
  (c-set-offset 'innamespace 0))
(add-hook 'c-mode-common-hook 'my-c-mode-setup)


;;
;; Custom stuff
;;

(setq helm-gtags-auto-update t)

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


;;
;; Hooking
;;

(defun gtags-mode-keys ()
  "Gtags mode keys."
  (local-set-key (kbd "M-.") 'helm-gtags-dwim)
  (local-set-key (kbd "M-,") 'helm-gtags-pop-stack)
  (local-set-key (kbd "C-c <") 'helm-gtags-previous-history)
  (local-set-key (kbd "C-c >" ) 'helm-gtags-next-history)
  (local-set-key (kbd "C-c g" ) 'helm-gtags-update-tags))

(add-hook 'helm-gtags-mode-hook 'gtags-mode-keys)

(add-hook 'clojure-mode-hook 'midje-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'lisp-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)

(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'after-init-hook 'global-company-mode)

(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.

(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)


;;
;; irony-mode related setup:
;;


;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

;; (optional) adds CC special commands to `company-begin-commands' in order to
;; trigger completion at interesting places, such as after scope operator
;;     std::|
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)


;;
;; UI customizations
;;


(load-theme 'zenburn t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode 0)

(column-number-mode t)
(show-paren-mode 1)
(setq inhibit-splash-screen t)
(setq major-mode 'text-mode)
(defalias 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode t)
(setq window-combination-resize t)
(setq scroll-conservatively 5)
(set-language-environment "UTF-8")


(set-face-attribute 'default nil
		    :family "Source Code Pro"
		    :foundry "adobe"
		    :slant 'normal
		    :weight 'normal
		    :height 124
		    :width 'normal)

(set-face-attribute 'irfc-head-name-face nil
                    :foreground "navajo white"
                    :underline t
                    :weight 'bold)
(set-face-attribute 'irfc-head-number-face nil
                    :foreground "navajo white"
                    :weight 'bold)
(set-face-attribute 'irfc-requirement-keyword-face nil
                    :foreground "indian red"
                    :weight 'bold)
(set-face-attribute 'irfc-rfc-link-face nil
                    :foreground "dark cyan"
                    :weight 'bold)


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
 '(package-selected-packages
   (quote
    (elixir-mode zenburn-theme yasnippet web-mode toml-mode rust-mode rainbow-delimiters paredit multiple-cursors midje-mode markdown-mode less-css-mode irfc helm-projectile helm-gtags ggtags flycheck-irony f expand-region exec-path-from-shell emmet-mode dtrt-indent company-irony cmake-mode alchemist))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
