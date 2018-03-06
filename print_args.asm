global _start

section .text
_start:

    pop rcx		    ; argc in ecx
	add rcx, '0'	; convert number to character - ASSume one digit :(
    push rcx		; need it in a buffer - use the stack
    mov rcx, rsp	; address of buffer in ecx, as sys_write wants!
    
    mov rdx, 1		; number of bytes to write
    mov rbx, 1		; file descriptor - STDOUT
    mov rax, 4		; __NR_write
    int 80h
    
exit:
    xor rbx, rbx	; claim "no error"
    mov rax, 1		; __NR_exit
    int 80h
