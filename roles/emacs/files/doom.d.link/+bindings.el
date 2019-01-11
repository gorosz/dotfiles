;;; package -- Bindinsg
;;; Commentary:
;;; Code:
(map!
 (:leader :prefix "o"
        :desc "shell-pop ansi term" :n "T" #'shell-pop
        :desc "Search notes wiht Deft" :n "n" #'deft
        :desc "Start pomidor" :n "o" #'pomidor)
 (:after restclient
   :map restclient-mode-map
   (:localleader
     :desc "Send and stay in window" :n "s" #'restclient-http-send-current-stay-in-window))
 (:after org-mode
   :map org-mode-map
   (:localleader
     :desc "Insert new todo heading" :n "s" #'org-insert-todo-heading))
 )
(provide '+bindings)
;;; +bindings.el ends here
