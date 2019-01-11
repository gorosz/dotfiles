;;; ~/.dotfiles/doom/.doom.d/+elsp.el -*- lexical-binding: t; -*-

;;(add-to-list 'load-path "/home/gergelyorosz/Devel/Github/lsp-elixir/")
;;(require 'lsp-elixir)

;;(add-hook 'elixir-mode-hook #'lsp-elixir-enable)


;;(setq lsp-elixir-ls-command "sh")
;;(setq lsp-elixir-ls-args '("/home/gergelyorosz/Devel/Github/elixir-ls/release/language_server.sh"))

;;(add-hook 'elixir-mode-hook (lambda () (add-hook 'before-save-hook 'lsp-format-buffer)))


;;(push 'company-lsp company-backends)

;;(add-hook 'lsp-mode-hook 'lsp-ui-mode)
;;(setq lsp-ui-flycheck-enable 1)


(add-to-list 'load-path "/home/gergelyorosz/Devel/Github/alchemist.el/")
(require 'alchemist-elixir-ls)
(require 'alchemist-goto)
(require 'alchemist)
