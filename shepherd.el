;; path is valid for straight.el
(defcustom shepherd-start-sound (when load-file-name
                                      (concat (file-name-directory load-file-name)
                                              "../../repos/shepherd/sounds/org.gnome.Solanum-beep.ogg"))
  "The path to a sound file that´s to be played when a timeblock has started."
  :group 'shepherd
  :type 'file)

(defcustom shepherd-end-sound (when load-file-name
                                      (concat (file-name-directory load-file-name)
                                              "../../repos/shepherd/sounds/org.gnome.Solanum-chime.ogg"))
  "The path to a sound file that´s to be played when a timeblock has ended."
  :group 'shepherd
  :type 'file)

(defcustom shepherd-break-end-sound (when load-file-name
                                      (concat (file-name-directory load-file-name)
                                              "../../repos/shepherd/sounds/coin-collect-game-start-pixabay.mp3"))
  "The path to a sound file that´s to be played when a break has ended."
  :group 'shepherd
  :type 'file)

(defun shepherd-play-start-sound ()
  (interactive)
  (start-process "mplayer" nil "mplayer" shepherd-start-sound)
)

(defun shepherd-play-end-sound ()
  (interactive)
  (start-process "mplayer" nil "mplayer" shepherd-end-sound)
)

(defun shepherd-play-break-end-sound ()
  (interactive)
  (start-process "mplayer" nil "mplayer" shepherd-break-end-sound)
)

;; https://emacs.stackexchange.com/questions/6029/is-it-possible-to-execute-a-function-or-command-at-a-specific-time
;; (run-at-time "20:30" nil #'shepherd-start-sound)
;; https://emacs.stackexchange.com/questions/63987/timer-runs-immediately-then-periodically
;; (run-at-time "25 min" nil #'shepherd-start-sound)

;; call with say: (shepherd-say "meditate")
(defun shepherd-say (text)
  (interactive)
  (start-process "espeak" nil "espeak" text)
  )

(defun shepherd-add-to-flock (timeblockName time)
  (interactive)
  ;; if time is in future (valid), play sounds and espeak timeblock, otherwise ignore
  (if (string>
       time (format-time-string "%H:%M" (current-time))
       )
      ;; true
      (progn
        (run-at-time time nil 'shepherd-play-start-sound)
        ;; https://stackoverflow.com/questions/53734416/run-function-with-arguments-inside-of-a-standard-hook
       (run-at-time time nil (apply-partially 'shepherd-say timeblockName))
       )
  "false"
    )
  )




(provide 'shepherd)
