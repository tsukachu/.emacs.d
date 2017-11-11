;;; init.el --- Emacs initialization file

;;; Commentary:

;;; Code:

(package-initialize)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")
        ("elpy" . "http://jorgenschaefer.github.io.packages/")))

;;;
;;
(setq quelpa-update-melpa-p nil)

(unless (require 'quelpa nil t)
  (with-temp-buffer
    (url-insert-file-contents
     "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
    (eval-buffer)))

;;;
(quelpa 'anzu)
(quelpa 'bind-key)
(quelpa 'company)
(quelpa 'company-quickhelp)
(quelpa 'ddskk)
(quelpa 'dockerfile-mode)
(quelpa 'editorconfig)
(quelpa 'elpy)
(quelpa 'exec-path-from-shell)
(quelpa 'flycheck)
(quelpa 'flycheck-pos-tip)
;; (quelpa 'highlight-indent-guides)
(quelpa 'highlight-symbol)
(quelpa 'ido-completing-read+)
(quelpa 'ido-describe-bindings)
(quelpa 'ido-vertical-mode)
(quelpa 'pyenv-mode)
(quelpa 'python-mode)
(quelpa 'smex)
(quelpa 'spaceline)
(quelpa 'spacemacs-theme)
(quelpa 'use-package)
(quelpa 'web-mode)
(quelpa 'yaml-mode)

;;;
;;
(add-to-list 'default-frame-alist '(font . "Ricty for Powerline-16"))

;;
(setq auto-save-default nil)
(setq css-indent-offset 2)
(setq js-indent-level 2)
(setq make-backup-files nil)
(setq mouse-wheel-scroll-amount '(1))
(setq require-final-newline t)
(setq ring-bell-function 'ignore)
(setq scroll-step 1)
(setq tab-width 4)

(set-default 'truncate-lines t)
(setq-default indent-tabs-mode nil)

;;
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(global-auto-revert-mode t)
(scroll-bar-mode -1)
(show-paren-mode t)
(tool-bar-mode -1)

;;
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;;;
(use-package anzu
  :config
  (global-anzu-mode t)
  ;;
  (setq anzu-cons-mode-line-p nil))

(use-package bind-key
  :bind* (("C-h" . backward-delete-char-untabify)
          ("M-h" . backward-kill-word)
          ([C-tab] . other-window)
          ("s-w" . delete-window)))

(use-package company
  :config
  (global-company-mode t)
  (company-quickhelp-mode t)
  :bind (:map company-active-map
              ("C-h". nil)))

(use-package ddskk
  :init
  (setq skk-sticky-key ";")
  :bind (("C-x C-j" . skk-mode)))

(use-package dockerfile-mode
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1)
  )

(use-package elpy
  :init
  (pyenv-mode)
  :config
  (elpy-enable)
  (setq elpy-rpc-backend "jedi"))

(use-package flycheck
  :init
  (global-flycheck-mode)
  :config
  (flycheck-pos-tip-mode))

;; (use-package highlight-indent-guides
;;   :init
;;   :config
;;   (setq highlight-indent-guides-method 'character)
;;   (setq highlight-indent-guides-character ?\|)
;;   ;;
;;   (setq highlight-indent-guides-auto-enabled nil)
;;   (set-face-foreground 'highlight-indent-guides-character-face "gray40")
;;   (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;;   )

(use-package highlight-symbol
  :config
  (setq highlight-symbol-idle-delay 0.1)
  (add-hook 'prog-mode-hook 'highlight-symbol-mode)
  (add-hook 'prog-mode-hook 'highlight-symbol-nav-mode))

(use-package ido
  :init
  (ido-mode t)
  (ido-everywhere t)
  (setq ido-enable-flex-matching t)
  :config
  (ido-ubiquitous-mode t)
  (ido-vertical-mode t)
  (setq ido-vertical-define-keys 'C-n-and-C-p-only)
  (smex-initialize)
  :bind* (("M-x" . smex)
          :map help-map
          ("b" . ido-describe-bindings)))

(use-package python
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode))

(use-package spaceline-config
  :init
  (load-theme 'spacemacs-dark t)
  :config
  ;;
  (setq ns-use-srgb-colorspace nil)

  (spaceline-spacemacs-theme))

(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
  (setq web-mode-engines-alist '(("django" . "\\.html?\\'")))
  (add-hook 'web-mode-hook
            '(lambda ()
               (setq web-mode-markup-indent-offset 2)
               (setq web-mode-css-indent-offset 2)
               (setq web-mode-code-indent-offset 2)
               (setq web-mode-script-padding 0)
               (setq web-mode-style-padding 0))))

(use-package whitespace
  :config
  (setq whitespace-style '(face spaces space-mark tabs tab-mark))
  (setq whitespace-display-mappings'((space-mark 32 [183])
                                     (tab-mark 9 [8594 9])))
  (set-face-attribute 'whitespace-space nil :foreground "gray40")
  (set-face-attribute 'whitespace-tab nil :foreground "gray40")
  (global-whitespace-mode t))

(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml'" . yaml-mode))
  (add-hook 'yaml-mode-hook
            '(lambda ()
               (define-key yaml-mode-map "\C-m" 'newline-and-indent))))

(provide 'init)

;;; init.el ends here
