
;;;  -*- lexical-binding: t; -*-
;;;
(require 'exwm)
(require 'exwm-config)
;(exwm-config-ido)
(exwm-enable)
;(require 'exwm-config)
;(exwm-config-default)
; Set the initial number of workspaces (they can also be created later).
(setq exwm-workspace-number 4)

(setq exwm-input-global-keys `(,(kbd "s-&") .
                               (lambda (command)
                                 (interactive (list (read-shell-command "$ ")))
                                 (start-process-shell-command command nil command))))
