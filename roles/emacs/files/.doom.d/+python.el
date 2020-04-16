;;; ~/.doom.d/+python.el -*- lexical-binding: t; -*-

;;(require 'lsp-python-ms)

;;(setq lsp-python-ms-extra-paths '("/home/gergelyorosz/Devel/Balabit/stew/projects/nnx/source/nnx"
;;                                  "/home/gergelyorosz/Devel/Balabit/stew/projects/scb-master/source/scb/nnx-scb/scb"
;;                                  "/home/gergelyorosz/.local/share/virtualenvs/safeguard-sessions-plugin-hashicorp-vault-0gDVbAxc/lib/python3.6/site-packages/"))

;;(setq lsp-pyls-plugins-pylint-enabled nil)
(setq flycheck-python-pylint-executable (substitute-in-file-name "~/.local/bin/pylint"))
(setq flycheck-pylintrc (expand-file-name "~/Devel/Balabit/stew/projects/nnx/source/nnx/.pylintrc"))
(setq flycheck-python-mypy-ini (expand-file-name "~/Devel/Balabit/stew/projects/nnx/source/nnx/mypy.ini"))

(setq lsp-pyls-plugins-preload-modules '("/home/gergelyorosz/Devel/Balabit/stew/projects/nnx/source/nnx" "/home/gergelyorosz/.local/share/virtualenvs/safeguard-sessions-plugin-hashicorp-vault-0gDVbAxc/lib/python3.6/site-packages"))
(setq lsp-pyls-plugins-pylint-args '("--rcfile=" "/home/gergelyorosz/Devel/Balabit/stew/projects/nnx/source/nnx/.pylintrc"))
(setq lsp-pyls-configuration-sources ["pylint" "pycodestyle"])
(setq lsp-ui-flycheck-enable t)


(add-hook! 'python-mode-hook 'lsp!)
;;(add-hook! 'python-mode-hook 'flycheck-mode)
(add-hook! 'python-mode-hook (setq lsp-prefer-flymake nil))
(add-hook! 'python-mode-hook (setq lsp-enable-completion-at-point t))

;;(add-hook! 'python-mode-hook '(lambda () (flycheck-add-next-checker 'lsp-ui 'python-pylint)))
;;(add-hook! 'python-mode-hook '(lambda () (flycheck-select-checker python-pylint)))
;;(add-hook! 'python-mode-hook (setq lsp-prefer-flymake nil) (setq lsp-ui-sideline-enable nil) (setq lsp-enable-completion-at-point t))

(defun my-flycheck-setup ()
  (flycheck-add-next-checker 'lsp-ui 'python-pylint))

(add-hook 'python-mode-local-vars-hook #'my-flycheck-setup)

(defun pipenv-site-package ()
  ())
