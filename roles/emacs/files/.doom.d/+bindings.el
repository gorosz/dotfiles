;;; package -- Bindings
;;; Commentary:
;;; Code:
(map!
 (:leader :prefix "O"
        :desc "Read news" :n "n" #'og/news)

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
