; CONFIGURACION

(deftemplate configuracion
	(slot tamano (type INTEGER)) ; 4 / 8
	(slot o (type SYMBOL)) ; cpu / human
	(slot x (type SYMBOL)) ; cpu / human
	(slot imprimir (type SYMBOL)) ; true / false
)

(deftemplate juego
	(slot turno (type SYMBOL))
	(multislot tablero)
	(slot o (type INTEGER))
	(slot x (type INTEGER))
)

; INICIAL

(deffacts inicio
	(inicial)
)

(defrule r-inicial
	?inicial <- (inicial)
=>
	(printout t "¿Congifuración por defecto?: true / false" crlf)
	(bind ?por-defecto (read))
	
	(if (eq ?por-defecto false) then
		(printout t "Tamaño: 4 / 8" crlf)
		(bind ?tamano (read))
	
		(printout t "Jugador O: cpu / human" crlf)
		(bind ?o (read))
	
		(printout t "Jugador X: cpu / human" crlf)
		(bind ?x (read))
	
		(printout t "Imprimir: TRUE / FALSE" crlf)
		(bind ?imprimir (read))
	else
		(bind ?tamano 8)
		(bind ?o human)
		(bind ?x human)
		(bind ?imprimir TRUE)
	)
	
	(assert (configuracion (tamano ?tamano) (o ?o) (x ?x) (imprimir ?imprimir)))
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
	(configuracion (x ?x))
=>
	(if (eq ?x human) then
		(assert (human))
	else
		(assert (cpu)))
	(modify ?juego (turno X))
	(retract ?cambiar)
)

(defrule r-XtoO
	?cambiar <- (cambiar-turno)
	?juego <- (juego (turno X))
	(configuracion (o ?o))
=>
	(if (eq ?o human) then
		(assert (human))
	else
		(assert (cpu)))
	(modify ?juego (turno O))
	(retract ?cambiar)
)

; MOVER

(defrule r-human
	?human <- (human)
=>
	(printout t "x: ")
	(bind ?x (read))
	
	(printout t "y: ")
	(bind ?y (read))
	
	(printout t crlf)
	
	(assert (mover ?x ?y))
	(retract ?human)
)

(defrule r-mover
	?mover <- (mover ?x ?y)
	(configuracion (imprimir ?imprimir))
	(juego (turno ?jugador) (tablero $?tablero))
=>
	(mover ?x ?y ?jugador $?tablero)
	(if ?imprimir then
		(imprimir $?tablero)
	)
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