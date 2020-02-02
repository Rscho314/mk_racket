#lang racket

(require "microKanren.scm")
(require "miniKanren-wrappers.scm")
(require "microKanren-test.scm")
(require "microKanren-test-programs.scm")

;;EXPERIMENTS
(define ap
  (lambda (l s out)
    (disj
     (conj (== '() l) (== s out))
     (call/fresh
      (lambda (a)
        (call/fresh
         (lambda (d)
           (conj
            (== `(,a . ,d) l)
            (call/fresh
             (lambda (res)
               (conj
                (== `(,a . ,res) out)
                (lambda (s/c)
                  (lambda ()
                    ((ap d s res) s/c))))))))))))))

(((ap '(a) '(b) '(a b)) empty-state))
