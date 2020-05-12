;;; ~/.doom.d/+gnus.el -*- lexical-binding: t; -*-

(after! gnus
  evil-mode nil)

(setq gnus-select-method '(nnnil))
;; (setq gnus-secondary-select-methods
;;       '((nntp "news.gwene.org"
;;               (nnir-search-engine gmane))))


(setq gnus-secondary-select-methods
             '((nntp "news.gwene.org"
                     (nnir-search-engine gmane)
                     )))
(setq gnus-agent t)
(setq gnus-check-new-newsgroups 'ask-server)
(setq gnus-read-active-file 'some)
