## Ejecución

Seguir estos pasos en el IDE de CLIPS.

- File -> Load... ->  "loader.clp"
- Escribir en la ventana de diálogo (Dialog Window):
```
(loader)
(imprimir (tablero))
```

## Edición
#### Cambiar tamaño

Para cambiar de tamaño del tablero, usar `(bind ?*tamanoFila* ?V)` con el valor deseado.
Luego se podrá llamar con `(tablero)` y verlo con `(imprimir (tablero))`.

Por ejemplo, para cambiar el tablero a 4x4:
```
(bind ?*tamanoFila* 4)
(imprimir (tablero))
```
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
		(case 2 then (tablero2))
		...
	)
)
```

## Información extra

`Prueba.clp` es un archivo de prueba desaprobado *(no usar)*.