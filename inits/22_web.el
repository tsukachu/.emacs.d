(use-package web-mode
  :mode
  ("\\.html?\\'" . web-mode)
  ("\\.php\\'" . web-mode)
  :config
  (setq web-mode-engines-alist
        '(("php" . "\\.php\\'")))
  (defun my-web-mode-hook ()
    "Hooks for Web mode."
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-css-indent-offset 2)
    (setq web-mode-code-indent-offset 4)

    (setq web-mode-enable-current-element-highlight t)))
