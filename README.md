## Ejecución
Seguir estos pasos en el IDE de CLIPS.

- File -> Load... -> "imprimir.clp"
- File -> Load... -> "iniciar.clp"
- Escribir en la terminal:
```
(start)
```

## Edición
#### Cambiar tamaño
Para cambiar de tamaño del tablero, usar `(bind ?*tamanoFila* ?V)` con el valor deseado. Luego se podrá llamar con `(start)`.

Por ejemplo, para cambiar al tablero a 4x4:
```
(bind ?*tamanoFila* 4)
(start)
```
#### Añadir tamaño
Para añadir un nuevo tamaño de tablero, crear su respectiva función `(startV)`, y añadirla al `switch` dentro de la función `(start)` con su respectivo tamaño.

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

## Información extra
`Prueba.clp` es un archivo de prueba desaprobado *(no usar)*