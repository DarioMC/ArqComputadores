%include "funciones.asm"

section .data

	mensaje: db "Entre" , 0xF
	longitud: equ $ - mensaje
	
section .bss
	operand1 resb 16
	operand2 resb 16
	result resb 16
	itoaResult resb 16	
	
	SYS_WRITE equ 1
	SYS_READ equ 0
	SYS_EXIT equ 60
	
	STDIN equ 0
	STDOUT equ 1
	EXIT equ 0
	
section .text

global _start:

_start:

	mov     rdx, 16
	mov     rsi, operand1
	mov     rdi, STDIN
	mov     rax, SYS_READ
	syscall
	
	mov     rdx, 16
	mov     rsi, operand2
	mov     rdi, STDIN
	mov     rax, SYS_READ
	syscall
	
	;Lee el primer operando y lo convierte en entero
	mov     rax, operand1
	call atoi
	mov		[operand1], rax
	;--------------------
	
	;Lee el segundo operando y lo convierte en entero
	mov     rax, operand2
	call atoi
	mov		[operand2], rax
	;--------------------
	
	call oneComplement
	
	;Exit----------------
	mov rax, SYS_EXIT
	mov rdi, EXIT
	syscall
	;--------------------
