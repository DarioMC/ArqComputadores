%include "funciones.asm"

section .data

	mensaje: db "Entre" , 0xF
	longitud: equ $ - mensaje
	
section .bss
	;Variables de operaciones
	operand1	resb 16
	operand2	resb 16
	operator	resb 16
	result		resb 16
	itoaResult	resb 16
	;------------------------
	
	;Llamadas al kernel
	SYS_WRITE	equ 1
	SYS_READ	equ 0
	SYS_EXIT	equ 60
	;------------------------
	
	;Descriptor de las interrupciones
	STDIN		equ 0
	STDOUT		equ 1
	EXIT		equ 0
	;------------------------
	
	;Operaciones del ALU
	SIGNED_ADDITION		equ 1
	UNSIGNED_ADITION	equ 2
	SUBSTRACTION		equ 3
	AND_OPERATION		equ 4
	OR_OPERATION		equ 5
	XOR_OPERATION		equ 6
	ONE_COMPLEMENT		equ 7
	TWO_COMPLEMENT		equ 8
	SHIFT_RIGHT			equ 9
	SHIFT_LEFT			equ 10
	SHIFT_RIGHT_CARRY	equ 11
	SHIFT_LEFT_CARRY	equ 12
	ROTATE_LEFT			equ 13
	ROTATE_RIGHT		equ 14
	ROTATE_LEFT_CARRY	equ 15
	ROTATE_RIGHT_CARRY	equ 16
	;------------------------
	
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
	
	mov     rdx, 16
	mov     rsi, operator
	mov     rdi, STDIN
	mov     rax, SYS_READ
	syscall
	
	;Lee el primer operando y lo convierte en entero
	mov     rax, operand1
	call 	atoi
	mov		[operand1], rax
	;--------------------
	
	;Lee el segundo operando y lo convierte en entero
	mov     rax, operand2
	call 	atoi
	mov		[operand2], rax
	;--------------------
	
	;Lee el segundo operando y lo convierte en entero
	mov     rax, operator
	call 	atoi
	mov		[operator], rax
	;--------------------
	
	cmp byte [operator], UNSIGNED_ADITION
	je 	performUnsigedAddition
	jne exit
	
	performUnsigedAddition:
		call unsignedAddition
		jmp exit
	
	exit:
		;Exit----------------
		mov rax, SYS_EXIT
		mov rdi, EXIT
		syscall
		;--------------------
