;; path is valid for straight.el
(defcustom schizophrenia-start-sound (when load-file-name
                                      (concat (file-name-directory load-file-name)
                                              "../../repos/schizophrenia/sounds/org.gnome.Solanum-beep.ogg"))
  "The path to a sound file that´s to be played when a timeblock has started."
  :group 'schizophrenia
  :type 'file)

(defcustom schizophrenia-end-sound (when load-file-name
                                      (concat (file-name-directory load-file-name)
                                              "../../repos/schizophrenia/sounds/org.gnome.Solanum-chime.ogg"))
  "The path to a sound file that´s to be played when a timeblock has ended."
  :group 'schizophrenia
  :type 'file)

(defcustom schizophrenia-break-end-sound (when load-file-name
                                      (concat (file-name-directory load-file-name)
                                              "../../repos/schizophrenia/sounds/coin-collect-game-start-pixabay.mp3"))
  "The path to a sound file that´s to be played when a break has ended."
  :group 'schizophrenia
  :type 'file)

(defun schizophrenia-play-start-sound ()
  (interactive)
  (start-process "mplayer" nil "mplayer" schizophrenia-start-sound)
)

(defun schizophrenia-play-end-sound ()
  (interactive)
  (start-process "mplayer" nil "mplayer" schizophrenia-end-sound)
)

(defun schizophrenia-play-break-end-sound ()
  (interactive)
  (start-process "mplayer" nil "mplayer" schizophrenia-break-end-sound)
)

;; https://emacs.stackexchange.com/questions/6029/is-it-possible-to-execute-a-function-or-command-at-a-specific-time
;; (run-at-time "20:30" nil #'schizophrenia-start-sound)
;; https://emacs.stackexchange.com/questions/63987/timer-runs-immediately-then-periodically
;; (run-at-time "25 min" nil #'schizophrenia-start-sound)

;; call with say: (schizophrenia-say "meditate")
(defun schizophrenia-say (text)
  (interactive)
  (start-process "espeak" nil "espeak" text)
  )

(defun schizophrenia-timeblock (timeblockName time)
  (interactive)
  ;; if time is in future (valid), play sounds and espeak timeblock, otherwise ignore
  (if (string>
       time (format-time-string "%H:%M" (current-time))
       )
      (progn
        (run-at-time time nil 'schizophrenia-play-start-sound)
        ;; https://stackoverflow.com/questions/53734416/run-function-with-arguments-inside-of-a-standard-hook
       (run-at-time time nil (apply-partially 'schizophrenia-say timeblockName))
       )
  "false"
    )
  )




(provide 'schizophrenia)
