; ATOI: ASCII TO INT
; entrada: String en rax
; salida: Número rax
atoi:
  ;Preserva los registros
  push rcx
  push rbx

  mov rcx, 0 ;rcx va a ser el resultado

_atoiloop:
  ;compara si está al final del String
  cmp [rax], byte 48
  jl _atoiend

  cmp [rax], byte 57
  jg _atoiend

  ;Multiplica por 10
  push rax
  mov rax, rcx
  mov rbx, 2
  mul rbx
  mov rcx, rax
  pop rax

  ;Resta 48 del caracter y lo suma a rcx
  mov bl, byte [rax]
  sub bl, 48
  add rcx, rbx
  inc rax

  ;loop
  jmp _atoiloop
  
_atoiend:
  mov rax, rcx
  ;Restaura los registros antes de retornar
  pop rbx
  pop rcx
  ret

; ITOA: INT TO ASCII
; entrada: número en rax
; salida: String en rax
itoa:
  push rdx
  push rcx
  push rbx

  push rax
  mov rbx, 2
  mov rcx, itoaResult

_itoacount:
  cmp rax, 0
  je _itoawrite

  cqo
  div rbx
  inc rcx
  jmp _itoacount

_itoawrite:
  mov [rcx], byte 0
  pop rax
_itoawriteloop:
  dec rcx
  cqo
  div rbx
  add rdx, 48
  mov [rcx], dl

  cmp rcx, itoaResult
  jne _itoawriteloop

  mov rax, itoaResult

  pop rbx
  pop rcx
  pop rdx
  ret
  
print:
	mov [result], ax
	mov rax, [result]
	call itoa
	write rax, 16
	ret
	
printf:	
	write mensajeCF, longitudCF
	write carryFlag, 16
	
	write mensajeACF, longitudACF
	write auxiliarycarryFlag, 16
	
	write mensajeOF, longitudOF
	write overflowFlag, 16
	
	write mensajePF, longitudPF
	write parityFlag, 16
	
	write mensajeSF, longitudSF
	write signFlag, 16
	
	write mensajeZF, longitudZF
	write zeroFlag, 16
	ret
	
exit:
	call printf
	;Exit----------------
	mov rax, SYS_EXIT
	mov rdi, EXIT
	syscall
	;--------------------
	ret

shiftRight:
	xor ax, ax
	xor r8, r8
	mov ax, [operand1]
	mov r8, [operand2]
	
	loopSHR:
		cmp r8, 0
		je endSHR
		
		shr ax, 1
		dec r8
		jmp loopSHR
	
	endSHR:
		call print
		ret

shiftLeft:
	xor ax, ax
	xor r8, r8
	mov ax, [operand1]
	mov r8, [operand2]
	
	loopSHL:
		cmp r8, 0
		je endSHL
		
		shl ax, 1
		dec r8
		jmp loopSHL
	
	endSHL:
		call print
		ret

rotateRight:
	xor ax, ax
	xor r8, r8
	mov ax, [operand1]
	mov r8, [operand2]
	
	loopROR:
		cmp r8, 0
		je endROR
		
		ror ax, 1
		dec r8
		jmp loopROR
	
	endROR:
		call print
		ret


rotateLeft:
	xor ax, ax
	xor r8, r8
	mov ax, [operand1]
	mov r8, [operand2]
	
	loopROL:
		cmp r8, 0
		je endROL
		
		rol ax, 1
		dec r8
		jmp loopROL
	
	endROL:
		call print
		ret

unsignedAddition:
	xor ax, ax
	xor bx, bx
	
	mov ax, [operand1]
	mov bx, [operand2]
	
	add ax, bx
	
	call print
	
	ret

substraction:
	xor ax, ax
	xor bx, bx
	
	mov ax, [operand1]
	mov bx, [operand2]
	
	sub ax, bx
	
	call print
	
	ret

aluAnd:
	xor ax, ax
	xor bx, bx
	
	mov ax, [operand1]
	mov bx, [operand2]
	
	and ax, bx
	
	call print
	
	ret

aluXor:
	xor ax, ax
	xor bx, bx
	
	mov ax, [operand1]
	mov bx, [operand2]
	
	xor ax, bx
	
	call print
	
	ret
	
aluOr:
	xor ax, ax
	xor bx, bx
	
	mov ax, [operand1]
	mov bx, [operand2]
	
	or ax, bx
	
	call print
	
	ret
	
twoComplement:
	xor ax, ax
	
	mov ax, [operand1]
	
	neg ax
	
	call print
	
	ret

oneComplement:
	xor ax, ax
	
	mov ax, [operand1]
	
	neg ax
	dec ax
	
	call print
	
	ret

