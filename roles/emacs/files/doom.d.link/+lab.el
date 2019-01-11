;;;  -*- lexical-binding: t; -*-
;;; GitLab lab cli tool wrapper
;;;
;;;
;;;
(setq output_buffer_name "*Lab-Output*")
(defun lab-list-mr ()
  (interactive)
  (start-process-shell-command "MRlist" output_buffer_name "lab mr list")
  (switch-to-buffer output_buffer_name)
  )

(defun lab-accept-mr (mrid)
  (interactive "p")
  (setq mrid (read-string "Enter MR id: "))
  (start-process-shell-command "MRShow" output_buffer_name (format "lab mr show %s" mrid))
  (switch-to-buffer output_buffer_name)
  )
