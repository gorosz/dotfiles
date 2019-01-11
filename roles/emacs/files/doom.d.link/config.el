;;; package --- Summary
;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
;;; Iosevka
;;(setq doom-font (font-spec :family "FuraCode NF" :size 16))
(setq doom-font (font-spec :family "Iosevka" :size 18))
;;(setq doom-big-font (font-spec :family "FuraCode NF" :size 23))
(setq doom-big-font (font-spec :family "Iosevka" :size 25))

(setq company-idle-delay 0.2
      company-minimum-prefix-length 3)

(setq show-trailing-whitespace t)
(setq evil-want-keybinding  nil)
(setq evil-want-integration t)

(setq display-line-numbers-type 'relative)

(add-to-list 'company-backends 'company-dabbrev t)

(setq-hook! 'restclient-mode-hook
  gnutls-verify-error nil
  tls-checktrust nil)

(add-to-list 'auto-mode-alist '("\\.zts$" . python-mode))
(add-to-list 'auto-mode-alist '("\\.tpl$" . jinja2-mode))

(make-face-italic font-lock-comment-face)

(after! edit-server
  (setq edit-server-new-frame nil)
  (edit-server-start))

(after! eshell
  (set-eshell-alias!
   "f"   "find-file $1"
   "l"   "ls -lh"
   "d"   "dired $1"
   "gl"  "(call-interactively 'magit-log-current)"
   "gs"  "magit-status"
   "gc"  "magit-commit"
   "rg"  "rg --color=always $*"))

(custom-set-variables
 '(shell-pop-shell-type (quote ("ansi-term" "*ansi-term*" (lambda nil (ansi-term shell-pop-term-shell)))))
 '(shell-pop-term-shell "/bin/zsh")
 '(shell-pop-universal-key "C-t")
 '(shell-pop-window-size 40)
 '(shell-pop-full-span t)
 '(shell-pop-window-position "bottom"))

(add-hook! python-mode
  (setq python-shell-interpreter "python3"))
(setq flycheck-python-flake8-executable (expand-file-name "~/.local/bin/flake8"))
(setq flycheck-python-pylint-executable (expand-file-name "~/.local/bin/pylint"))
(setq python-shell-extra-pythonpaths (list "/home/gergelyorosz/Devel/Balabit/stew/projects/scb-master/source/scb"))

(setq alchemist-execute-command (expand-file-name "~/.asdf/shims/elixir")) ;; default: elixir
(setq alchemist-compile-command (expand-file-name "~/.asdf/shims/elixirc")) ;; default: elixirc
(setq alchemist-mix-command (expand-file-name "~/.asdf/shims/mix"))

(setq whitespace-line-column 120)
(setq starttls-gnutls-program "/usr/bin/gnutls-cli")

(setq tls-program
      '("/usr/bin/gnutls-cli --x509cafile /etc/ssl/certs/ca-certificates.crt -p %p %h"
        "/usr/bin/gnutls-cli --x509cafile /etc/ssl/certs/ca-certificates.crt -p %p %h --protocols ssl3"))

(load-theme 'doom-dracula t)
;;; Modules
(load! "+org")
(load! "+magit")
(load! "+lab")
(load! "+symbols")
(load! "+bindings")
;;(load! "+elsp")
(load! "equake")
(load! "+doommodeline")

(provide 'config)
;;; config.el ends here
