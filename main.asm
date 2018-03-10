global _start

section .text
_start:

	pop rdi
	cmp rdi, 2
	jne error
	pop rdi
	pop rdi ; Wczytaj nazwe pliku z parametru uruchomienia

	mov rax, 2
	xor rdx, rdx
	xor rsi, rsi
	syscall ; Otworz plik o podanej nazwie
	cmp rax, 3
	jne error

	mov rbx, rsp; Zrob miejsce na bufor i maske bitowa permutacji zainizjalizuj rejestry
	mov r11, rsp
	sub rsp, 10 
	mov rsi, rsp	
	sub rsp, 4*8
	xor r10, r10 ; czy powinnismy juz skonczyc
	xor r8, r8; 0 - pierwszy segment, 1 - kolejny segment
	
retrieve_next_byte:
	cmp r11, rbx
	jne next_byte_retrieved
	cmp r10, 1
	je finish
	
	mov rax, 0 ; Wczytaj 10 bajtow 
	mov rdx, 10
	mov rdi, 3 ; zakladam ze ten file descriptor to bedzie 3
	syscall

	cmp rax, 10
	je not_last_batch
	mov r10, 1
not_last_batch:

	mov rbx, rsi
	mov r11, rsi
	add r11, rax 
	jmp retrieve_next_byte

next_byte_retrieved:
	mov cl, [rbx]
	add rbx, 1
	
	cmp cl, 0
	jne not_zero
	cmp r8, 0
	jne not_first_segment

	mov [rsp], r12	
	mov [rsp + 8], r13	
	mov [rsp + 0x10], r14	
	mov [rsp + 0x18], r15	
	mov r8, 1

not_first_segment:
	
	cmp [rsp], r12	
	jne error
	cmp [rsp+8], r13	
	jne error
	cmp [rsp+0x10], r14	
	jne error
	cmp [rsp+0x18], r15	
	jne error

	xor r12, r12
	xor r13, r13
	xor r14, r14
	xor r15, r15
		
	jmp retrieve_next_byte	

not_zero:	
	cmp cl, 0x40	
	jnb two 
	mov rax, r12
	call do_something
	mov r12, rax
	jmp retrieve_next_byte
two:
	sub cl, 0x40
	cmp cl, 0x40	
	jnb tree 
	mov rax, r13
	jmp do_something
	mov r13, rax
	jmp retrieve_next_byte
tree:
	sub cl, 0x40
	cmp cl, 0x40	
	jnb four 
	mov rax, r14
	jmp do_something
	mov r14, rax
	jmp retrieve_next_byte
four:
	sub cl, 0x40
	mov rax, r15
	jmp do_something
	mov r15, rax
	jmp retrieve_next_byte

error:
	mov rdi, 1
	mov rax, 60
	syscall
finish:
	cmp cl, 0
	jne error
    xor rdi, rdi	; claim "no error"
    mov rax, 60 		; __NR_exit
	syscall

do_something:; sprawdza czy rax ma zapalony bit o numerze cl, (jesli tak to wywala sie, jesli nie to kontynuuje)
	mov rdx, 1
	shl rdx, cl
	and rdx, rax
	cmp rdx, 0
	jne error
	mov rdx, 1
	shl rdx, cl
	or rax, rdx
	ret	
