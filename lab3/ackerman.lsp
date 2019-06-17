(defun ackerman (x y)
    ;; (format t "> x=~D, y=~D~%" x y)
    (cond 
        ;; якщо У == 0 то ігноруємо Х і повертаємо 0
        ((= y 0) 0)
        ;; якщо Х == 0 то подвоюємо У
        ((= x 0) (* 2 y))  
        ;; якщо У == 1 то повертаємо 2
        ((= y 1) 2)  
        ;; якшо жодна з попередніх умов не виконалась, 
        ;; то вказуєму завжди істинну умову (t) і рекурсивно повертаємо
        ;; функцію акермана ack(x-1, ack(x, y-1))
        (t (ackerman (- x 1) (ackerman x (- y 1))))))  


;; варіант функції акерамана з вікіпєдії
(defun ackerman2 (m n)
    ;; (format t "> m=~A, n=~A~%" m n)
    (cond 
        ((= m 0) (+ n 1))
        ((and (> m 0) (= n 0)) (ackerman2 (- m 1) 1))  
        ((and (> m 0) (> n 0)) (ackerman2 (- m 1) (ackerman2 m (- n 1))))))  


(defun calculate (x y) 
    (format t "ackerman(~D, ~D) => ~D~%" x y (ackerman x y)))

(defun calculate2 (x y) 
    (format t "ackerman2(~D, ~D) => ~D~%" x y (ackerman2 x y)))

(calculate 4 1)
(loop for x in '(0 1 2 3)
  do (loop for y in '(0 1 2 3 4) 
    do (calculate2 x y)))
