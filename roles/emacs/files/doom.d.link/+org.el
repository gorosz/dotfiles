;;;  -*- lexical-binding: t; -*-
(setq org-directory (expand-file-name "~/Dropbox/org"))

(setq deft-extensions '("txt" "tex" "org" "md"))
(setq deft-directory (expand-file-name "~/Dropbox/org/"))

(setq org-default-notes-file (concat org-directory "/inbox.org"))
(setq default-gtd-tasks-file (concat org-directory "/tasks.org"))
(setq default-gtd-inbox (concat org-directory "/inbox.org"))
(setq default-notes-file (concat org-directory "/notes.org"))

(setq org-agenda-files (list default-gtd-tasks-file))

(setq org-todo-keywords
      (quote ((sequence  "TODO(t)" "NEXT(x)" "WAITING(w/@!)" "|" "DONE(d)")
              (sequence "|" "NOTE(n)")
              (sequence "|" "CANCELED(c/@!)" "SOMEDAY(f)"))))

(setq org-todo-keyword-faces
      '(("NEXT" . (:foreground "IndianRed1" :weight bold))
        ("WAITING" . (:foreground "red" :weight bold))
        ("CANCELED" . (:foreground "light gray" :weight bold :strike-through t))
        ("SOMEDAY" . (:foreground "LimeGreen" :weight bold))
        ))

(setq org-capture-templates
      `(("t" "Task" entry (file+headline ,org-default-notes-file "Inbox")
         "* TODO %?")
        ("w" "Web link" entry (file+headline ,org-default-notes-file "Inbox")
         "* %^{Title}\n Source: [[%:link][%:description]], \n Selection: %i \n Captured On: %U \n %?"
         :empty-lines-before 1)
        ))

(setq org-refile-targets `((,default-gtd-tasks-file :maxlevel . 4)
                           (,default-notes-file :maxlevel . 4)))

(setq org-protocol-default-template-key "w")

(add-hook 'org-load-hook '(lambda () (setq org-modules (append '(org-man org-eww org-protocol org-habit) org-modules))))
