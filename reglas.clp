(deffacts inicio
	(turno X)
	(tablero (tablero))
)

; CAMBIAR TURNO

(defrule OtoX
	?c <- (cambiar-turno)
	?t <- (turno O)
=>
	(assert (turno X))
	(retract ?c ?t)
)

(defrule XtoO
	?cambiar <- (cambiar-turno)
	?turno <- (turno X)
=>
	(assert (turno O))
	(retract ?cambiar ?turno)
)

; MOVER

(defrule mover
	?mover <- (mover ?x ?y)
	(turno ?jugador)
	(tablero ($?tablero))
=>
	(mover (?x ?y ?jugador $?tablero))
	(assert (cambiar-turno))
	(retract ?mover)
)

(defrule fuera
	(mover ?x ?y)
	...
)