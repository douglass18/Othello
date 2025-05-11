; [TEMPLATES]

(deftemplate configuracion
	(slot tamano (type INTEGER)) ; 4 / 8
	(slot O (type SYMBOL)) ; cpu / human
	(slot X (type SYMBOL)) ; cpu / human
	(slot imprimir (type SYMBOL)) ; true / false
)

(deftemplate juego
	(slot turno (type SYMBOL))
	(slot O (type INTEGER))
	(slot X (type INTEGER))
	(multislot tablero)
)

(deftemplate casilla
	; posicion
	(slot x (type INTEGER))
	(slot y (type INTEGER))
	; contadores
	(slot L  (type INTEGER)) ;  ←
	(slot U  (type INTEGER)) ;  ↑
	(slot D  (type INTEGER)) ;  ↓
	(slot R  (type INTEGER)) ;  →
	(slot UL (type INTEGER)) ; ↑←
	(slot DL (type INTEGER)) ; ↓←
	(slot DR (type INTEGER)) ;  →↓
	(slot UR (type INTEGER)) ;  →↑
)

; INICIAL

(deffacts inicio
	(inicial)
)

(defrule r-inicial
	?inicial <- (inicial)
=>
	(printout t "¿Congifuración por defecto?: TRUE / FALSE" crlf)
	(bind ?por-defecto (read))
	
	(if ?por-defecto then
		(bind ?tamano 8)
		(bind ?O human)
		(bind ?X human)
		(bind ?imprimir TRUE)
	else
		(printout t "Tamaño: 4 / 8" crlf)
		(bind ?tamano (read))
	
		(printout t "Jugador O: cpu / human" crlf)
		(bind ?O (read))
	
		(printout t "Jugador X: cpu / human" crlf)
		(bind ?X (read))
	
		(printout t "Imprimir: TRUE / FALSE" crlf)
		(bind ?imprimir (read))
	)
	
	(assert (configuracion (tamano ?tamano) (O ?O) (X ?X) (imprimir ?imprimir)))
	(retract ?inicial)
)

; CAMBIAR TURNO

; Realiza (assert) junto al tipo que se desea
(deffunction assert-quien (?quien)
	(if (eq ?quien human) then
		(assert (human))
	)
	(if (eq ?quien cpu) then
		(assert (cpu))
	)
)

(deffunction quien (?jugador ?O ?X)
	(if (eq ?jugador O) then
		(return ?O)
	)
	(if (eq ?jugador X) then
		(return ?X)
	)
)

(defrule r-OtoX
	?cambiar <- (cambiar-turno)
	?juego <- (juego (turno O))
	(configuracion (X ?X))
=>
	(assert-quien ?X)
	(modify ?juego (turno X))
	(retract ?cambiar)
)

(defrule r-XtoO
	?cambiar <- (cambiar-turno)
	?juego <- (juego (turno X))
	(configuracion (O ?O))
=>
	(assert-quien ?O)
	(modify ?juego (turno O))
	(retract ?cambiar)
)

; CONFIGURACION

(defrule r-configuracion
	?configuracion <- (configuracion (tamano ?tamano) (O ?O) (X ?X))
=>
	(bind ?*tamanoFila* ?tamano)
	(assert (juego (turno X) (O 2) (X 2) (tablero (tablero))))
	(assert-quien ?X)
	(assert (imprimir))
)

; IMPRIMIR

(defrule r-imprimir
	(declare (salience 100))
	(configuracion (imprimir TRUE))
	(juego (tablero $?tablero))
	(imprimir)
=>
	(imprimir $?tablero)
)

(defrule r-clear-imprimir
	(declare (salience 100))
	?imprimir <- (imprimir)
=>
	(retract ?imprimir)
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

; Comprueba si la casilla es valida
(defrule r-casilla-valida
	(configuracion (O ?O) (X ?X))
	?mover <- (mover ?x ?y)
	?juego <- (juego (turno ?jugador) (tablero $?tablero))
	(test (posicion-valida ?x ?y $?tablero))
=>
	(bind ?L  (direccion-valida ?x ?y -1  0 ?jugador $?tablero))
	(bind ?U  (direccion-valida ?x ?y  0 -1 ?jugador $?tablero))
	(bind ?D  (direccion-valida ?x ?y  0  1 ?jugador $?tablero))
	(bind ?R  (direccion-valida ?x ?y  1  0 ?jugador $?tablero))
	
	(bind ?UL (direccion-valida ?x ?y -1 -1 ?jugador $?tablero))
	(bind ?DL (direccion-valida ?x ?y -1  1 ?jugador $?tablero))
	(bind ?DR (direccion-valida ?x ?y  1  1 ?jugador $?tablero))
	(bind ?UR (direccion-valida ?x ?y  1 -1 ?jugador $?tablero))
		
	(bind ?total (+ ?L ?U ?D ?R ?UL ?DL ?DR ?UR))
	(if (> ?total 0) then
		(assert (casilla (x ?x) (y ?y)	
				(L  ?L)  (U  ?U)  (D  ?D)  (R  ?R)
				(UL ?UL) (DL ?DL) (DR ?DR) (UR ?UR)
		))
		(retract ?mover)
	)
)

(defrule r-casilla-no-valida
(configuracion (O ?O) (X ?X))
	?mover <- (mover ?x ?y)
	?juego <- (juego (turno ?jugador) (tablero $?tablero))
=>
	(printout t "NO VALIDO" crlf)
	(assert-quien (quien ?jugador ?O ?X))
	(retract ?mover)
)

; REVERTIR

(defrule r-revertir-L
	?juego <- (juego (turno ?jugador) (tablero $?tablero))
	?casilla <- (casilla (x ?x) (y ?y) (L ?L))
	(test (> ?L 0))
=>
	(bind $?n-tablero (revertir ?x ?y -1  0 ?jugador $?tablero))
	(modify ?juego (tablero $?n-tablero))
	(modify ?casilla (L 0))
)
(defrule r-revertir-U
	?juego <- (juego (turno ?jugador) (tablero $?tablero))
	?casilla <- (casilla (x ?x) (y ?y) (U ?U))
	(test (> ?U 0))
=>
	(bind $?tablero (revertir ?x ?y  0 -1 ?jugador $?tablero))
	(modify ?juego (tablero $?tablero))
	(modify ?casilla (U 0))
)
(defrule r-revertir-D
	?juego <- (juego (turno ?jugador) (tablero $?tablero))
	?casilla <- (casilla (x ?x) (y ?y) (D ?D))
	(test (> ?D 0))
=>
	(bind $?tablero (revertir ?x ?y  0  1 ?jugador $?tablero))
	(modify ?juego (tablero $?tablero))
	(modify ?casilla (D 0))
)
(defrule r-revertir-R
	?juego <- (juego (turno ?jugador) (tablero $?tablero))
	?casilla <- (casilla (x ?x) (y ?y) (R ?R))
	(test (> ?R 0))
=>
	(bind $?tablero (revertir ?x ?y  1  0 ?jugador $?tablero))
	(modify ?juego (tablero $?tablero))
	(modify ?casilla (R 0))
)

(defrule r-revertir-UL
	?juego <- (juego (turno ?jugador) (tablero $?tablero))
	?casilla <- (casilla (x ?x) (y ?y) (UL ?UL))
	(test (> ?UL 0))
=>
	(bind $?n-tablero (revertir ?x ?y -1 -1 ?jugador $?tablero))
	(modify ?juego (tablero $?n-tablero))
	(modify ?casilla (UL 0))
)
(defrule r-revertir-DL
	?juego <- (juego (turno ?jugador) (tablero $?tablero))
	?casilla <- (casilla (x ?x) (y ?y) (DL ?DL))
	(test (> ?DL 0))
=>
	(bind $?tablero (revertir ?x ?y -1  1 ?jugador $?tablero))
	(modify ?juego (tablero $?tablero))
	(modify ?casilla (DL 0))
)
(defrule r-revertir-DR
	?juego <- (juego (turno ?jugador) (tablero $?tablero))
	?casilla <- (casilla (x ?x) (y ?y) (DR ?DR))
	(test (> ?DR 0))
=>
	(bind $?tablero (revertir ?x ?y  1  1 ?jugador $?tablero))
	(modify ?juego (tablero $?tablero))
	(modify ?casilla (DR 0))
)
(defrule r-revertir-UR
	?juego <- (juego (turno ?jugador) (tablero $?tablero))
	?casilla <- (casilla (x ?x) (y ?y) (UR ?UR))
	(test (> ?UR 0))
=>
	(bind $?tablero (revertir ?x ?y  1 -1 ?jugador $?tablero))
	(modify ?juego (tablero $?tablero))
	(modify ?casilla (UR 0))
)

; Revertir final
(defrule r-revertir
	(configuracion (imprimir ?imprimir))
	?juego <- (juego (turno ?jugador) (tablero $?tablero))
	?casilla <- (casilla (x ?x) (y ?y))
=>
	(bind $?tablero (cambiar ?x ?y ?jugador $?tablero))
	
	(modify ?juego (tablero $?tablero))
	(assert (cambiar-turno))
	(assert (imprimir))
	(retract ?casilla)
)
