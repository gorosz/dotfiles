;;; ~/.doom.d/+functions.el -*- lexical-binding: t; -*-

(defvar news-workspace-name "OG-News")

(defun og/news ()
  (interactive)
  (when (+workspace-exists-p news-workspace-name)
    (+workspace/switch-to news-workspace-name))
  (progn (+workspace/new news-workspace-name) (gnus))
 )

(defun valami ()
  (interactive)
  (require 'json)
  (require 'w3m)
  (with-temp-buffer
    (w3m-retrieve "https://hucovid.gigalixirapp.com/hu_data")
    (goto-char (point-min))
    (json-read)))
