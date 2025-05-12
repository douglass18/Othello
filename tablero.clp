(defglobal ?*tamanoFila* = 8)

(deffunction tablero4 ()
	(return (create$
		_ _ _ _
		_ O X _
		_ X O _
		_ _ _ _
	))
)
(deffunction tablero6 ()
	(return (create$
		_ _ _ _ _ _
		_ _ _ _ _ _
		_ _ O X _ _
		_ _ X O _ _
		_ _ _ _ _ _
		_ _ _ _ _ _
	))
)
(deffunction tablero8 ()
	(return (create$
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ O X _ _ _
		_ _ _ X O _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
	))
)


(deffunction tablero ()
	(switch ?*tamanoFila*
		(case 4 then (return (tablero4)))
		(case 6 then (return (tablero6)))
		(case 8 then (return (tablero8)))
	)
)

; Devuelve la ficha opuesta al jugador
(deffunction opuesto (?jugador)
	(switch ?jugador
		(case O then (return X))
		(case X then (return O))
	)
)

; Facilita la conversión de Punto a Índice de multislot
(deffunction parse-nth (?x ?y)
	(return (+ ?x (* (- ?y 1) ?*tamanoFila*))) ; x + ((y - 1) * TAMANO_FILA)
)

; Facilita la conversión de Índice de multislot a Punto
(deffunction parse-x-y (?nth)
	(bind ?x (mod ?nth ?*tamanoFila*)) ; nth % TAMANO_FILA
	(bind ?y (+ (div ?nth ?*tamanoFila*) 1)) ; nth / TAMANO_FILA + 1
	(return (create$ ?x ?y))
)

; Devuelve el símbolo en dado Punto
(deffunction obtener (?x ?y $?tablero)
	(return (nth$ (parse-nth ?x ?y) $?tablero))
)

; Coloca la ficha del jugador en dado Punto
(deffunction cambiar (?x ?y ?jugador $?tablero)
	(bind ?n (parse-nth ?x ?y))
	(return (replace$ $?tablero ?n ?n ?jugador))
)

; Indica si la ficha se encuentra fuera
(deffunction fuera (?x ?y $?tablero)
	;x < min || max < x
	;||
	;y < min || max < y
	(return
		(or
			(or (< ?x 0) (< ?*tamanoFila* ?x))
			(or (< ?y 0) (< ?*tamanoFila* ?y))
		)
	)
)

(deffunction posicion-valida (?x ?y $?tablero)
	(return (eq _ (obtener ?x ?y $?tablero)))
)

(deffunction direccion-valida (?x ?y ?dx ?dy ?jugador $?tablero)
	
	(bind ?opuesto (opuesto ?jugador))
	(bind ?nx (+ ?x ?dx))
	(bind ?ny (+ ?y ?dy))
	
	(bind ?cnt 0)
	
	; recorrer casillas opuestas
	(while (and
			(not (fuera ?nx ?ny))
			(eq ?opuesto (obtener ?nx ?ny $?tablero))
	)
		(bind ?nx (+ ?nx ?dx))
		(bind ?ny (+ ?ny ?dy))
		
		(bind ?cnt (+ ?cnt 1))
	)
	; termina el tablero
	(if (fuera ?nx ?ny) then
		(return 0)
	)
	; termina en una ficha propia, habiendo recorrido al menos una opuesta
	(if (and (> ?cnt 0) (eq ?jugador (obtener ?nx ?ny $?tablero))) then
		(return ?cnt)
	else
		(return 0)
	)
)

(deffunction revertir (?x ?y ?dx ?dy ?jugador $?tablero)

	(bind ?opuesto (opuesto ?jugador))
	(bind ?nx (+ ?x ?dx))
	(bind ?ny (+ ?y ?dy))
	
	(while (eq ?opuesto (obtener ?nx ?ny $?tablero))
		(bind $?tablero (cambiar ?nx ?ny ?jugador $?tablero))
		(bind ?nx (+ ?nx ?dx))
		(bind ?ny (+ ?ny ?dy))
	)
	
	(return $?tablero)
)
	