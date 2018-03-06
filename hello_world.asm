global _start
section .rodata

hello: db "Hello World ", 10

section .text

_start:
    mov eax, 1
    mov edi, 1
    mov rsi, [rbp]
    mov edx, 13
    syscall
    mov eax, 60
    xor edi, edi
    syscall
