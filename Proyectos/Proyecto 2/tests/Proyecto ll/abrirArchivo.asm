;*************************************************
; Código fuente: abrirArchivo.asm
; Descripción: Códido sobre como abrir un archivo y obtener su 
; contenido.
;
; Construir con los siguientes comandos:
; nasm -f elf64 -o abrirArchivo.o abrirArchivo.asm
; ld -o abrirArchivo abrirArchivo.o
;*************************************************

section .data
	jump db 10	; Salto de línea.
	jumpLen equ $ - jump

section .bss

; Necesitamos un Buffer donde guardar lo leído.
	Buffer equ bufLen
	bufLen resb 2048 	; El estándar de los bytes que reservamos.

section .text

	GLOBAL _start

; Le indica al compilador por donde iniciar.
_start:
	; Puesto que lo estamos pasando por parámetro, 
	; necesitamos recuperarlo.

	mov r15, [rsp + 16]	; Obtenemos la dirección del archivo.

	; Utilizamos el servicio que nos permite abrir el archivo.
	mov rax, 2		; Código del servicio.
	mov rdi, r15	; Indicamos el archivo.
	mov rsi, 42h	; Le indicamos que lo queremos de lectura y escritura.
	mov rdx, 1B6h	; Le indicamos que queremos privilegios sobre él.
	syscall 

	; Ahora que tenemos el identificador del archivo
	; podemos utilizarlo, pero antes vamos a guardarlo
	; en otro registro.
	mov r14, rax

	; Utilizamos el servicio de lectura para poder obtener su 
	; contenido.
	mov rax, 0		; Código del servicio.
	mov rdi, r14	; Pasamos el identificador.
	mov rsi, Buffer ; Donde vamos a guardar el contenido.
	mov rdx, bufLen ; El tamaño de nuestro espacio.
	syscall 

	; Procedemos a cerrar el archivo para evitar un
	; error.
	mov rax, 3		; Código del servicio.
	mov rdi, r14	; El identificador del servicio.
	syscall

	; Observemos el contenido del Buffer.
	mov rax, 1		; Código del servicio.
	mov rdi, 1		; La salida estándar.
	mov rsi, Buffer ; El contenido que queremos imprimir.
	mov rdx, bufLen ; El tamaño del contenido.
	syscall

	; Impresión de un salto de línea.
	mov rax, 1
	mov rdi, 1
	mov rsi, jump
	mov rdx, jumpLen
	syscall 

	; Por último, salimos del programa.
	mov rax, 60		; Código del servicio.
	mov rdi, 0		; La entrada estándar.
	syscall 
