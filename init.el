;;; init.el --- Emacs initialization file

;; Copyright (C) 2020 Tsukasa NAKATANI

;; Author: Tsukasa NAKATANI <concon.ch.1543@gmail.com>
;; Maintainer: Tsukasa NAKATANI <concon.ch.1543@gmail.com>
;; Version: 1.0.0
;; URL: https://github.com/tsukachu/.emacs.d

;;; Commentary:

;;; Code:

;;;; Initialize package.el
;;   ---------------------

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;;; Customization
;;   -------------

;; Source Han Code JP のフォントサイズは 3 の倍数にすること
;; https://qiita.com/suin/items/559d02ea32bd4a6ef08b
(set-face-attribute 'default nil
                    :font "Source Han Code JP R-12")

;; ツールバーを非表示にする
(tool-bar-mode 0)

;; スクロールバーを非表示にする
(scroll-bar-mode 0)

;; 行番号を表示する
(global-display-line-numbers-mode t)

;; バッファを自動で更新する
(global-auto-revert-mode t)

;; 長い行を折り返さない
(setq-default truncate-lines t)

;; カラム番号を表示する
(column-number-mode t)

;; インデントにタブを使わないようにする
(setq-default indent-tabs-mode nil)

;; ビープ音が鳴らないようにする
(setq ring-bell-function 'ignore)

;; find-file が / からにならないようにする
(setq command-line-default-directory "~/")

;; 保存する時に空白を削除する
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; 保存する時に EOF に改行を追加する
(setq require-final-newline t)

;; バックアップファイルを作らない --- filename.ext~
(setq make-backup-files nil)

;; 自動保存ファイルを作らない --- #filename.ext#
(setq auto-save-default nil)

;; ロックファイルを作らない --- .#filename.ext
(setq create-lockfiles nil)

;; カーソルを変更する
(setq-default cursor-type 'bar)

;;;; Configuration using use-package
;;   -------------------------------

(require 'use-package)

(use-package ace-window
  ;; NOTE windowの切り替え
  :bind ("C-x o" . ace-window)
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :ensure t)

(use-package anzu
  ;; NOTE モードラインに検索中のマッチ数を表示する
  :ensure t
  :init
  (global-anzu-mode t))

(use-package bind-key
  ;; キーバインド / use-package と同時にインストールされるので :ensure t はいらない
  :bind* (("C-h" . delete-backward-char)
          ("M-h" . backward-kill-word)
          ("C-?" . help-command)))

(use-package company
  ;; NOTE 補完
  :config
  ;; ツールチップが表示されてる間は whitespace-mode を OFF にする
  ;; https://github.com/company-mode/company-mode/pull/245#issuecomment-232943098
  (defvar-local
    pre-tooltip-unhide
    nil)
  (defun before-tooltip-unhide ()
    "ツールチップが表示される前に whitespace-mode を OFF にする"
    (if whitespace-mode (progn (whitespace-mode 0)
                               (setq pre-tooltip-unhide t))))
  (defun after-tooltip-hide ()
    "ツールチップが表示された後に whitespace-mode を ON にする"
    (if pre-tooltip-unhide (progn (whitespace-mode t)
                                  (setq pre-tooltip-unhide nil))))
  (advice-add 'company-pseudo-tooltip-unhide
              :before #'before-tooltip-unhide)
  (advice-add 'company-pseudo-tooltip-hide
              :after #'after-tooltip-hide)
  :ensure t
  :init
  (global-company-mode t))

(use-package company-quickhelp
  ;; NOTE ドキュメントをポップアップ表示させる
  :after (company)
  :ensure t
  :init
  (company-quickhelp-mode t))

(use-package ddskk
  ;; NOTE IME
  :bind ("C-x C-j" . skk-mode)
  :ensure t
  :init
  ;; :config だと効かなかったので :init に書くことに
  (setq skk-sticky-key ";")
  (setq skk-show-mode-show t))

(use-package editorconfig
  :config
  (editorconfig-mode t)
  :ensure t)

(use-package elpy
  ;; NOTE Python IDE
  :after (f)
  :config
  (setq elpy-rpc-python-command "python3")
  ;; flymake と highlight-indentation を使わないようにする
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (setq elpy-modules (delq 'elpy-module-highlight-indentation elpy-modules))
  ;; pyvenv-activate を自動実行させる hook
  ;; https://qiita.com/halhorn/items/e55bf8845e9b16782f84
  (defun auto-pyvenv-activate ()
    ".python-version ファイルがあれば自動で activate する"
    (f-traverse-upwards (lambda (path)
                          (let ((pyenv-version-path (f-expand ".python-version" path)))
                            (if (f-exists? pyenv-version-path)
                                (pyvenv-activate (concat "~/.pyenv/versions/" (s-trim (f-read-text
                                                                                       pyenv-version-path
                                                                                       'utf-8)))))))))
  :ensure t
  :init
  (elpy-enable)
  :hook (find-file . auto-pyvenv-activate))

(use-package exec-path-from-shell
  ;; NOTE shell と環境変数を共有する
  :config
  (exec-path-from-shell-initialize)
  :ensure t
  :if (memq window-system '(mac ns x)))

(use-package f
  ;; NOTE elpy で自動で pyvenv-activate を実行させる関数で使う
  :ensure t)

(use-package flycheck
  ;; NOTE 構文チェック
  :ensure t
  :init
  (global-flycheck-mode)
  :pin melpa-stable)

(use-package flycheck-pos-tip
  ;; NOTE エラーをポップアップ表示させる
  :after (flycheck)
  :config
  (flycheck-pos-tip-mode)
  :ensure t
  :pin melpa-stable)

(use-package flyspell
  ;; NOTE スペルチェックを表示させる
  :after (ispell)
  :config
  (set-face-attribute 'flyspell-duplicate nil
                      :underline nil)
  (set-face-attribute 'flyspell-incorrect nil
                      :underline '(:color "green" :style wave))
  :hook (prog-mode . flyspell-mode))

(use-package flyspell-correct
  ;; NOTE flyspell-correct-ido を使ってスペルチェックを ido のインターフェイスで表示させる
  :after (flyspell)
  :bind (:map flyspell-mode-map
         ("C-;" . flyspell-correct-wrapper))
  :ensure t)

(use-package flyspell-correct-ido
  ;; NOTE
  :after (flyspell-correct))

(use-package highlight-indent-guides
  ;; NOTE インデントを可視化
  :config
  (setq highlight-indent-guides-method 'character)
  ;; デフォルトの ?\x2502 だと表示がズレる
  (setq highlight-indent-guides-character ?\x007C)
  :ensure t
  :hook (prog-mode . highlight-indent-guides-mode))

(use-package highlight-symbol
  ;; NOTE シンボルをハイライト / シンボル間を移動
  :config
  (setq highlight-symbol-idle-delay 0.2)
  :ensure t
  :hook ((prog-mode . highlight-symbol-mode)
         (prog-mode . highlight-symbol-nav-mode)))

(use-package hiwin
  ;; NOTE 非アクティブなバッファを可視化
  :config
  (set-face-attribute 'hiwin-face nil
                      :background "gray25"
                      :extend t)
  :ensure t
  :init
  (hiwin-activate))

(use-package hl-line
  ;; NOTE 現在の行をに下線を引く
  :config
  (set-face-attribute 'hl-line nil
                      :background nil
                      :underline "gray25")
  :hook (prog-mode . hl-line-mode))

(use-package ido
  ;; NOTE
  :config
  (ido-mode t)
  ;; あいまいマッチを有効にする
  (setq ido-enable-flex-matching t)
  :ensure t)

(use-package ido-completing-read+
  ;; NOTE
  :config
  (ido-everywhere t)
  (ido-ubiquitous-mode t)
  :ensure t)

(use-package ido-vertical-mode
  ;; NOTE
  :config
  (ido-vertical-mode t)
  ;; next/prev のキーバインドを変更する
  (setq ido-vertical-define-keys 'C-n-and-C-p-only)
  :ensure t)

(use-package ispell
  ;; NOTE スペルチェック / aspell をインストールしておく必要がある
  :config
  (setq ispell-local-dictionary "en"))

(use-package json-mode
  :config
  (setq js-indent-level 2)
  :ensure t
  :mode "\\.json\\'")

(use-package rainbow-delimiters
  ;; NOTE 括弧に色付けする
  :config
  ;; 抵抗器の色にする
  (set-face-foreground 'rainbow-delimiters-depth-1-face "brown")
  (set-face-foreground 'rainbow-delimiters-depth-2-face "red")
  (set-face-foreground 'rainbow-delimiters-depth-3-face "orange")
  (set-face-foreground 'rainbow-delimiters-depth-4-face "yellow")
  (set-face-foreground 'rainbow-delimiters-depth-5-face "green")
  (set-face-foreground 'rainbow-delimiters-depth-6-face "blue")
  (set-face-foreground 'rainbow-delimiters-depth-7-face "violet")
  (set-face-foreground 'rainbow-delimiters-depth-8-face "gray")
  (set-face-foreground 'rainbow-delimiters-depth-9-face "white")
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package rainbow-mode
  ;; NOTE カラーコードを色を付けて表示する
  :ensure t
  :hook (prog-mode . rainbow-mode))

(use-package smartparens
  ;; NOTE 括弧を自動閉じたり、強調表示する
  :config
  (smartparens-global-mode t)
  (show-smartparens-global-mode t)
  :ensure t)

(use-package vscode-dark-plus-theme
  ;; NOTE カラーテーマ
  :config
  (load-theme 'vscode-dark-plus t)
  :ensure t)

(use-package web-mode
  ;; NOTE Frontend
  :config
  (setq web-mode-engines-alist '(("django" . "\\.html?\\'")))
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-style-padding 0)
  (setq web-mode-script-padding 0)
  ;; highlight-symbol を使わずに web-mode のハイライトを使う
  (setq web-mode-enable-current-element-highlight t)
  (set-face-background 'web-mode-current-element-highlight-face "gray25")
  :ensure t
  :hook (web-mode-hook . (lambda () (highlight-symbol-mode 0)))
  :mode ("\\.html?\\'"
         "\\.js\\'"
         "\\.vue\\'"))

(use-package whitespace
  ;; NOTE スペースとタブを可視化
  :config
  (setq whitespace-style '(face tabs spaces space-mark tab-mark))
  (setq whitespace-display-mappings '((space-mark ?\  [?\u00B7])
                                      (tab-mark ?\t [?\u2192 ?\t])))
  (set-face-attribute 'whitespace-space nil
                      :background nil
                      :foreground "gray25")
  (set-face-attribute 'whitespace-tab nil
                      :background nil
                      :foreground "gray25")
  ;; company の設定で切り替えるので global-whitespace-mode を使わない
  :hook (prog-mode . whitespace-mode))

(provide 'init)

;;; init.el ends here
