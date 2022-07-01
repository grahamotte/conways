#lang racket

; racket conway.rkt

(define size 50)

(define (tof _) (equal? 0 (random 2)))

(define board
  (map (lambda (x) (map tof (range size))) (range size)))

(define (tos board)
  (string-join
    (map
      (lambda (row)
        (string-join
          (map
            (lambda (col) (if col "●" "·"))
            row)
          " "))
      board)
  "\n"))

(define (tick board)
  (map
    (lambda (row)
      (map
        (lambda (col) (if col #f #t))
        row))
    board))

(display (tos (tick board)))
