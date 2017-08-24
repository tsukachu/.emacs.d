(use-package clojure-mode
  :mode
  ("\\.clj\\'" . clojure-mode)
  :config
  (add-hook 'clojure-mode-hook #'paredit-mode))

(use-package cider)
