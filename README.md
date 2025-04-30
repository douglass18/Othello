## Ejecuci�n

Seguir estos pasos en el IDE de CLIPS.

- File -> Load... ->  "loader.clp"
- Escribir en la ventana de di�logo (Dialog Window):
```
(loader)
```
Para imprimir:
```
(imprimir (tablero))
```
Para jugar:
```
(run)
8
human
human
(assert (cambiar-turno))
```

## Edici�n

#### A�adir tama�o

Para a�adir un nuevo tama�o de tablero, crear su respectiva funci�n `(tablero?V)`,
y a�adirla al `switch` dentro de la funci�n `(tablero)` con su respectivo tama�o.

Por ejemplo, para crear el tablero 2x2:
```
(deffunction tablero2 ()
	(return (create$
		_ O
		X _
	))
)

(deffunction tablero ()
	(switch ?*tamanoFila*
		(case 2 then (return (tablero2)))
		...
	)
)
```

## Informaci�n extra

`Prueba.clp` es un archivo de prueba desaprobado *(no usar)*.