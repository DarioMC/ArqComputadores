section .bss
   Buffer resb 1

section .data
	dispMsg db 'Entre'
	len equ $ - dispMsg
	
section .text
   global _start

_start:

xor r8, r8
mov r8, 0

read:   
   mov rax, 0			; sys_read (code 0)
   mov rdi, 0			; file descriptor (code 0 stdin)
   mov rsi, Buffer		; address to the buffer to read into
   mov rdx, 1			; number of bytes to read
   syscall

   cmp rax, 0			; check if the size of the reading is 0
   je write				; jump to the write tag if 0

   cmp byte [Buffer], 61h	; test the byte on Buffer against 'a'
   jb pushStack			; if less jump to the tag pushStack

   cmp byte [Buffer], 7Ah	; test the byte on Buffer against 'z'
   ja pushStack			; if greater jump to the tag pushStack

   sub byte [Buffer], 20h ; Convierte la letra en mayúscula

pushStack: ; Rutina encargada de meter los elementos a la pila

   xor r9, r9 ; Limpia el registro
   
   inc r8 ; Incrementa un contador que lleva la cantidad de PUSH a la pila
   
   mov r9, Buffer ; Mueve el caractér al registro r9
   push r9 ; Mete el caracter a la pila
   jmp read ; Jump a read para recibir otro caractér

write:

   mov rax, 1			; Mensaje de prueba
   mov rdi, 1			; para asegurar que la etiqueta
   mov rsi, dispMsg		; es utilizada
   mov rdx, len
   syscall
	
   cmp r8, 0 ; Si el contador es 0, no hay mas elementos a imprimir
   je exit	; JUMP a la salida
   
   pop r9 ; POP de la pila a r9
   
   mov rax, 1
   mov rdi, 1
   ;mov rsi, Buffer		; address to the buffer to print from
   mov rsi, r9 ; Imprime el caractér de r9, que contiene el último PUSH de la pila
   mov rdx, 1
   syscall

   dec r8 ; Decrementa el contador porque se hizo POP
	
   jmp write			; Vueleve a buscar el siguiente valor de la pila

exit:

   mov rax, 60			; sys_exit (code 60)
   mov rdi, 0			; exit code (code 0 = normal)
   syscall
