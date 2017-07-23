(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Spacemacs like
(load-theme 'spacemacs-dark t)

(use-package spaceline-config
  :init
  (setq ns-use-srgb-colorspace nil)
  :config
  (spaceline-spacemacs-theme))

;; Visualize whitespace
(use-package whitespace
  :config
  (setq whitespace-style '(face trailing tabs tab-mark))
  (defvar background-color "#292b2e")
  (set-face-attribute 'whitespace-trailing nil
                      :background background-color
                      :foreground "DeepPink"
                      :underline t)
  (set-face-attribute 'whitespace-tab nil
                      :background background-color
                      :foreground "DeepSkyBlue"
                      :underline t)
  (global-whitespace-mode t))

;; Highlight
(show-paren-mode t)

(use-package highlight-symbol
  :config
  (setq highlight-symbol-idle-delay 0.1))
  (add-hook 'prog-mode-hook 'highlight-symbol-mode)
  (add-hook 'prog-mode-hook 'highlight-symbol-nav-mode)

;; Font
(set-face-attribute 'default nil
                    :family "Ricty for Powerline"
                    :height 140)
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0208
                  (cons "Ricty for Powerline" "iso10646-1"))
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0212
                  (cons "Ricty for Powerline" "iso10646-1"))
(set-fontset-font (frame-parameter nil 'font)
                  'katakana-jisx0201
                  (cons "Ricty for Powerline" "iso10646-1"))

;; Trun off wrap
(set-default 'truncate-lines t)
(setq truncate-partial-width-windows nil)

;; Interface
(use-package helm
  :config
  (helm-mode t)
  :bind (("C-x C-f" . helm-find-files)
         ("M-x" . helm-M-x)
         :map helm-find-files-map
         ([tab] . helm-execute-persistent-action)))

(use-package anzu
  :config
  (global-anzu-mode +1))
