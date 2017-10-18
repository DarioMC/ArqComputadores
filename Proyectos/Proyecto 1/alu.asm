%include "macros.asm" 
%include "funciones.asm"

section .data
	
	;Mensajes de recibimiento de parámetros
	mensajeOP1: db "Operand 1: " , 0xF
	longitudOP1: equ $ - mensajeOP1
	
	mensajeOP2: db "Operand 2: " , 0xF
	longitudOP2: equ $ - mensajeOP2
	
	mensajeOP: db "Operator: " , 0xF
	longitudOP: equ $ - mensajeOP
	
	mensajeCF: db 10, "Carry flag: " , 0xF
	longitudCF: equ $ - mensajeCF
	
	mensajeACF: db 10, "Adjust flag: " , 0xF
	longitudACF: equ $ - mensajeACF
	
	mensajeOF: db 10, "Overflow flag: " , 0xF
	longitudOF: equ $ - mensajeOF
	
	mensajeSF: db 10, "Signed flag: " , 0xF
	longitudSF: equ $ - mensajeSF
	
	mensajePF: db 10, "Parity flag: " , 0xF
	longitudPF: equ $ - mensajePF
	
	mensajeZF: db 10, "Zero flag: " , 0xF
	longitudZF: equ $ - mensajeZF
	
	mensajeResult: db 10, "Result: " , 0xF
	longitudResult: equ $ - mensajeResult
	;--------------------
	
section .bss
	;Variables de entrada
	operand1_in	resb 17
	operand2_in	resb 17
	;--------------------
	
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
	UNSIGNED_ADITION	equ 10b		;Listo
	SUBSTRACTION		equ 11b		;Listo
	AND_OPERATION		equ 100b	;Listo
	OR_OPERATION		equ 101b	;Listo
	XOR_OPERATION		equ 110b	;Listo
	ONE_COMPLEMENT		equ 111b	;Listo
	TWO_COMPLEMENT		equ 1000b	;Listo
	SHIFT_RIGHT			equ 1001b	;Listo
	SHIFT_LEFT			equ 1010b
	SHIFT_RIGHT_CARRY	equ 1011b	;Listo
	SHIFT_LEFT_CARRY	equ 1100b	
	ROTATE_LEFT			equ 1101b	
	ROTATE_RIGHT		equ 1110b
	ROTATE_LEFT_CARRY	equ 1111b	;Listo
	ROTATE_RIGHT_CARRY	equ 10000b	;Listo
	;------------------------
	
section .text

global _start:

_start:
	
	;Recibe el operando 1
	write mensajeOP1, longitudOP1
	read operand1_in, 17
	;--------------------
	
	;Recibe el operando 2
	write mensajeOP2, longitudOP2
	read operand2_in, 17
	;--------------------
	
	;Recibe el operador
	write mensajeOP, longitudOP
	read operator, 16
	;--------------------
	
	;Recibe CF
	write mensajeCF, longitudCF
	read carryFlag, 16
	;--------------------
	
	;Recibe ACF
	write mensajeACF, longitudACF
	read auxiliarycarryFlag, 16
	;--------------------
	
	;Recibe OF
	write mensajeOF, longitudOF
	read overflowFlag, 16
	;--------------------
	
	;Recibe PF
	write mensajePF, longitudPF
	read parityFlag, 16
	;--------------------
	
	;Recibe SF
	write mensajeSF, longitudSF
	read signFlag, 16
	;--------------------
	
	;Recibe ZF
	write mensajeZF, longitudZF
	read zeroFlag, 16
	;--------------------
	
	;Lee el primer operando y lo convierte en entero
	mov     rax, operand1_in
	call 	atoi
	mov		[operand1], rax
	;--------------------
	
	;Lee el segundo operando y lo convierte en entero
	mov     rax, operand2_in
	call 	atoi
	mov		[operand2], rax
	;--------------------
	
	;Lee el segundo operando y lo convierte en entero
	mov     rax, operator
	call 	atoi
	mov		[operator], rax
	;--------------------
	
	;Compara el operador con los tipos
	;de operación y JUMP a su ejecución
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
	;--------------------
	
	;Si no entra un operando válido, llama a sys_exit
	macroExit
	;--------------------
	
	;Dependiendo del operando, llama al método que ejecuta la operación
	;Una vez ejecutado, llama a sys_exit
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
		call shiftRightCarry
		call exit
		
	performShiftLeftCarry:
		call shiftLeftCarry
		call exit
		
	performRotateRight:
		call rotateRight
		call exit
		
	performRotateLeft:
		call rotateLeft
		call exit
	
	performRotateRightCarry:
		call rotateRightCarry
		call exit
		
	performRotateLeftCarry:
		call rotateLeftCarry
		call exit
	;--------------------
