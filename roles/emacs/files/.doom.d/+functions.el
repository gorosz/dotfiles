;;; ~/.doom.d/+functions.el -*- lexical-binding: t; -*-

(defvar news-workspace-name "OG-News")
(defvar pomidor-workspace-name "OG-Pomidor")

(defun og/news ()
  (interactive)
  (when (+workspace-exists-p news-workspace-name)
    (+workspace/switch-to news-workspace-name))
  (progn (+workspace/new news-workspace-name) (gnus))
 )

(defun og/pomi ()
  (interactive)
  (when (+workspace-exists-p pomidor-workspace-name)
    (+workspace/switch-to pomidor-workspace-name))
  (progn (+workspace/new pomidor-workspace-name) (pomidor)))
