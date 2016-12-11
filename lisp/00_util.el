;; backup file(*~)
(setq make-backup-files nil)

;; auto save file(#*#)
(setq auto-save-default nil)

;; beep
(setq ring-bell-function 'ignore)

;; tool bar
(tool-bar-mode 0)

;; menu bar
(menu-bar-mode 0)

;; scroll bar
(scroll-bar-mode 0)

;; Number of steps for each scroll
(setq scroll-step 1)
(setq hscroll-step 1)

;; Do not fold long text
(set-default 'truncate-lines t)
(setq truncate-partial-width-windows nil)

;; revert buffer
(global-auto-revert-mode 1)

;; indent
(setq-default tab-width 4 indent-tabs-mode nil)
