%macro write 2
	xor rsi, rsi
	mov     rsi, %1
	mov     rdx, %2
	mov     rdi, 1
	mov     rax, 1
	syscall
%endmacro

%macro read 2
	mov     rsi, %1
	mov     rdx, %2
	mov     rdi, 0
	mov     rax, 0
	syscall
%endmacro
