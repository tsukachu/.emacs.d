;; font
;; "C-x C-+" font-size up
;; "C-x C--" font-size down
(set-face-attribute 'default nil
                    :family "Ricty for Powerline"
                    :height 140)
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0208
                  (cons "Ricty for Powerline" "iso10646-1"))
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0212
                  (cons "Ricty for Powerline" "iso10646-1"))
(set-fontset-font (frame-parameter nil 'font)
                  'katakana-jisx0201
                  (cons "Ricty for Powerline" "iso10646-1"))
