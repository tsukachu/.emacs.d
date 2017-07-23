(setq make-backup-files nil)
(setq auto-save-default nil)

(setq ring-bell-function 'ignore)

(setq scroll-step 1)
(setq hscroll-step 1)

(global-auto-revert-mode t)

(setq-default indent-tabs-mode nil)
(setq tab-width 4)

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :config
  (exec-path-from-shell-initialize))

(use-package flycheck
  :config
  (global-flycheck-mode))

(use-package flycheck-pos-tip
  :config
  (with-eval-after-load 'flycheck
    (flycheck-pos-tip-mode)))
