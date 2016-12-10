;; Hide warning buffer when starting emacs.
(setq warning-minimum-level :emergency)

(add-to-list 'load-path "~/.emacs.d/lisp")

;; Initialize package.el
(require 'package)
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

;; Initialize el-get.el
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (package-refresh-contents)
  (package-install 'el-get)
  (require 'el-get))

(setq el-get-user-package-directory "~/.emacs.d/lisp/el-get-init-files")

;; Install packages from "~/.emacs.d/lisp/package-list.el"
(require 'package-list)
