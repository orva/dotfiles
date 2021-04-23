#!/bin/env guile
# vim ft=scheme.guile
!#

(use-modules
  (srfi srfi-1)
  (ice-9 match)
  (ice-9 format)
  (ice-9 popen)
  (ice-9 ftw)
  (ice-9 textual-ports))

(define (batteries)
  (let* ((basedir "/sys/class/power_supply/")
	 (pred (lambda (filename) (string-contains filename "BAT")))
	 (battery-files (scandir basedir pred)))
    (map (lambda (bat) (string-append basedir bat))
	 battery-files)))

(define (battery-percentage battery-file)
  (call-with-input-file
    (string-append battery-file "/capacity")
    (lambda (port) (get-line port))))

(define (string->network-status s)
  (match s
    ("disconnected"	'disconnected)
    ("connected" 	'connected)
    ("unavailable" 	'unavailable)
    (_ 			'network-unknown-state)))

(define (string->network-type s)
  (match s
    ("wifi" 	'wifi)
    ("ethernet" 'ethernet)
    ("loopback" 'loopback)
    ("wifi-p2p" 'wifi-p2p)
    (_ 		'network-unknown-type)))

(define (string->network s)
  (match (string-split s #\:)
	 ((status type name)
	  (list
	    (string->network-type type)
	    (string->network-status status)
	    name))))

(define (nm-networks)
  (let* ((port (open-input-pipe "nmcli --terse --fields 'state,type,connection' device"))
	 (connections (get-string-all port)))
    (close-pipe port)
    (map string->network
	 (filter (lambda (s) (not (string-null? s)))
		 (string-split connections #\newline)))))

(define (networks)
  (fold
    (lambda (nw out)
      (match nw
	     (('wifi 'disconnected _) (string-append "wifi:disconnected " out))
	     (('wifi 'connected name) (string-append "wifi:" name out))
	     (_ out)))
    ""
    (nm-networks)))

(define (output)
  (format #t
	  "~a | BAT: ~a% | ~a ~%"
	  (networks)
	  (battery-percentage (first (batteries)))
	  (strftime "%a %Y-%m-%d - %k:%M" (localtime (current-time))))
  (sleep 5)
  (output))

(setvbuf (current-output-port) 'line)
(output)
