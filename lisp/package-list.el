;; spacemacs like
(el-get-bundle spacemacs-theme)
(el-get-bundle spaceline)

;; keybind
(el-get-bundle bind-key)
(el-get-bundle ddskk)

;; path
(el-get-bundle exec-path-from-shell)

;; interface
(el-get-bundle helm)
(el-get-bundle anzu)
(el-get-bundle highlight-symbol)

;; support
(el-get-bundle auto-complete)

;; python
(el-get-bundle jedi)

;; clojure
(el-get-bundle clojure-mode)
(el-get-bundle paredit)

;; web
(el-get-bundle web-mode)

;; yaml
(el-get-bundle yaml-mode)

;; Split init file.
(el-get-bundle init-loader)

(provide 'package-list)
