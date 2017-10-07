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
	
	cmp byte [operator], SIGNED_ADDITION
	je 	performSignedAddition
	
	cmp byte [operator], UNSIGNED_ADDITION
	je 	performUnsigedAddition
	
	cmp byte [operator], SUBSTRACTION
	je 	performSubstraction
	
	cmp byte [operator], AND_OPERATION
	je 	performAnd
	
	cmp byte [operator], OR_OPERATION
	je 	performOr
	
	cmp byte [operator], XOR_OPERATION
	je 	performXor
	
	cmp byte [operator], ONE_COMPLEMENT
	je 	performOneComplement
	
	cmp byte [operator], TWO_COMPLEMENT
	je 	performTwoComplement
	
	cmp byte [operator], SHIFT_RIGHT
	je 	performShiftRight
	
	cmp byte [operator], SHIFT_LEFT
	je 	performShiftLeft
	
	cmp byte [operator], SHIFT_RIGHT_CARRY
	je 	performShiftRightCarry
	
	cmp byte [operator], SHIFT_LEFT_CARRY
	je 	performShiftLeftCarry
	
	cmp byte [operator], ROTATE_RIGHT
	je 	performRotateRight
	
	cmp byte [operator], ROTATE_LEFT
	je 	performRotateLeft
	
	cmp byte [operator], ROTATE_RIGHT_CARRY
	je 	performRotateRightCarry
	
	cmp byte [operator], ROTATE_LEFT_CARRY
	je 	performRotateLeftCarry
	
	call exit
	
	performSignedAddition:
		call exit
	
	performUnsigedAddition:
		call unsignedAddition
		call exit
		
	performSubstraction:
		call substraction
		call exit
	
	performAnd:
		call aluAnd
		call exit
	
	performOr:
		call aluOr
		call exit
		
	performXor:
		call aluXor
		call exit

	performOneComplement:
		call oneComplement
		call exit
	
	performTwoComplement:
		call twoComplement
		call exit
		
	performShiftRight:
		call shiftRight
		call exit
		
	performShiftLeft:
		call shiftLeft
		call exit
	
	performShiftRightCarry:
		call exit
		
	performShiftLeftCarry:
		call exit
		
	performRotateRight:
		call rotateRight
		call exit
		
	performRotateLeft:
		call rotateLeft
		call exit
	
	performRotateRightCarry:
		call exit
		
	performRotateLeftCarry:
		call exit
