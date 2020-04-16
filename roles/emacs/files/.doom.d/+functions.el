;;; ~/.doom.d/+functions.el -*- lexical-binding: t; -*-

(defvar news-workspace-name "OG-News")

(defun og/news ()
  (interactive)
  (when (+workspace-exists-p news-workspace-name)
    (+workspace/switch-to news-workspace-name))
  (progn (+workspace/new news-workspace-name) (gnus))
 )
