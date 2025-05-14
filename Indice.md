# reglas.clp

## [TEMPLATES]

**template** configuracion: tamano, O, X, imprimir

**template** juego: turno, O, X, tablero

**template** casilla: x, y, L, U, R, D, UL, DL, DR, UR

## INICIAL

facts: (inicial)

**rule** r-inicial <= (inicial)

## CAMBIAR TURNO

**function** assert-quien ?quien

**function** quien ?jugador ?O ?X

**rule** r-OtoX <=	(cambiar-turno), 
					(juego (turno O)),
					(configuracion (X ?))

**rule** r-XtoO <=	(cambiar-turno),
					(juego (turno X)),
					(configuracion (O ?))

## CONFIGURACION

**rule** r-configuracion <=	(configuracion (tamano ?) (O ?) (X ?))

## IMPRIMIR

**rule** r-imprimir (salience 1) <=	(configuracion (imprimir TRUE)),
									(juego (tablero $?)),
									(imprimir)

**rule** r-clear-imprimir (salience 1) <= (imprimir)

## MOVER

**rule** r-human <= (human)

**rule** r-casilla-valida <=	(configuracion (O ?O) (X ?)),
								(mover ? ?),
								(juego (turno ?) (tablero $?)),
								(test (posicion-valida ? ? $?))

**rule** r-casilla-no-valida <=	(configuracion (O ?) (X ?)),
								(mover ? ?),
								(juego (turno ?) (tablero $?))
								
## CPU RELATED FUNCTIONS

**function** get-succesors ?jugador $?tablero

**function** is-victoria ?O ?X ?jugador $?tablero

**rule** r-get-succesors (salience 10) <=	(get-succesors),
											(juego (turno ?) (tablero $?))