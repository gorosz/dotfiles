;;; ~/.doom.d/+pomidor.el -*- lexical-binding: t; -*-

(use-package! pomidor
  :defer t
  ;; :bind (("<f12>" . pomidor))
  :config (setq pomidor-sound-tick nil
                pomidor-sound-tack nil
                pomidor-seconds (* 45 60)
                pomidor-break-seconds (* 15 60)))


(map! :localleader
      :map pomidor-mode-map
      :desc "Stop pomidor" :n "s" #'pomidor-stop
      :desc "Quit pomidor" :n "q" #'pomidor-quit
      :desc "Reset pomidor" :n "r" #'pomidor-reset
      :desc "Start new break" :n "b" #'pomidor-break)
