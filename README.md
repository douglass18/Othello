## Ejecuci�n

Seguir estos pasos en el IDE de CLIPS.

- File -> Load... ->  "loader.clp"
- Escribir en la ventana de di�logo (Dialog Window):
```
(loader)
(imprimir (tablero))
```

## Edici�n
#### Cambiar tama�o

Para cambiar de tama�o del tablero, usar `(bind ?*tamanoFila* ?V)` con el valor deseado.
Luego se podr� llamar con `(tablero)` y verlo con `(imprimir (tablero))`.

Por ejemplo, para cambiar el tablero a 4x4:
```
(bind ?*tamanoFila* 4)
(imprimir (tablero))
```
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
		(case 2 then (tablero2))
		...
	)
)
```

## Informaci�n extra

`Prueba.clp` es un archivo de prueba desaprobado *(no usar)*.