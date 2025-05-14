(deffunction imprimir($?tablero)
	
	(printout t crlf "      ")
	(loop-for-count (?i 1 ?*tamanoFila*)
		(printout t ?i "   ")
	)
	(printout t crlf)
	(printout t "     ")
	(loop-for-count ?*tamanoFila*
		(printout t "___ ")
	)
	(printout t crlf)
	
	(loop-for-count (?i 1 ?*tamanoFila*)
		(printout t "    ")
		(loop-for-count ?*tamanoFila*
			(printout t "|   ")
		)
		(printout t "|" crlf)
		(printout t "  " ?i " |")
		;;;;;;;;;;;;;;;;;;;;;;;;
		;aquí consigo una fila entera del tablero
		(bind ?fila_0 (+ (* (- ?i 1) ?*tamanoFila*) 1))
		(bind ?fila_f (* ?i ?*tamanoFila*))
		(bind $?fila (subseq$ $?tablero ?fila_0 ?fila_f))
		; (printout t "Fila: " ?fila_0 ", " ?fila_f crlf)
		;;;;;;;;;;;;;;;;;;;;;;;
		(loop-for-count (?j 1 ?*tamanoFila*)
			(if (eq (nth$ ?j $?fila) _)
				then (printout t "   " "|")
				else(printout t " " (nth$ ?j $?fila) " |")
			)
			
		)
		(printout t crlf "    ")
		(loop-for-count ?*tamanoFila*
			(printout t "|___")
		)
		(printout t "|" crlf)
	)
	(printout t crlf)
)

(deffunction imprimir-succesors ($?succesors)
	(loop-for-count (?i 1 (div (length$ $?succesors) 2))
		(bind ?j (* ?i 2))
		(printout t (nth$ (- ?j 1) $?succesors) "," (nth$ ?j $?succesors) "; ")
	)
	(printout t crlf)
)