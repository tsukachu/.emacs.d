(use-package bind-key
  :config
  (bind-key* "C-h" 'delete-backward-char))

(use-package ddskk
  :init
  ;; ":config" is not reflect.
  (setq skk-sticky-key ";")
  :bind
  ("C-x j" . skk-mode))

;; Input completion
(use-package company
  :bind (:map company-active-map
              ("C-h" . nil))
  :config
  (global-company-mode t))

(use-package company-quickhelp
  :config
  (company-quickhelp-mode t))
