(clear)

(defrule data-input 
    (initial-fact)
    =>
    (printout t crlf "Mood (sad - 0, neutral - 1, happy - 2): ") 
    (bind ?mood (read))
    (assert (mood ?mood))

    (printout t crlf "Temperature (Celsium): ") 
    (bind ?temp (read))
    (assert (temp ?temp))

    (printout t crlf "Rain/show (yes - 1, no - 0): ")
    (bind ?rain (read))
    (assert (rain ?rain))

    (printout t crlf "Occasion (work - 0, event - 1, shop - 2, walk - 3): ")
    (bind ?occ (read))
    (assert (occ ?occ))

    (printout t crlf "Privious tie (no - 0, plain - 1, strips - 2, cubes - 3, stars - 4): ")
    (bind ?prev (read))
    (assert (prev ?prev))
)

(defrule bad-weather
    (temp ?temp)
    (rain ?rain)
    (test 
        (or 
            (= ?rain 1) 
            (and 
                (= ?rain 0) 
                (or (< ?temp 10) (> ?temp 25))
            )
        )
    ) 
    =>
    (printout t crlf crlf "Bad weather." crlf) 
    (assert (weather "bad"))
)

(defrule good-weather
    (temp ?temp)
    (rain ?rain)
    (test 
        (and 
            (= ?rain 0) 
            (>= ?temp 10) 
            (<= ?temp 25)
        )
    ) 
    =>
    (printout t crlf crlf "Good weather." crlf) 
    (assert (weather "good"))
)

(defrule better-mood-1
    (mood ?mood)
    (weather ?weather)
    (test (and (eq ?weather "good") (= ?mood 0))) 
    =>
    (printout t crlf crlf "With good weather you will feel better." crlf) 
    (assert (fmood "neutral"))
)

(defrule better-mood-2
    (mood ?mood)
    (weather ?weather)
    (test (and (eq ?weather "good") (= ?mood 1))) 
    =>
    (printout t crlf crlf "With good weather you will feel better." crlf) 
    (assert (fmood "happy"))
)

(defrule better-mood-3
    (mood ?mood)
    (weather ?weather)
    (test (and (eq ?weather "good") (= ?mood 2))) 
    =>
    (printout t crlf crlf "You already feel greate." crlf) 
    (assert (fmood "happy"))
)

(defrule worse-mood-1
    (mood ?mood)
    (weather ?weather)
    (test (and (eq ?weather "bad") (= ?mood 0))) 
    =>
    (printout t crlf crlf "You already sad, weather will not make it worse." crlf) 
    (assert (fmood "sad"))
)

(defrule worse-mood-2
    (mood ?mood)
    (weather ?weather)
    (test (and (eq ?weather "bad") (= ?mood 1))) 
    =>
    (printout t crlf crlf "Weather is bad and so is the mood." crlf) 
    (assert (fmood "sad"))
)

(defrule worse-mood-3
    (mood ?mood)
    (weather ?weather)
    (test (and (eq ?weather "bad") (= ?mood 2))) 
    =>
    (printout t crlf crlf "You will feel slightly down, but it's okay." crlf) 
    (assert (fmood "neutral"))
)

(defrule no-need-for-tie
    (occ ?occ)
    (test (> ?occ 1)) 
    =>
    (printout t crlf crlf "You don't event need tie." crlf) 
    (assert (tie "no"))
)

(defrule star-mood
    (occ ?occ)
    (fmood ?fmood)
    (prev ?prev)
    (test 
        (and 
            (<= ?occ 1)
            (eq ?fmood "happy")
        )
    ) 
    =>
    (printout t crlf crlf "With good mood you will feel like a star!" crlf) 
    (assert (tie "stars"))
)

(defrule plain-mood
    (occ ?occ)
    (fmood ?fmood)
    (prev ?prev)
    (test 
        (and 
            (<= ?occ 1)
            (eq ?fmood "sad")
        )
    ) 
    =>
    (printout t crlf crlf "Keep it boring." crlf) 
    (assert (tie "plain"))
)

(defrule neutral-mood-1
    (occ ?occ)
    (fmood ?fmood)
    (prev ?prev)
    (test 
        (and 
            (<= ?occ 1)
            (eq ?fmood "neutral")
            (= ?prev 2)
        )
    ) 
    =>
    (printout t crlf crlf "Time for cubes." crlf) 
    (assert (tie "cubes"))
)

(defrule neutral-mood-2
    (occ ?occ)
    (fmood ?fmood)
    (prev ?prev)
    (test 
        (and 
            (<= ?occ 1)
            (eq ?fmood "neutral")
            (= ?prev 3)
        )
    ) 
    =>
    (printout t crlf crlf "Time for strips." crlf) 
    (assert (tie "strips"))
)

(defrule neutral-mood-3
    (occ ?occ)
    (fmood ?fmood)
    (prev ?prev)
    (test 
        (and 
            (<= ?occ 1)
            (eq ?fmood "neutral")
            (or (= ?prev 0) (= ?prev 1) (= ?prev 4))
        )
    ) 
    =>
    (printout t crlf crlf "Let it be strips." crlf) 
    (assert (tie "strips"))
)
