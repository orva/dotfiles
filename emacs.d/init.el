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
		  auto-complete
		  zenburn-theme
		  midje-mode
		  rainbow-delimiters
		  projectile
		  helm
		  helm-projectile)))
  (dolist (pkg packages)
    (unless (package-installed-p pkg)
      (package-install pkg))))

;; Autocomplete
(require 'auto-complete-config)
(ac-config-default)

(require 'helm-config)
(require 'helm-projectile)
(helm-mode 1)

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(global-set-key (kbd "M-h") 'backward-char)
(global-set-key (kbd "M-j") 'next-line)
(global-set-key (kbd "M-k") 'previous-line)
(global-set-key (kbd "M-l") 'forward-char)
(global-set-key (kbd "C-M-l") 'paredit-forward)
(global-set-key (kbd "C-M-h") 'paredit-backward)
(global-set-key (kbd "M-^") 'join-line)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c o") 'helm-occur)


;; Need for this is ridiculous..
(define-key global-map (kbd "RET") 'newline-and-indent)

(load-theme 'zenburn t)
(set-face-attribute 'default nil
		    :family "DejaVu Sans Mono"
		    :foundry "unknown"
		    :slant 'normal
		    :weight 'normal
		    :height 83
		    :width 'normal)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode 0)
(show-paren-mode 1)

;; Hooking
(add-hook 'clojure-mode-hook 'midje-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'lisp-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)

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
 '(custom-safe-themes (quote ("dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
