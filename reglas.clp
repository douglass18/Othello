; CONFIGURACION

(deftemplate configuracion
	(slot tamano (type INTEGER)) ; 4 / 8
	(slot o (type SYMBOL)) ; CPU / HUMAN
	(slot x (type SYMBOL)) ; CPU / HUMAN
)

(deftemplate juego
	(slot turno (type SYMBOL))
	(multislot tablero)
)

; INICIAL

(deffacts inicio
	(inicial)
)

(defrule inicial
	?inicial <- (inicial)
=>
	(printout t "Tamaño: 4 / 8" crlf)
	(bind ?tamano (read))
	
	(printout t "Jugador O: cpu / human" crlf)
	(bind ?o (read))
	
	(printout t "Jugador X: cpu / human" crlf)
	(bind ?x (read))
	
	(assert (configuracion (tamano ?tamano) (o ?o) (x ?x)))
	(retract ?inicial)
)

(defrule r-configuracion
	?configuracion <- (configuracion (tamano ?tamano) (o ?o) (x ?x))
=>
	(bind ?*tamanoFila* ?tamano)
	(assert (juego (turno X) (tablero (tablero))))
)

; CAMBIAR TURNO

(defrule r-OtoX
	?cambiar <- (cambiar-turno)
	?juego <- (juego (turno O))
=>
	(modify ?juego (turno X))
	(retract ?cambiar)
)

(defrule r-XtoO
	?cambiar <- (cambiar-turno)
	?juego <- (juego (turno X))
=>
	(modify ?juego (turno O))
	(retract ?cambiar)
)

; MOVER

(defrule r-mover
	?mover <- (mover ?x ?y)
	(turno ?jugador)
	(tablero $?tablero)
=>
	(mover ?x ?y ?jugador $?tablero)
	(assert (cambiar-turno))
	(retract ?mover)
)

;(defrule fuera
;	?mover <- (mover ?x ?y)
;	(test (or
;		(or
;			(< ?x 1)
;			(> ?x ?*tamanoFila*)
;		)
;		(or
;			(< ?y 1)
;			(> ?y ?*tamanoFila*)
;		)
;	))
;=>
;	(mover ?x ?y ?)
;	(retract ?mover)
;)