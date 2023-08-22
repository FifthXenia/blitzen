(defcustom schizophrenia-start-sound (when load-file-name
                                      (concat (file-name-directory load-file-name)
                                              "sounds/org.gnome.Solanum-beep.ogg"))
  "The path to a sound file that´s to be played when a timeblock has started."
  :group 'schizophrenia
  :type 'file)

(defcustom schizophrenia-end-sound (when load-file-name
                                      (concat (file-name-directory load-file-name)
                                              "sounds/org.gnome.Solanum-chime.ogg"))
  "The path to a sound file that´s to be played when a timeblock has ended."
  :group 'schizophrenia
  :type 'file)

(defcustom schizophrenia-break-end-sound (when load-file-name
                                      (concat (file-name-directory load-file-name)
                                              "sounds/coin-collect-game-start-pixabay.mp3"))
  "The path to a sound file that´s to be played when a break has ended."
  :group 'schizophrenia
  :type 'file)

(defun schizophrenia-start-sound ()
  (interactive)
  ;; (path doesn't work (it doesn't play) with ~, it needs /home/greghab)
 (start-process "mplayer" nil "mplayer" 'schizophrenia-start-sound)
)

(defun schizophrenia-end-sound ()
  (interactive)
 (start-process "mplayer" nil "mplayer" 'schizophrenia-end-sound)
)

(defun ajahn-sacrifice-break-end-sound ()
  (interactive)
 (start-process "mplayer" nil "mplayer" 'schizophrenia-break-end-sound)
)

;; https://emacs.stackexchange.com/questions/63987/timer-runs-immediately-then-periodically
;; (run-at-time "25 min" nil #'schizophrenia-start-sound)

;; call with say: (schizophrenia-say "meditate")
(defun schizophrenia-say (text)
  (interactive)
  (start-process "espeak" nil "espeak" text)
)


(provide 'schizophrenia)
