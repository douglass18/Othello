(deffunction start4 ()
	(imprimir (create$
		_ O X _
		_ X X _
		X O _ O
		X X O _
	))
)
(deffunction start8 ()
	(imprimir (create$
		_ O X X _ O _ O
		O X _ X O _ O _
		X _ _ X _ O _ O
		_ O O X O _ O X
		X O O O _ O X _
		O _ O _ O X _ X
		_ O _ O X _ X O
		O _ O X _ O O X
	))
)


(deffunction start ()
	(switch ?*tamanoFila*
		(case 4 then (start4))
		(case 8 then (start8))
	)
)