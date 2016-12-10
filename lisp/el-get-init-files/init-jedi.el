(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; Execute "M-x jedi:install-server".
;; Requirement command line program "virtualenv".
