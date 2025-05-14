;Constantes globales

(defglobal
	?*MIN* = -999 ;;
	?*MAX* =  999 ;; 
)
;Algoritmo MinMax

(deffunction minmax (?jugador $?tablero ?profundidad ?esMax)
  (bind ?sucesores (get-succesors ?jugador $?tablero))
  
  ; Caso terminal: profundidad 0 o no hay movimientos posibles
  (if (or (= ?profundidad 0) (= (length$ ?sucesores) 0)) then
    (return (evaluar-tablero ?jugador $?tablero))
  )
  
  (if ?esMax then
    (return (max-value ?jugador $?tablero ?profundidad))
  else
    (return (min-value ?jugador $?tablero ?profundidad))
  )
)

(deffunction max-value (?jugador $?tablero ?profundidad)
  (bind ?v ?*MIN*) ; 
  (bind ?sucesores (get-succesors ?jugador $?tablero))
  
  (loop-for-count (?i 1 (div (length$ ?sucesores) 2))
    (bind ?x (nth$ (- (* ?i 2) 1) ?sucesores))
    (bind ?y (nth$ (* ?i 2) ?sucesores))
    
    ; Simular movimiento
    (bind ?nuevo-tablero (simular-movimiento ?x ?y ?jugador $?tablero))
    
    ; Llamada recursiva
    (bind ?valor (minmax (opuesto ?jugador) ?nuevo-tablero (- ?profundidad 1) FALSE))
    
    (bind ?v (max ?v ?valor))
  )
  (return ?v)
)

(deffunction min-value (?jugador $?tablero ?profundidad)
  (bind ?v ?*MAX*) ;
  (bind ?sucesores (get-succesors ?jugador $?tablero))
  
  (loop-for-count (?i 1 (div (length$ ?sucesores) 2))
    (bind ?x (nth$ (- (* ?i 2) 1) ?sucesores))
    (bind ?y (nth$ (* ?i 2) ?sucesores))
    
    ; Simular movimiento
    (bind ?nuevo-tablero (simular-movimiento ?x ?y ?jugador $?tablero))
    
    ; Llamada recursiva
    (bind ?valor (minmax (opuesto ?jugador) ?nuevo-tablero (- ?profundidad 1) TRUE))
    
    (bind ?v (min ?v ?valor))
  )
  (return ?v)
)

(deffunction simular-movimiento (?x ?y ?jugador $?tablero)
    ; Primero colocamos la ficha
    (bind ?nuevo-tablero (cambiar ?x ?y ?jugador $?tablero))
    
    ; Revertimos en todas las direcciones posibles
    (bind ?direcciones (create$ 
        -1  0  ; L
         0 -1  ; U
         0  1  ; D
         1  0  ; R
        -1 -1  ; UL
        -1  1  ; DL
         1  1  ; DR
         1 -1  ; UR
    ))
    
    (loop-for-count (?i 1 (div (length$ ?direcciones) 2))
        (bind ?dx (nth$ (- (* ?i 2) 1) ?direcciones))
        (bind ?dy (nth$ (* ?i 2) ?direcciones))
        
        (if (> (direccion-valida ?x ?y ?dx ?dy ?jugador $?tablero) 0) then
            (bind ?nuevo-tablero (revertir ?x ?y ?dx ?dy ?jugador ?nuevo-tablero))
        )
    )
    
    (return ?nuevo-tablero)
)

(deffunction evaluar-tablero (?jugador $?tablero)
  ; Función de evaluación simple: diferencia de fichas entre un jugador y otro
  (bind ?O 0)
  (bind ?X 0)
  
  (loop-for-count (?i 1 (length$ $?tablero))
    (if (eq (nth$ ?i $?tablero) O) then
      (bind ?O (+ ?O 1))
    else if (eq (nth$ ?i $?tablero) X) then
      (bind ?X (+ ?X 1))
    )
  )
  
  (if (eq ?jugador O) then
    (return (- ?O ?X))
  else
    (return (- ?X ?O))
  )
)
  
)