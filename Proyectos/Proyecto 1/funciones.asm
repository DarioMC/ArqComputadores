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

;Imprime los resultados  
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
;--------------------

;Imprime las banderas
printf:	
	write mensajeCF, longitudCF
	write carryFlag, 16
	
	write mensajeOF, longitudOF
	write overflowFlag, 16
	
	write mensajePF, longitudPF
	write parityFlag, 16
	
	write mensajeSF, longitudSF
	write signFlag, 16
	
	write mensajeZF, longitudZF
	write zeroFlag, 16
	ret
;--------------------

;Método que llama a sys_exit
exit:
	call printf
	macroExit
	ret
;--------------------

;Shift right
;Opera sobre ax y cl
;Limpia el CF después de operar
shiftRight:
	xor ax, ax
	xor cl, cl
	mov ax, [operand1]
	mov cl, [operand2]
	shr ax, cl
	clc
	call setFlags
	call print
	ret
;--------------------

;Shift right con carry
;Opera sobre ax y cl
shiftRightCarry:
	xor ax, ax
	xor cl, cl
	mov ax, [operand1]
	mov cl, [operand2]
	shr ax, cl
	call setFlags
	call print
	ret
;--------------------

;Shift left
;Opera sobre ax y cl
;Limpia el CF después de operar
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
;--------------------

;Shift left con carry
;Opera sobre ax y cl
shiftLeftCarry:
	xor ax, ax
	xor cl, cl
	mov ax, [operand1]
	mov cl, [operand2]
	shl ax, cl
	call setFlags
	call print
	ret
;--------------------

;Rotate right
;Opera sobre ax y cl
rotateRight:
	xor ax, ax
	xor cl, cl
	mov ax, [operand1]
	mov cl, [operand2]
	ror ax, cl
	call setFlags
	call print
	ret
;--------------------

;Rotate right con carry
;Opera sobre ax y cl
rotateRightCarry:
	xor ax, ax
	xor cl, cl
	mov ax, [operand1]
	mov cl, [operand2]
	rcr ax, cl
	call setFlags
	call print
	ret
;--------------------

;Rotate left con carry
;Opera sobre ax y cl
rotateLeft:
	xor ax, ax
	xor cl, cl
	mov ax, [operand1]
	mov cl, [operand2]
	rol ax, cl
	call setFlags
	call print
	ret
;--------------------

;Rotate left con carry
;Opera sobre ax y cl		
rotateLeftCarry:
	xor ax, ax
	xor cl, cl
	mov ax, [operand1]
	mov cl, [operand2]
	rcl ax, cl
	call setFlags
	call print
	ret
;--------------------

;Suma sin signo
;Opera sobre ax y bx
unsignedAddition:
	xor ax, ax
	xor bx, bx
	
	mov ax, [operand1]
	mov bx, [operand2]
	
	add ax, bx
	
	call setFlags
	call print
	
	ret
;--------------------

;Resta
;Opera sobre ax y bx
substraction:
	xor ax, ax
	xor bx, bx
	
	mov ax, [operand1]
	mov bx, [operand2]
	
	sub ax, bx
	
	call setFlags
	call print
	
	ret
;--------------------

;AND
;Opera sobre ax y bx
aluAnd:
	xor ax, ax
	xor bx, bx
	
	mov ax, [operand1]
	mov bx, [operand2]
	
	and ax, bx
	
	call setFlags
	call print
	
	ret
;--------------------

;XOR
;Opera sobre ax y bx
aluXor:
	xor ax, ax
	xor bx, bx
	
	mov ax, [operand1]
	mov bx, [operand2]
	
	xor ax, bx
	
	call setFlags
	call print
	
	ret
;--------------------

;OR
;Opera sobre ax y bx
aluOr:
	xor ax, ax
	xor bx, bx
	
	mov ax, [operand1]
	mov bx, [operand2]
	
	or ax, bx
	
	call setFlags
	call print
	
	ret
;--------------------
	
;Complemento a 2
;Opera sobre ax
twoComplement:
	xor ax, ax
	
	mov ax, [operand1]
	
	neg ax
	
	call setFlags
	call print
	
	ret
;--------------------

;Complemento a 1
;Opera sobre ax
oneComplement:
	xor ax, ax
	
	mov ax, [operand1]
	
	neg ax
	dec ax
	
	call setFlags
	call print
	
	ret
;--------------------

;Método que setea las banderas a imprimir
;Dependiendo de la bandera, hace JUMP a la etiqueta que la cambia
;por 1 o 0 y vuelve a la siguiente etiqueta hasta que se setearon todas 
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
;--------------------
