%include "macros.asm" 
%include "funciones.asm"

section .data

	mensajeOP1: db "Operand 1: " , 0xF
	longitudOP1: equ $ - mensajeOP1
	
	mensajeOP2: db "Operand 2: " , 0xF
	longitudOP2: equ $ - mensajeOP2
	
	mensajeOP: db "Operator: " , 0xF
	longitudOP: equ $ - mensajeOP
	
	mensajeCF: db "Carry flag: " , 0xF
	longitudCF: equ $ - mensajeCF
	
	mensajeACF: db "Auxilary carry flag: " , 0xF
	longitudACF: equ $ - mensajeACF
	
	mensajeOF: db "Overflow flag: " , 0xF
	longitudOF: equ $ - mensajeOF
	
	mensajeSF: db "Signed flag: " , 0xF
	longitudSF: equ $ - mensajeSF
	
	mensajePF: db "Parity flag: " , 0xF
	longitudPF: equ $ - mensajePF
	
	mensajeZF: db "Zero flag: " , 0xF
	longitudZF: equ $ - mensajeZF
	
section .bss
	;Variables de operaciones
	operand1	resb 16
	operand2	resb 16
	operator	resb 16
	result		resb 16
	itoaResult	resb 16
	
	carryFlag			resb 16
	auxiliarycarryFlag	resb 16
	overflowFlag		resb 16
	signFlag			resb 16
	parityFlag			resb 16
	zeroFlag			resb 16
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
	SIGNED_ADDITION		equ 1b
	UNSIGNED_ADITION	equ 10b
	SUBSTRACTION		equ 11b
	AND_OPERATION		equ 100b ;Problemas
	OR_OPERATION		equ 101b ;Problemas
	XOR_OPERATION		equ 110b ;Problemas
	ONE_COMPLEMENT		equ 111b
	TWO_COMPLEMENT		equ 1000b
	SHIFT_RIGHT			equ 1001b
	SHIFT_LEFT			equ 1010b
	SHIFT_RIGHT_CARRY	equ 1011b
	SHIFT_LEFT_CARRY	equ 1100b
	ROTATE_LEFT			equ 1101b
	ROTATE_RIGHT		equ 1110b
	ROTATE_LEFT_CARRY	equ 1111b
	ROTATE_RIGHT_CARRY	equ 10000b
	;------------------------
	
section .text

global _start:

_start:
	
	write mensajeOP1, longitudOP1
	read operand1, 16
	
	write mensajeOP2, longitudOP2
	read operand2, 16
	
	write mensajeOP, longitudOP
	read operator, 16
	
	write mensajeCF, longitudCF
	read carryFlag, 16
	
	write mensajeACF, longitudACF
	read auxiliarycarryFlag, 16
	
	write mensajeOF, longitudOF
	read overflowFlag, 16
	
	write mensajePF, longitudPF
	read parityFlag, 16
	
	write mensajeSF, longitudSF
	read signFlag, 16
	
	write mensajeZF, longitudZF
	read zeroFlag, 16
	
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
	
	cmp byte [operator], UNSIGNED_ADITION
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
