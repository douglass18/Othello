(deffunction loader ()

	(printout t "[LOAD]" crlf)
	
	(printout t "[LOADING \"tablero.clp\"]" crlf) 
	(load "C:/Users/ErikA/Documents/GitHub/Othello/tablero.clp")
	(printout t "[LOADING \"imprimir.clp\"]" crlf) 
	(load "C:/Users/ErikA/Documents/GitHub/Othello/imprimir.clp")
	(printout t "[LOADING \"reglas.clp\"]" crlf) 
	(load "C:/Users/ErikA/Documents/GitHub/Othello/reglas.clp")
	
	(printout t "[RESET]" crlf)
	
	(reset)
)