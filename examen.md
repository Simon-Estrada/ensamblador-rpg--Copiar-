# Examen — La Leyenda del Registro

**Asignatura:** Fundamentos de Infraestructura
**Unidad:** Ensamblador x86-64 (NASM) — Clases 1, 2 y 3
**Duración:** 90 minutos
**Modalidad:** individual, en la VM de Ubuntu con NASM instalado
**Material permitido:** las carpetas `clase-01/`, `clase-02/`, `clase-03/` y la documentación de syscalls de Linux. **No** se permite internet, IA generativa ni copiar entre estudiantes.

---

## Instrucciones generales

1. Trabaja dentro de tu propia carpeta de examen. Copia las tres clases a `examen/clase-01`, `examen/clase-02`, `examen/clase-03`.
2. **Cada entrega es un archivo.** Donde se pide "muestra", pega la salida real entre bloques de código. No inventes salidas: el profesor puede re-ejecutar tu binario.
3. **Parte práctica:** los artefactos (salidas, `strace`, código modificado, binarios) van en `examen/entrega.md` (creas tú este archivo).
4. **Preguntas conceptuales** (tanto de la Parte A como de la B) se responden directamente en este documento, dentro de los bloques `[RESOLVER AQUÍ]`.
5. Al final, entrega: tu carpeta `examen/` con los `.asm`, los binarios, `entrega.md` y este `examen.md` con las respuestas.

**Criterio de aprobación:** ≥ 70% de la nota total. Cada sección indica su puntaje.

---

# PARTE A — PRÁCTICA: seguir y ejecutar las clases (60 pts)

> Regla de oro: si algo no compila, no pasa a la siguiente. **No se acepta "no compiló" como respuesta.**
> Documenta el error completo y el intento de solución.

---

## A.1 — El despertar (Clase 1) — 10 pts

### A.1.1 (4 pts)
Compila y ejecuta la clase 1. Documenta en `entrega.md`:

- El comando exacto de compilación y el de enlazado.
- La salida completa del programa.
- El código de salida (`echo $?`).

### A.1.2 (6 pts)
Ejecuta `strace -e trace=write,exit_group ./clase01 2> trace1.txt` y responde (pega también el
`strace` en `entrega.md`):

1. ¿Cuántas llamadas `write` hay en total?
2. ¿Cuál es el código de salida que devuelve `exit_group`?
3. ¿Qué número de syscall usa `write`? (pista: mira la columna `syscall` o el `strace` completo).

[RESOLVER AQUÍ: 
1. Hay 3 llamadas write, una por cada texto.
2. El exit_group no aparece porque el programa llama directamente a exit (syscall 60). El código 0 se ve en la línea +++ exited with 0 +++
3. write usa el syscall número 1, se ve en el código (mov rax, 1 antes de cada syscall) y en la tabla de la sección 3.2. strace normalmente muestra el nombre, no el número.
]

---

## A.2 — El nombre del héroe (Clase 2) — 15 pts

### A.2.1 (5 pts)
Compila y ejecuta la clase 2 con **tres** nombres distintos:

1. Un nombre corto (≤ 5 letras).
2. Un nombre de **exactamente 31** letras.
3. Un nombre de **40** letras.

Documenta la salida de cada caso en `entrega.md`.

[RESOLVER AQUÍ: ¿Qué ocurre en el caso 3? Explica por qué, citando qué línea del `.asm` lo provoca.

En el caso 3 lo que pasa es que como en el programa estrictamente se van a leer solo 32 bytes e ingresamos un nombre mayor a este valor. Entonces como ingrese: simonlopezestradaforeronietowerprograma solo se va a mostrar hasta despues de la p y el rograma que queda luego la terminal ejecuta lo que por asi decirlo quedo pendiente.

La linea que lo provoca es la **mov rdx, 32** , y lo que dice es que lea como maximo 32 bytes ]

### A.2.2 (5 pts)
Ejecuta `strace -e trace=read,write ./clase02` con un nombre de 10 letras (pega el `strace` en `entrega.md`) y responde:

1. ¿Cuántos bytes devuelve la llamada `read`?
2. ¿Por qué ese número y no 32 (el tamaño del buffer)?
3. ¿En qué variable del código se guarda ese valor de retorno?

[RESOLVER AQUÍ:
1. La llamada `read` devuelve exactamente 11 bytes, puesto que la entrada tiene 10 caracteres mas el salto de linea.
2. Porque `read` se encarga de leer los bytes que estan ingresando, mientras que los 32 son los que hay disponibles, siendo este mismo valor el "tope" por asi decirlo.
3. Ese valor llega en el registro **RAX** cuando el syscall termina.]

### A.2.3 (5 pts) — Modificación obligatoria
En tu copia de `clase02.asm`, cambia **dos** cosas y haz que siga compilando y ejecutando:

1. Cambia el saludo (`saludo`) a una frase tuya (debe incluir "reino" o "heroe").
2. Cambia la despedida (`despedida`) a una frase tuya.

Pega en `entrega.md` el bloque `.data` modificado y la salida de tu programa con el nombre `Gandalf`.

---

## A.3 — Los atributos del héroe (Clase 3) — 20 pts

### A.3.1 (8 pts)
Compila la clase 3 y ejecútala con las **cinco** combinaciones de (FUE, AGI) de la tabla. Completa la tabla con la salida real (ELITE / NOVATO / ERROR) y el código de salida:

| Caso | FUE | AGI | ¿ELITE o NOVATO o ERROR? | Código salida (`$?`) |
|------|-----|-----|--------------------------|----------------------|
| 1    | 3   | 5   |          ELITE           | 0                    |
| 2    | 0   | 9   |          ELITE           | 0                    |
| 3    | 9   | 9   |          ERROR           | 1                    |
| 4    | 0   | 0   |          NOVATO          | 0                    |
| 5    | `x` | 5   |          NOVATO          | 0                    |

> Caso 5: en lugar de un dígito, escribe la letra `x`.

[RESOLVER AQUÍ: ¿Qué hace el programa con la letra `x`? ¿Por qué no se rompe?

Cuando escribes la letra x, el programa no la acepta como un número. Antes de usar lo que escribiste, revisa que sea un dígito del 0 al 9. 
para eso usa la tabla ASCII, donde cada carácter tiene un número. El '0' es el 48 y el '9' es el 57, por lo que cualquier dígito está entre esos dos valores. La x vale 120, que es mayor que 57, entonces el programa sabe que no es un dígito.
Cuando eso pasa, salta a la parte del código que pone FUE en 0. Por eso en el caso 5 el programa muestra FUE:0 y calcula 0+5=5, que lo deja como NOVATO.
No se rompe porque nunca intenta hacer cuentas con la x. La revisa primero, se da cuenta de que no sirve y la cambia por un 0. Así el programa sigue normal hasta el final y termina con código 0, sin errores.

]

### A.3.2 (6 pts)
Con `strace -e trace=write,read,exit_group ./clase03`, usando FUE=8, AGI=2 (pega el `strace` en `entrega.md`), responde:

1. ¿Cuántas llamadas `write` hay? Enuméralas (qué texto escribe cada una).
2. ¿Cuántas llamadas `read` hay?
3. ¿Por qué `read` devuelve siempre `2` y no `1`?

[RESOLVER AQUÍ:

1. Hay 5 llamadas `write`. La primera escribe el título "LA LEYENDA DEL REGISTRO v0.3", la segunda la explicación de los 9 puntos, la tercera la pregunta de la fuerza "FUE (fuerza, 0 a 9): ", la cuarta la pregunta de la agilidad "AGI (agilidad, 0 a 9): " y la quinta el mensaje "Error: no te alcanzan los 9 puntos.". No se alcanzan a imprimir los atributos porque 8 + 2 da 10, que es más de los 9 puntos permitidos, y el programa termina antes con código 1.

2. Hay 2 llamadas `read`, una cuando pide la fuerza y otra cuando pide la agilidad.

3. `read` devuelve 2 porque cuando escribimos un número y presionamos Enter, en realidad se mandan dos cosas: el dígito y el salto de línea (byte 10). Por eso el buffer `buf` se reservó de 2 bytes, para que quepan los dos. También vale la pena aclarar que `exit_group` no aparece en el strace porque el programa termina con la syscall 60 (`exit`) y no con `exit_group`, por eso solo se ve `+++ exited with 1 +++`.

 ]

### A.3.3 (6 pts) — Modificación obligatoria
Implementa el **Ejercicio 1** de la clase 3 ("El heroe se enfada"): si FUE es 0, muestra la frase
`"Un heroe sin fuerza no es heroe."` y sigue el flujo normal.

Requisitos:

- Usa `cmp byte [v_fue], 0` y un salto `je` a un bloque nuevo `.sin_fuerza`.
- El programa debe seguir imprimiendo el bloque de atributos y terminar con código 0.
- Pega en `entrega.md` las líneas que agregaste y la salida completa con FUE=0, AGI=3.

---

## A.4 — Crear desde cero (15 pts)

Escribe un programa **nuevo** (`examen/heroe.asm`) **sin usar libc** que:

1. Imprima `"Nombre: "` (sin salto de línea).
2. Lea el nombre desde el teclado (buffer de 16 bytes en `.bss`).
3. Imprima el nombre.
4. Imprima un salto de línea.
5. Termine con código de salida 0.

Compílalo con `nasm -f elf64` y `ld`. Pega en `entrega.md` el código completo y la salida al ejecutarlo con el nombre `Sauron`.

> No copies la clase 2: el programa debe ser más corto (solo 4 `write`/`read` + `exit`).

---

# PARTE B — TEORÍA: preguntas (40 pts)

> Responde dentro de los bloques `[RESOLVER AQUÍ]`.
> Se valora **explicar con tus palabras**, no solo la respuesta correcta.

---

## B.1 — Selección múltiple (5 pts, 1 pt c/u)

**1.** ¿Cuál es el número de syscall de `sys_write` en Linux x86-64?

- a) 0
- b) 1
- c) 60
- d) 2

[RESOLVER AQUÍ: El numero de llamada al sistema para sys_write es el 1, por ende la respuesta correcta es la `b) 1`  ]

---

**2.** ¿En qué registro se pone el **número de syscall** antes de ejecutar `syscall`?

- a) `rdi`
- b) `rsi`
- c) `rax`
- d) `rdx`

[RESOLVER AQUÍ: El numero del syscall se pone en el registro `RAX`, por lo tanto la respuesta correcta es la `c) rax`]

---

**3.** ¿Qué sección usa `resb` para reservar memoria sin ocuparla en el binario?

- a) `.data`
- b) `.text`
- c) `.bss`
- d) `.rodata`

[RESOLVER AQUÍ: Se usa en la seccion .bss, esta seccion se usa para declarar variables y reservar espacio. La respuesta correcta es `c) .bss` ]

---

**4.** ¿Qué valor de retorno trae `rax` después de un `sys_read`?

- a) 0 siempre
- b) La cantidad de bytes leídos realmente
- c) El tamaño del buffer
- d) El código de error

[RESOLVER AQUÍ: El valor de retorno de rax es la cantidad de bytes leidos realmente en el ejemplo de Gandalf son 7 caracteres mas el salto de linea, entonces el valor de retorno de rax seria 8. La respuesta correcta es `b)` ]

---

**5.** En clase 3, ¿qué instrucción decide entre ELITE y NOVATO?

- a) `add`
- b) `inc`
- c) `cmp` + `jge`
- d) `sub`

[RESOLVER AQUÍ: Al abrir el archivo de la clase 3 hay una linea que dice **cmp byte [v_used], 6 jge .elite**, esto quiere decir que el programa determina el nivel del heroe basandose en lo gastado contra el 6. La respuesra correcta es `c)`]

---

## B.2 — Verdadero o Falso con justificación (10 pts, 2 pts c/u)
> Marca V o F. Si es F, escribe la corrección. Una respuesta correcta sin justificación vale 1 pt.

**1.** `db` declara 8 bits (1 byte) por elemento de datos.
[RESOLVER AQUÍ:

**Verdadero.** `db` significa "define byte", y cada elemento que se declara con `db` ocupa 1 byte, o sea 8 bits. Por ejemplo, en `titulo db "LA LEYENDA DEL REGISTRO v0.3", 10` cada letra ocupa un byte, y el 10 del salto de línea también ocupa uno.

 ]

---

**2.** `mov rax, 60` seguido de `syscall` es la forma estándar de terminar un programa en este curso.
[RESOLVER AQUÍ: 

**Verdadero.** El 60 es el número de la syscall `exit` en Linux x86-64, y así terminan todos los programas del curso. Antes del `syscall` también se pone en `rdi` el código de salida, por ejemplo `mov rdi, 0` cuando todo salió bien o `mov rdi, 1` cuando hubo error, como en la clase 3. Ese es el número que después vemos con `echo $?`.

]

---

**3.** `resb 32` escribe 32 bytes de ceros en el binario.
[RESOLVER AQUÍ: 

**Falso.** `resb 32` no escribe nada en el binario, solo reserva 32 bytes de espacio en la sección `.bss`. Ese espacio no ocupa lugar en el archivo ejecutable, y es el sistema operativo el que lo aparta en memoria (lleno de ceros) cuando el programa arranca.

**Corrección:** `resb 32` reserva 32 bytes en `.bss` sin ocupar espacio en el binario.

]

---

**4.** En clase 2, el valor de `lon` (la longitud leída) viene de un `equ` fijo calculado por el ensamblador.
[RESOLVER AQUÍ: 

**Falso.** El `equ` se calcula al ensamblar, antes de que el programa se ejecute, así que solo sirve para cosas fijas como el largo de un texto que ya está escrito en el código. El nombre lo escribe el usuario mientras el programa corre, así que su largo no se puede saber de antemano.

**Corrección:** el valor de `lon` viene del registro `rax`, que es lo que devuelve `sys_read` con la cantidad de bytes que se leyeron. Luego se le resta 1 con `dec rax` para quitar el salto de línea del Enter.

]

---

**5.** `add al, 48` convierte un dígito numérico (0–9) en su carácter ASCII imprimible.
[RESOLVER AQUÍ: 

**Verdadero.** En la tabla ASCII el carácter `'0'` vale 48, `'1'` vale 49, y así hasta `'9'`, que vale 57. Entonces si a un número del 0 al 9 le sumamos 48, obtenemos el código de su carácter. Por ejemplo, 3 + 48 = 51, que es `'3'`. Es justo lo que hace la clase 3 antes de imprimir FUE, AGI y VID. Al leer se hace lo contrario: se resta 48 para pasar del carácter al número.

]

---

## B.3 — Lectura de código: predice la salida (6 pts)

Dado este fragmento (un programa mínimo y completo):

```asm
section .data
    msg db "HOLA", 10
    len equ $ - msg

section .text
    global _start
_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, len
    syscall
    mov rax, 60
    mov rdi, 3
    syscall
```

1. ¿Qué imprime el programa? (2 pts)
2. ¿Con qué código de salida termina? ¿Qué significa ese código? (2 pts)
3. ¿Cuántas llamadas al kernel (`syscall`) hay? (2 pts)

[RESOLVER AQUÍ:
1. **¿Qué imprime el programa?**
Imprime la palabra `HOLA` seguida de un salto de linea (`\n`, byte 10). Por lo tanto, en total se esta escribiendo **5 bytes**.

2.**¿Con qué código de salida termina? ¿Qué significa ese código?**
Termina con el código de salida `3`. Esto significa que el programa esta retornando un valor de salida `3` al sistema operativo (especificado en `mov rdi, 3` antes de salir del sistema).

3. **¿Cuántas llamadas al kernel (`syscall`) hay?**
Hay **2** llamadas al `syscall`: La primera ejecuta `sys_write (rax = 1)` que es la que imprime el texto en la pantalla. Y la segunda ejecuta `sys_exit (rax = 60)`, para terminar el programa.
 ]



---

## B.4 — Encuentra el error (4 pts)

El siguiente código **debería** imprimir `7` pero **no lo hace**. Encuentra el error, explícalo y escribe la línea corregida.

```asm
section .bss
    d resb 1

section .text
    global _start
_start:
    mov al, 7          ; el número a imprimir
    mov [d], al        ; guardar el carácter
    mov rax, 1
    mov rdi, 1
    mov rsi, d
    mov rdx, 1
    syscall
    mov rax, 60
    mov rdi, 0
    syscall
```

> Pista: el programa **debería** imprimir el carácter `7` en pantalla.
> ¿Qué byte está guardando realmente en `d`? ¿Qué instrucción de la
> clase 3 está ausente para que un número (0–9) se vuelva un carácter
> imprimible?

[RESOLVER AQUÍ:El programa está guardando directamente el valor númerico entero de `7` en la variable `d`. En la tabla ASCII, el byte `7` no es un número visible `7`, sino que es un cáracter de control no imprimible, que lo llaman **BEL** o más fácil de recordar **timbre**. Para que el programa muestre en la pantalla el carácter visible de `7`, tiene que convertir el entero a su código **ASCII** sumándole `48`, esto debido a que `0` en código **ASCII** equivale a 48, por lo que 7+48=55, que es el código de `7`. ]

---

## B.5 — Respuesta corta (10 pts, 2.5 pts c/u)

**1.** ¿Por qué en clase 2 se reserva `resb 32` para un nombre de "máximo 31 letras"?

[RESOLVER AQUÍ: Se reservan 32 bytes porque el nombre ocupa hasta 31 letras, y queda 1 byte para el salto de linea que el teclado agrega al presionar enter.]

---

**2.** ¿Por qué la clase 2 quita el último byte (LF) del nombre antes de imprimirlo, usando `dec rax`?

[RESOLVER AQUÍ: ya que sys_read devuelve en rax la cantidad de bytes leídos, y eso incluye también el LF del enter, y con dec rax se resta 1 a esa longitud, así el write imprime solo las letras del nombre, sin el salto de línea.]

---

**3.** En clase 3, ¿por qué el programa valida FUE y AGI por separado (0–9) **y además** valida que la suma sea ≤ 9?

[RESOLVER AQUÍ: Porque cada validación protege algo distinto, la validación por separado (0–9) verifica que lo que el usuario escribió sea realmente un dígito y no un carácter, y la validación de la suma (≤ 9) verifica que el resultado quepa en un solo dígito, porque se imprime con add al, 48, que solo da un carácter válido para valores de 0 a 9.]

---

**4.** ¿Qué significa `equ $ - etiqueta` y por qué es útil en vez de contar los bytes a mano?

[RESOLVER AQUÍ: $ es la dirección actual del ensamblador y etiqueta es donde empieza el texto, así que $ - etiqueta es la distancia en bytes entre ambos, o sea la longitud del texto. Es útil porque el ensamblador la calcula solo, asi si se cambia el texto, la longitud se actualiza y no se rompe el rdx del write, además que contar a mano es propenso a errores.]

---

## B.6 — Escribe el código (5 pts)

**1. (2 pts)** Escribe el bloque exacto (registros + `syscall`) para **imprimir la cadena**
`"FIN\n"` (con salto de línea) usando `sys_write`. Supón que la cadena está en la etiqueta `fin` y su longitud en `len_fin`.

[RESOLVER AQUÍ: ]

---

**2. (3 pts)** Escribe las líneas de ensamblador para:

- Leer hasta **2 bytes** (1 dígito + el LF del Enter) desde el teclado en un buffer `b` (de `.bss`), usando `sys_read` — igual que la clase 3.
- Validar que sea un dígito entre `'0'` (48) y `'9'` (57); si no lo es, saltar a una etiqueta `.mal`.
- Si es dígito, convertirlo a número (restando 48) y guardarlo en la variable numérica `n` (1 byte, de `.bss`).

[RESOLVER AQUÍ: ]

---

# RÚBRICA DE CALIFICACIÓN

| Sección | Tema | Puntos |
|---------|------|--------|
| A.1 | Clase 1: compilar, ejecutar, strace | 10 |
| A.2 | Clase 2: leer, buffer, modificación | 15 |
| A.3 | Clase 3: atributos, validación, modif. | 20 |
| A.4 | Crear desde cero | 15 |
| **Parte A** | **Práctica** | **60** |
| B.1 | Selección múltiple | 5 |
| B.2 | Verdadero/Falso (5 × 2) | 10 |
| B.3 | Predicción de salida (3 × 2) | 6 |
| B.4 | Encontrar el error (1 pregunta) | 4 |
| B.5 | Respuesta corta (4 × 2.5) | 10 |
| B.6 | Escribir código (2 + 3) | 5 |
| **Parte B** | **Teoría** | **40** |
| **TOTAL** | | **100** |

> **Nota final = (puntos obtenidos / 100) × 20.**
> Aprobación: ≥ 14/20 (es decir, ≥ 70% = 70 pts).

---

# CHECKLIST DE ENTREGA

Antes de entregar, verifica que tu carpeta `examen/` contenga:

- [ ] `clase-01/clase01.asm`, `clase-01/clase01` (binario), `clase-01/trace1.txt`
- [ ] `clase-02/clase02.asm` (modificado), `clase-02/clase02` (binario)
- [ ] `clase-03/clase03.asm` (modificado), `clase-03/clase03` (binario)
- [ ] `heroe.asm` y `heroe` (binario)
- [ ] `entrega.md` con todas las salidas y modificaciones pegadas
- [ ] Este `examen.md` con todos los bloques `[RESOLVER AQUÍ]` respondidos
- [ ] `strace` guardados donde se pidieron

**Recuerda:** el héroe del examen no es el que más rápido termina, sino el que
puede explicar cada línea que escribió.
