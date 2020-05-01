;;; ~/.doom.d/+org.el -*- lexical-binding: t; -*-

(add-hook 'org-mode-hook (lambda () (hl-fill-column-mode -1)))

(setq org-roam-directory org-directory)

(after! org
  (setq org-capture-templates
        '(("l" "Web link from browser" entry
           (file+headline "inbox.org" "Incoming")
           "** %:link\n\nNotes: %?\n\nSelection: %:initial\n\nCapture on: %t")
          ("p" "Personal stuffs")
          ("pt" "Personal task" entry
           (file+headline "task-inbox.org" "Incoming")
         "** [ ] %?\nCreate on: %t")
          ("pi" "Idea dump" entry
           (file+headline "idea-inbox.org" "Incoming")
           "** %^{Speak your mind}%?\n :PROPERTIES:\n :DETAILS: %{More details}%?\n :CAPTURED: %U\n :END:\n\n %i")
          ("w" "Work related stuffs")
          ("wt" "Work task" entry
           (file+headline "work-inbox.org" "Incoming")
           "** [ ] %?\n Create on: %t"))))
