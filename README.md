## Ejecuci�n
Seguir estos pasos en el IDE de CLIPS.

- File -> Load... -> "imprimir.clp"
- File -> Load... -> "iniciar.clp"
- Escribir en la terminal:
```
(start)
```

## Edici�n
#### Cambiar tama�o
Para cambiar de tama�o del tablero, usar `(bind ?*tamanoFila* ?V)` con el valor deseado. Luego se podr� llamar con `(start)`.

Por ejemplo, para cambiar al tablero a 4x4:
```
(bind ?*tamanoFila* 4)
(start)
```
#### A�adir tama�o
Para a�adir un nuevo tama�o de tablero, crear su respectiva funci�n `(startV)`, y a�adirla al `switch` dentro de la funci�n `(start)` con su respectivo tama�o.

Por ejemplo, para crear el tablero 2x2:
```
(deffunction start2 ()
	(imprimir (create$
		_ O
		X _
	))
)

(deffunction start ()
	(switch ?*tamanoFila*
		(case 2 then (start2))
		...
	)
)
```

## Informaci�n extra
`Prueba.clp` es un archivo de prueba desaprobado *(no usar)*