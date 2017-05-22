;; whitespace
(require 'whitespace)
(setq whitespace-style '(face trailing tabs tab-mark))
(global-whitespace-mode t)

(defvar my/bg-color "#292b2e")
(set-face-attribute 'whitespace-trailing nil
                    :background my/bg-color
                    :foreground "DeepPink"
                    :underline t)
(set-face-attribute 'whitespace-tab nil
                    :background my/bg-color
                    :foreground "DeepSkyBlue"
                    :underline t)

;; parenthesis
(show-paren-mode t)

;; screen size
(set-frame-parameter nil 'fullscreen 'maximized)
