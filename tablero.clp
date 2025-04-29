(defglobal ?*tamanoFila* = 8)

(deffunction tablero4 ()
	(return (create$
		_ _ _ _
		_ O X _
		_ X O _
		_ _ _ _
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
		(case 4 then (tablero4))
		(case 8 then (tablero8))
	)
)

(deffunction mover (?x ?y ?j)
	(replace$ )
)
	