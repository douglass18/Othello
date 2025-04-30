## Ejecución

Seguir estos pasos en el IDE de CLIPS.

- File -> Load... ->  "loader.clp"
- Escribir en la ventana de diálogo (Dialog Window):
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

## Edición

#### Añadir tamaño

Para añadir un nuevo tamaño de tablero, crear su respectiva función `(tablero?V)`,
y añadirla al `switch` dentro de la función `(tablero)` con su respectivo tamaño.

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

## Información extra

`Prueba.clp` es un archivo de prueba desaprobado *(no usar)*.