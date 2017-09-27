section .bss
   Buffer resb 1024
   Aux resb 1

section .data
	BufferLen dd 1024
	
section .text
   global _start

_start:

   mov rax, 0			; SYS_READ
   mov rdi, 0			; STDIN
   mov rsi, Buffer		; Direcciona al Buffer
   mov rdx, BufferLen	; Número de BYTES a leer
   syscall

xor r8, r8
xor r9, r9

mov r8, Buffer ; R8 es el registro que recorre el Buffer
mov r9, 0	   ; Contador de los elementos en la pila
  
loop: ; Ciclo que recorre el Buffer
   
   cmp byte [r8], 0		; Comprueba si está al final del Buffer
   je print				; Si está al final, JUMP a la etiqueta que imprime
   
   cmp byte [r8], 61h	; Compara el BYTE contra 'a'
   jb pushStack			; Si es menor, se inserta directamente en la pila

   cmp byte [r8], 7Ah	; Compara el BYTE contra 'z'
   ja pushStack			; Si es mayor, se inserta directamente en la pila

   sub byte [r8], 20h 	; Convierte la letra en mayúscula

pushStack: ; Etiqueta que inserta a la pila
   
   push r8	; Inserto el BYTE en la pila
   
   inc r8	; Paso al siguiente BYTE del Buffer
   
   inc r9	; Aumento el contador de elementos en la pila
   
   jmp loop ; Busca el siguiente BYTE del Buffer
   
print:
	
   cmp r9, 0	; Comprueba si el contador de la pila es 0
   je exit		; De ser así, se acaba el programa
	
   pop r8		; Saca el BYTE de la pila
   mov rsi, r8	; Mueve el BYTE al registro para mostrar en pantalla
	
   dec r9		; Reduce el contador de la pila en 1
	
   mov rax, 1	; SYS_WRITE
   mov rdi, 1	; STDOUT
   mov rdx, 1	; BYTES a imprimir
   syscall
   
   jmp print	; Busca el siguiente valor de la pila

exit:

   mov rax, 60			; SYS_EXIT
   mov rdi, 0			; EXIT
   syscall
