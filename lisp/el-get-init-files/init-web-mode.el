(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))

(setq web-mode-engines-alist
      '(
        ("mako" . "\\.html?\\'")
        )
      )

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 4)

  (setq web-mode-enable-current-element-highlight t)
  )
(add-hook 'web-mode-hook  'my-web-mode-hook)
