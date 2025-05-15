
# Indice.md

- **loader.clp**	
- **tablero.clp**
- **imprimir.clp**
- **cpu.clp**
- **reglas.clp**



# loader.clp

**function** loader



# tablero.clp

**global** tamanoFila = 8

**function** tablero4

**function** tablero8

**function** tablero

**function** opuesto ?jugador

**function** parse-nth ?x ?y

**function** parse-x-y ?nth

**function** obtener ?x ?y $?tablero

**function** cambiar ?x ?y ?jugador $?tablero

**function** fuera ?x ?y $?tablero

**function** posicion-valida ?x ?y $?tablero

**function** direccion-valida ?x ?y ?dx ?dy ?jugador $?tablero

**function** revertir ?x ?y ?dx ?dy ?jugador $?tablero

### CPU RELATED FUNCTIONS

**function** get-succesors ?jugador $?tablero

# imprimir.clp

**function** imprimir $?tablero

**function** imprimir-succesors $?succesors



# cpu.clp

**global** MIN = -999

**global** MAX = +999

**function** simular-movimiento ?x ?y ?jugador $?tablero

**function** controlar-esquinas ?jugador $?tablero

**function** controlar-centro ?jugador $?tablero

**function** voltear-mas ?jugador ?O ?X

**function** evaluar-tablero ?jugador $?tablero

**[abstract] function** minmax ?jugador ?profundidad ?esMax $?tablero

**function** max-value ?jugador ?profundidad $?tablero

**function** min-value ?jugador ?profundidad $?tablero

**function** minmax ?jugador ?profundidad ?esMax $?tablero

**function** mejor-movimiento ?jugador ?profundidad $?tablero



# reglas.clp

### [TEMPLATES]

**template** configuracion: tamano, O, X, imprimir

**template** juego: turno, O, X, tablero

**template** casilla: x, y, L, U, R, D, UL, DL, DR, UR

### INICIAL

**facts** f-inicio: (inicial)

**rule** r-inicial <= (inicial)

### CAMBIAR TURNO

**function** assert-quien ?quien

**function** quien ?jugador ?O ?X

**rule** r-OtoX <=	(cambiar-turno), 
					(juego (turno O)),
					(configuracion (X ?))

**rule** r-XtoO <=	(cambiar-turno),
					(juego (turno X)),
					(configuracion (O ?))

### CONFIGURACION

**rule** r-configuracion <=	(configuracion (tamano ?) (O ?) (X ?))

### IMPRIMIR

**rule** r-imprimir (salience 1) <=	(configuracion (imprimir TRUE)),
									(juego (tablero $?)),
									(imprimir)

**rule** r-clear-imprimir (salience 1) <= (imprimir)

### MOVER

**rule** r-human <= (human)

**rule** r-casilla-valida <=	(configuracion (O ?O) (X ?)),
								(mover ? ?),
								(juego (turno ?) (tablero $?)),
								(test (posicion-valida ? ? $?))

**rule** r-casilla-no-valida <=	(configuracion (O ?) (X ?)),
								(mover ? ?),
								(juego (turno ?) (tablero $?))
	
### REVERTIR

**function** revertir-hacia ?juego ?x ?y ?dx ?dy ?cnt ?jugador ?O ?X $?tablero

**rule** r-revertir-% [8] <=	(juego (turno ?) (O ?) (X ?) (tablero $?)),
							(casilla (x ?) (y ?) (% ?)),
							(test (> ? 0))

**rule** r-revertir <=	(configuracion (imprimir ?)),
						(juego (turno ?) (O ?) (X ?) (tablero $?)),
						(casilla (x ?) (y ?))

### META

**rule** r-is-victoria <=	(declare (salience 20)),
							(is-victoria),
							(juego (O ?) (X ?) (tablero $?)),
							(test (= (length$ (get-succesors O $?)) 0)),
							(test (= (length$ (get-succesors X $?)) 0))

**rule** r-not-victoria <=	(declare (salience 20))
							(is-victoria)
