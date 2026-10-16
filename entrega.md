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