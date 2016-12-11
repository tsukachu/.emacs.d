(bind-key* "C-h" 'delete-backward-char)

(bind-key* "C-x C-f" 'helm-find-files)
(bind-key* "C-x b" 'helm-buffers-list)
(bind-key* "M-x" 'helm-M-x)
(bind-key "TAB" 'helm-execute-persistent-action helm-find-files-map)
