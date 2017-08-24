(package-initialize)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

;; Install if quelpa doesn't exist.
(unless (require 'quelpa nil t)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
    (eval-buffer)))

;; packages
(quelpa 'anzu :stable t)
(quelpa 'cider :stable t)
(quelpa 'clojure-mode :stable t)
(quelpa 'company :stable t)
(quelpa 'company-jedi :stable t)
(quelpa 'company-quickhelp :stable t)
(quelpa 'ddskk)
(quelpa 'exec-path-from-shell :stable t)
(quelpa 'flycheck :stable t)
(quelpa 'flycheck-pos-tip :stable t)
(quelpa 'helm :stable t)
(quelpa 'highlight-symbol :stable t)
(quelpa 'init-loader :stable t)
(quelpa 'jedi-core :stable t)
(quelpa 'paredit :stable t)
(quelpa 'python-mode :stable t)
(quelpa 'spacemacs-theme)
(quelpa 'spaceline :stable t)
(quelpa 'use-package :stable t)
(quelpa 'web-mode :stable t)

(init-loader-load)
