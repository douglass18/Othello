(deffunction loader ()

	(printout t "[LOAD]" crlf)
	
	(load "C:/Users/ErikA/Documents/GitHub/Othello/tablero.clp")
	(load "C:/Users/ErikA/Documents/GitHub/Othello/reglas.clp")
	(load "C:/Users/ErikA/Documents/GitHub/Othello/imprimir.clp")
	
	(printout t "[RESET]" crlf)
	
	(reset)
)