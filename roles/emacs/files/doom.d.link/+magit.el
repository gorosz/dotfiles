;;;  -*- lexical-binding: t; -*-
;;; Git review in magit popup
(defun gitreview (arg)
    (interactive "i")
    (magit--shell-command "git review"))

(defun gitwip (arg)
  (interactive "i")
  (magit--shell-command "git commit -sam 'feat(WIP): WIP'"))

(after! magit
  (magit-define-popup-action 'magit-run-popup ?v "Review" 'gitreview)
  (magit-define-popup-action 'magit-run-popup ?w "WIP commit" 'gitwip))
