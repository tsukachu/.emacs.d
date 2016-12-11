;; spacemacs like
(el-get-bundle spacemacs-theme)
(el-get-bundle spaceline)
(el-get-bundle ryuslash/mode-icons)

;; Split init file.
(el-get-bundle init-loader)

;; keybind
(el-get-bundle bind-key)
(el-get-bundle ddskk)

;; path
(el-get-bundle exec-path-from-shell)

;; interface
(el-get-bundle helm)
(el-get-bundle anzu)

;; support
(el-get-bundle auto-complete)

;; python
(el-get-bundle jedi)

(provide 'package-list)