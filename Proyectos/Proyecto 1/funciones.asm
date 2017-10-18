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
	cmp ax, 0
	je setZeroResult
	jne printResult
	
	setZeroResult:
		mov word [result], "0"
		write result, 16
		jmp exitPrint
		
	printResult:
		mov [result], ax
		mov rax, [result]
		call itoa
		write rax, 16
	
	exitPrint:
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
	;call setFlags
	call printf
	;Exit----------------
	mov rax, SYS_EXIT
	mov rdi, EXIT
	syscall
	;--------------------
	ret

shiftRight:
	xor ax, ax
	xor cl, cl
	mov ax, [operand1]
	mov cl, [operand2]
	shr ax, cl
	call setFlags
	call print
	ret

shiftRightCarry:
	xor ax, ax
	xor cl, cl
	mov ax, [operand1]
	mov cl, [operand2]
	shr ax, cl
	call setFlags
	call print
	ret

shiftLeft:
	xor ax, ax
	xor cl, cl
	mov ax, [operand1]
	mov cl, [operand2]
	shl ax, cl
	clc
	call setFlags
	call print
	ret
		
shiftLeftCarry:
	xor ax, ax
	xor cl, cl
	mov ax, [operand1]
	mov cl, [operand2]
	shl ax, cl
	call setFlags
	call print
	ret

rotateRight:
	xor ax, ax
	xor cl, cl
	mov ax, [operand1]
	mov cl, [operand2]
	ror ax, cl
	call setFlags
	call print
	ret

rotateRightCarry:
	xor ax, ax
	xor cl, cl
	mov ax, [operand1]
	mov cl, [operand2]
	rcr ax, cl
	call setFlags
	call print
	ret

rotateLeft:
	xor ax, ax
	xor cl, cl
	mov ax, [operand1]
	mov cl, [operand2]
	rol ax, cl
	call setFlags
	call print
	ret
		
rotateLeftCarry:
	xor ax, ax
	xor cl, cl
	mov ax, [operand1]
	mov cl, [operand2]
	rcl ax, cl
	call setFlags
	call print
	ret

unsignedAddition:
	xor ax, ax
	xor bx, bx
	
	mov ax, [operand1]
	mov bx, [operand2]
	
	add ax, bx
	
	call setFlags
	call print
	
	ret

substraction:
	xor ax, ax
	xor bx, bx
	
	mov ax, [operand1]
	mov bx, [operand2]
	
	sub ax, bx
	
	call setFlags
	call print
	
	ret

aluAnd:
	xor ax, ax
	xor bx, bx
	
	mov ax, [operand1]
	mov bx, [operand2]
	
	and ax, bx
	
	call setFlags
	call print
	
	ret

aluXor:
	xor ax, ax
	xor bx, bx
	
	mov ax, [operand1]
	mov bx, [operand2]
	
	xor ax, bx
	
	call setFlags
	call print
	
	ret
	
aluOr:
	xor ax, ax
	xor bx, bx
	
	mov ax, [operand1]
	mov bx, [operand2]
	
	or ax, bx
	
	call setFlags
	call print
	
	ret
	
twoComplement:
	xor ax, ax
	
	mov ax, [operand1]
	
	neg ax
	
	call setFlags
	call print
	
	ret

oneComplement:
	xor ax, ax
	
	mov ax, [operand1]
	
	neg ax
	dec ax
	
	call setFlags
	call print
	
	ret

setFlags:
	
	jumpCarry:
		jc	setCarry
		jnc	unsetCarry
	
	jumpOverflow:
		jo	setOverflow
		jno	unsetOverflow
	
	jumpParity:
		jp	setParity
		jnp	unsetParity
	
	jumpSign:
		js	setSign
		jns	unsetSign
	
	jumpZero:
		jz	setZero
		jnz	unsetZero
	
	setCarry:
		mov word [carryFlag], "1"
		jmp jumpOverflow
	unsetCarry:
		mov word [carryFlag], "0"
		jmp jumpOverflow
	
	;setAuxCarry:
		;mov word [auxiliarycarryFlag], "1"
	;unsetsetAuxCarry:
		;mov word [auxiliarycarryFlag], "0"
	
	setOverflow:
		mov word [overflowFlag], "1"
		jmp jumpParity
	unsetOverflow:
		mov word [overflowFlag], "0"
		jmp jumpParity
	
	setParity:
		mov word [parityFlag], "1"
		jmp jumpSign
	unsetParity:
		mov word [parityFlag], "0"
		jmp jumpSign
	
	setSign:
		mov word [signFlag], "1"
		jmp jumpZero
	unsetSign:
		mov word [signFlag], "0"
		jmp jumpZero
	
	setZero:
		mov word [zeroFlag], "1"
		jmp end
	unsetZero:
		mov word [zeroFlag], "0"
		jmp end
		
	end:	
		ret
