(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

(unless (package-installed-p 'cider)
  (package-install 'cider))
(unless (package-installed-p 'paredit)
  (package-install 'paredit))
(unless (package-installed-p 'auto-complete)
  (package-install 'auto-complete))
(unless (package-installed-p 'zenburn-theme)
  (package-install 'zenburn-theme))
(unless (package-installed-p 'midje-mode)
  (package-install 'midje-mode))

;; Autocomplete
(require 'auto-complete-config)
(ac-config-default)

(global-set-key (kbd "M-h") 'backward-char)
(global-set-key (kbd "C-M-h") 'paredit-backward)
(global-set-key (kbd "M-j") 'next-line)
(global-set-key (kbd "M-k") 'previous-line)
(global-set-key (kbd "M-l") 'forward-char)
(global-set-key (kbd "C-M-l") 'paredit-forward)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-create-new-buffer 'always)
(setq ido-file-extensions-order '(".md" ".clj"))

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

;; Hooking
(add-hook 'clojure-mode-hook 'midje-mode)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'lisp-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'cider-mode-hook 'paredit-mode)

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
