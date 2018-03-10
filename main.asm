global _start

section .text
_start:

	pop rdi
	pop rdi
	pop rdi ; Wczytaj nazwe pliku z parametru uruchomienia

	mov rax, 2
	xor rdx, rdx
	xor rsi, rsi
	syscall ; Otworz plik o podanej nazwie

	mov rcx, rsp; Zrob miejsce na bufor i maske bitowa permutacji zainizjalizuj rejestry
	mov r12, rsp
	sub rsp, 10 
	mov rsi, rsp	
	sub rsp, 4*8
	xor r13, r13 ; czy powinnismy juz skonczyc
	
retrieve_next_byte:
	cmp r12, rcx
	jne next_byte_retrieved
	cmp r13, 1
	je finish
	
	mov rax, 0 ; Wczytaj 10 bajtow 
	mov rdx, 10
	mov rdi, 3 ; zakladam ze ten file descriptor to bedzie 3
	syscall

	cmp rax, 10
	je not_last_batch
	mov r13, 1
not_last_batch:

	mov rcx, rsi
	mov r12, rsi
	add r12, rax 
	jmp retrieve_next_byte

next_byte_retrieved:
	mov al, [rcx]
	add rcx, 1
	jmp retrieve_next_byte

finish:
    xor rdi, rdi	; claim "no error"
    mov rax, 60 		; __NR_exit
	syscall
