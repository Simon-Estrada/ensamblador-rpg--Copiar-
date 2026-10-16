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
