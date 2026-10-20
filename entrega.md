# integrantes:
- Luna Sofia Oviedo Rios
- David Alejandro Henao Jaramillo
- Simón Lopez Estrada
- Laura Daniela Vega Herrera

# Solucion Parcial 1 Fundamentos
## A1 Solucion - El despertar
### A.1.1
Para este ejercicio se pedia compilar y ejecutar la clase 1. Mostrando comandos de compilación y enlazado, además de su salida completa y echo $?.
### Compilación:
```bash
nasm -f elf64 clase01.asm -o clase01.o
```

### Enlazado:
```bash
ld clase01.o -o clase01
```

### Salida del programa:
```
LA LEYENDA DEL REGISTRO v0.1
Bienvenido, heroe. Tu aventura empieza aqui.
El sistema operativo te despidio con elegancia (código 0).
```

### Código de salida (`echo $?`):
```
0
```

### A.1.2
Para este ejercicio pide ejecutar `strace -e trace=write,exit_group ./clase01 2> trace1.txt` y pegar el strace.

Comando:
```bash
strace -e trace=write,exit_group ./clase01 2> trace1.txt
```

Contenido de `trace1.txt` ejecutado con cat:
```
write(1, "LA LEYENDA DEL REGISTRO v0.1\n", 29) = 29
write(1, "Bienvenido, heroe. Tu aventura e"..., 45) = 45
write(1, "El sistema operativo te despidio"..., 60) = 60
+++ exited with 0 +++
```
---
## A2 Solucion - Nombre del Heroe
### A.2.1
Para este ejercicio se pedia ejecutar la clase02 con el fin de ingresar 3 nombres, uno de 5 caracteres, uno de 31 y otro de 40.

Los nombres con los cuales probe fueron
- simon
- simonlopezestradaforeronietower
- simonlopezestradaforeronietowerprograma

### Salida de **simon**
```
simon@LAPTOP-RVE5FLUI:~/ensamblador-rpg--Copiar-/clase-02$ ./clase02
LA LEYENDA DEL REGISTRO v0.2
Como se llama el heroe? (max 31 letras)
simon
Bienvenido al reino, simon
Tu nombre ya vive en la memoria del proceso.
```
Como se puede ver la salida fue exitosa y devolvio el nombre guardado.

### Salida de **simonlopezestradaforeronietower**
```
simon@LAPTOP-RVE5FLUI:~/ensamblador-rpg--Copiar-/clase-02$ ./clase02
LA LEYENDA DEL REGISTRO v0.2
Como se llama el heroe? (max 31 letras)
simonlopezestradaforeronietower
Bienvenido al reino, simonlopezestradaforeronietower
Tu nombre ya vive en la memoria del proceso.
```
Para este nombre a salida tambien fue exitosa y mostro exactamente el nombre que ingresamos completamente.

### Salida de **simonlopezestradaforeronietowerprograma**
```
simon@LAPTOP-RVE5FLUI:~/ensamblador-rpg--Copiar-/clase-02$ ./clase02
LA LEYENDA DEL REGISTRO v0.2
Como se llama el heroe? (max 31 letras)
simonlopezestradaforeronietowerprograma
Bienvenido al reino, simonlopezestradaforeronietowerp
Tu nombre ya vive en la memoria del proceso.
simon@LAPTOP-RVE5FLUI:~/ensamblador-rpg--Copiar-/clase-02$ rograma
rograma: command not found
```
En este caso el nombre se excedio del limite, por lo tanto solo lee los caracteres que son permitidos y el resto los corto, la cosa es que esos caracteres que sobran, la terminal, los interpreta como si ellos fueran un nuevo comando y por ende sale `rograma: command not found`

### A.2.2
Para este ejercicio se solicita ejecutar el comando ` strace -e trace=read,write ./clase02` primero que todo tuve que intalar con `sudo apt install strace` para poder que funcionara.

**La salida fue la siguiente**

```
simon@LAPTOP-RVE5FLUI:~/ensamblador-rpg--Copiar-/clase-02$ strace -e trace=read,write ./clase02
write(1, "LA LEYENDA DEL REGISTRO v0.2\n", 29LA LEYENDA DEL REGISTRO v0.2
) = 29
write(1, "Como se llama el heroe? (max 31 "..., 40Como se llama el heroe? (max 31 letras)
) = 40
read(0simonnetta
, "simonnetta\n", 32)             = 11
write(1, "Bienvenido al reino, ", 21Bienvenido al reino, )   = 21
write(1, "simonnetta", 10simonnetta)              = 10
write(1, "\n", 1
)                       = 1
write(1, "Tu nombre ya vive en la memoria "..., 45Tu nombre ya vive en la memoria del proceso.
) = 45
+++ exited with 0 +++
```
### A.2.3
Se modifico el saludo y la despedida al gusto de nosotros.

El `.data` quedo de la siguiente manera:
```
section .data
    titulo    db "LA LEYENDA DEL REGISTRO v0.2", 10
    len_titulo equ $ - titulo
    pregunta  db "Como se llama el heroe? (max 31 letras)", 10
    len_pregunta equ $ - pregunta
    saludo   db "Eres bienvenido al reino de equestria, "
    len_saludo equ $ - saludo
    despedida db "Y tu nombre es digno de un poder supremo.", 10
    len_despedida equ $ - despedida
    salto     db 10                                    ; un salto de linea >
```
Y finalmente la salida que obtuvimos fue:
```
simon@LAPTOP-RVE5FLUI:~/ensamblador-rpg--Copiar-/clase-02$ ./clase02
LA LEYENDA DEL REGISTRO v0.2
Como se llama el heroe? (max 31 letras)
Gandalf
Eres bienvenido al reino de equestria, Gandalf
Y tu nombre es digno de un poder supremo.
```
> Aclarar que el nombre que se ingreso fue el solicitado **Gandalf**

---
## A3 Solucion - Los atributos del heroe
### A.3.1
Para este ejercicio se pedia compilar la clase 3 y ejecutarla con cinco combinaciones de FUE y AGI, anotando si el heroe queda ELITE, NOVATO o ERROR, y el codigo de salida.

Primero tuve que instalar nasm con `sudo apt install nasm`. Luego se compilo con:
```bash
nasm -f elf64 clase03.asm -o clase03.o
ld clase03.o -o clase03
```

### Caso 1: FUE = 3, AGI = 5
```
dani@Dani-LAPTOP:~/ensamblador-rpg--Copiar-/clase-03$ ./clase03
LA LEYENDA DEL REGISTRO v0.3
Tienes 9 puntos para repartir. El resto se vuelve vida (VID).
FUE (fuerza, 0 a 9): 3
AGI (agilidad, 0 a 9): 5
El heroe despierta como ELITE del reino.
FUE: 3
AGI: 5
VID: 1
Puntos gastados: 8
Nivel: 2
Los atributos quedaron grabados en los registros del heroe.
dani@Dani-LAPTOP:~/ensamblador-rpg--Copiar-/clase-03$ echo $?
0
```

### Caso 2: FUE = 0, AGI = 9
```
dani@Dani-LAPTOP:~/ensamblador-rpg--Copiar-/clase-03$ ./clase03
LA LEYENDA DEL REGISTRO v0.3
Tienes 9 puntos para repartir. El resto se vuelve vida (VID).
FUE (fuerza, 0 a 9): 0
AGI (agilidad, 0 a 9): 9
El heroe despierta como ELITE del reino.
FUE: 0
AGI: 9
VID: 0
Puntos gastados: 9
Nivel: 2
Los atributos quedaron grabados en los registros del heroe.
dani@Dani-LAPTOP:~/ensamblador-rpg--Copiar-/clase-03$ echo $?
0
```

### Caso 3: FUE = 9, AGI = 9
```
dani@Dani-LAPTOP:~/ensamblador-rpg--Copiar-/clase-03$ ./clase03
LA LEYENDA DEL REGISTRO v0.3
Tienes 9 puntos para repartir. El resto se vuelve vida (VID).
FUE (fuerza, 0 a 9): 9
AGI (agilidad, 0 a 9): 9
Error: no te alcanzan los 9 puntos.
dani@Dani-LAPTOP:~/ensamblador-rpg--Copiar-/clase-03$ echo $?
1
```
Aqui la suma da 18, que supera los 9 puntos, por eso el programa muestra el error y sale con codigo 1.

### Caso 4: FUE = 0, AGI = 0
```
dani@Dani-LAPTOP:~/ensamblador-rpg--Copiar-/clase-03$ ./clase03
LA LEYENDA DEL REGISTRO v0.3
Tienes 9 puntos para repartir. El resto se vuelve vida (VID).
FUE (fuerza, 0 a 9): 0
AGI (agilidad, 0 a 9): 0
El heroe sigue siendo NOVATO: hay margen para crecer.
FUE: 0
AGI: 0
VID: 9
Puntos gastados: 0
Nivel: 1
Los atributos quedaron grabados en los registros del heroe.
dani@Dani-LAPTOP:~/ensamblador-rpg--Copiar-/clase-03$ echo $?
0
```

### Caso 5: FUE = x, AGI = 5
```
dani@Dani-LAPTOP:~/ensamblador-rpg--Copiar-/clase-03$ ./clase03
LA LEYENDA DEL REGISTRO v0.3
Tienes 9 puntos para repartir. El resto se vuelve vida (VID).
FUE (fuerza, 0 a 9): x
AGI (agilidad, 0 a 9): 5
El heroe sigue siendo NOVATO: hay margen para crecer.
FUE: 0
AGI: 5
VID: 4
Puntos gastados: 5
Nivel: 1
Los atributos quedaron grabados en los registros del heroe.
dani@Dani-LAPTOP:~/ensamblador-rpg--Copiar-/clase-03$ echo $?
0
```
Como la `x` no es un digito, el programa la toma como 0.

### A.3.2
Para este ejercicio se pedia ejecutar `strace -e trace=write,read,exit_group ./clase03` con FUE = 8 y AGI = 2, y pegar el strace.

Primero verifique que strace estuviera instalado con `strace -V` (version 6.19). Luego ejecute:
```bash
strace -e trace=write,read,exit_group ./clase03
```

**La salida fue la siguiente**
```
dani@Dani-LAPTOP:~/ensamblador-rpg--Copiar-/clase-03$ strace -e trace=write,read,exit_group ./clase03
write(1, "LA LEYENDA DEL REGISTRO v0.3\n", 29LA LEYENDA DEL REGISTRO v0.3
) = 29
write(1, "Tienes 9 puntos para repartir. E"..., 62Tienes 9 puntos para repartir. El resto se vuelve vida (VID).
) = 62
write(1, "FUE (fuerza, 0 a 9): ", 21FUE (fuerza, 0 a 9): ) = 21
read(08
, "8\n", 2)                       = 2
write(1, "AGI (agilidad, 0 a 9): ", 23AGI (agilidad, 0 a 9): ) = 23
read(02
, "2\n", 2)                       = 2
write(1, "Error: no te alcanzan los 9 punt"..., 36Error: no te alcanzan los 9 puntos.
) = 36
+++ exited with 1 +++
```
Como 8 + 2 = 10 supera los 9 puntos, el programa termina en error con codigo 1 y no imprime los atributos. Se ve todo mezclado porque strace y el programa escriben en la misma pantalla.

### A.3.3
Para este ejercicio se pedia implementar el Ejercicio 1 de la clase 3 ("El heroe se enfada"): si FUE es 0, el programa debe mostrar la frase "Un heroe sin fuerza no es heroe." y seguir normal.

Primero hice una copia del archivo original para no dañarlo:
```bash
cp clase03.asm clase03_mod.asm
```

En la seccion `.data`, debajo de `salto db 10`, agregue la frase:
```nasm
    sin_fuerza db "Un heroe sin fuerza no es heroe.", 10
    len_sin_fuerza equ $ - sin_fuerza
```

Y en el codigo, justo despues de `.fue_leido:`, agregue la comparacion:
```nasm
    ; ---------- Ejercicio 1: el heroe se enfada ----------
    cmp byte [v_fue], 0
    je .sin_fuerza
    jmp .con_fuerza
.sin_fuerza:
    mov rax, 1
    mov rdi, 1
    mov rsi, sin_fuerza
    mov rdx, len_sin_fuerza
    syscall
.con_fuerza:
```
El `cmp` compara la fuerza con 0. Si es 0, el `je` salta a `.sin_fuerza`, que imprime la frase, y despues el programa sigue normal desde `.con_fuerza`. Si la fuerza no es 0, el `jmp` se salta la frase y sigue directo.

Se compilo con:
```bash
nasm -f elf64 clase03_mod.asm -o clase03_mod.o
ld clase03_mod.o -o clase03_mod
```

Salida con FUE = 0 y AGI = 3:
```
dani@Dani-LAPTOP:~/ensamblador-rpg--Copiar-/clase-03$ ./clase03_mod
LA LEYENDA DEL REGISTRO v0.3
Tienes 9 puntos para repartir. El resto se vuelve vida (VID).
FUE (fuerza, 0 a 9): 0
Un heroe sin fuerza no es heroe.
AGI (agilidad, 0 a 9): 3
El heroe sigue siendo NOVATO: hay margen para crecer.
FUE: 0
AGI: 3
VID: 6
Puntos gastados: 3
Nivel: 1
Los atributos quedaron grabados en los registros del heroe.
dani@Dani-LAPTOP:~/ensamblador-rpg--Copiar-/clase-03$ echo $?
0
```
La frase aparece justo despues de ingresar FUE = 0, el programa sigue imprimiendo los atributos y termina con codigo 0.

---

## A.4 - Crear desde cero
Se solicito crear un programa el cual permitiera lo siguiente:
1. Imprima `"Nombre: "` (sin salto de línea).
2. Lea el nombre desde el teclado (buffer de 16 bytes en `.bss`).
3. Imprima el nombre.
4. Imprima un salto de línea.
5. Termine con código de salida 0.

Al final tambien se aclara que el programa debe usarse con el nombre Sauron para determinar la salida.

El codigo completo que quedo dentro del archivo `examen/heroe.asm` es el siguiente:

```
global _start

section .data
    pregunta db "Nombre: "
    len_pregunta equ $ - pregunta

    newline db 10

section .bss
    buffer resb 16

section .text
_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, pregunta
    mov rdx, len_pregunta
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 16
    syscall
    mov rbx, rax

    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    mov rdx, rbx
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall
```

Se compilo con los comandos
1. `nasm -f elf64 heroe.asm -o heroe.o`
2. `ld heroe.o -o heroe`
3. `./heroe`

Y finalmente probamos con el nombre **Sauron**
```
simon@LAPTOP-RVE5FLUI:~/ensamblador-rpg--Copiar-/examen$ ./heroe
Nombre: Sauron
Sauron

```
Y si probamos el `echo $?` nos damos cuenta que efectivamente la salida es 0
```
simon@LAPTOP-RVE5FLUI:~/ensamblador-rpg--Copiar-/examen$ echo $?
0
```