;Macro de SYS_WRITE
%macro write 2
	xor rsi, rsi
	mov     rsi, %1
	mov     rdx, %2
	mov     rdi, 1
	mov     rax, 1
	syscall
%endmacro
;--------------------

;Macro de SYS_READ
%macro read 2
	mov     rsi, %1
	mov     rdx, %2
	mov     rdi, 0
	mov     rax, 0
	syscall
%endmacro
;--------------------

;Macro de SYS_EXIT
%macro macroExit 0
	mov     rdi, 0
	mov     rax, 60
	syscall
%endmacro
;--------------------
