(deffunction loader ()

	(printout t "[LOAD]" crlf)
	
	
	
	(printout t "[LOADING \"tablero.clp\"]" crlf) 
	(load "tablero.clp")
	(printout t "[LOADING \"imprimir.clp\"]" crlf) 
	(load "imprimir.clp")
	(printout t "[LOADING \"reglas.clp\"]" crlf)
	(load "reglas.clp")
	
	(printout t "[RESET]" crlf)
	
	(reset)
)