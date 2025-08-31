;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "evil" "20250812.1023"
  "Extensible vi layer."
  '((emacs    "24.1")
    (cl-lib   "0.5")
    (goto-chg "1.6")
    (nadvice  "0.3"))
  :url "https://github.com/emacs-evil/evil"
  :commit "334a636621577e77f834bca0c6ecdcec67c6ff1e"
  :revdesc "334a63662157"
  :keywords '("emulations")
  :maintainers '(("Tom Dalziel" . "tom.dalziel@gmail.com")))
