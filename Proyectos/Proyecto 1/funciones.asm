; atoi turns a string into a number
; expects decimal
; stops when a char is not an ascii digit
; input: string addr in rax
; output: number in rax
atoi:
  ;preserve registers
  push rcx
  push rbx

  mov rcx, 0 ;rcx will be our result

_atoiloop:
  ;are we at the end?
  cmp [rax], byte 48
  jl _atoiend

  cmp [rax], byte 57
  jg _atoiend

  ;multiply result by 10
  push rax
  mov rax, rcx
  mov rbx, 10
  mul rbx
  mov rcx, rax
  pop rax

  ;subtract 48 from char, add to rcx
  mov bl, byte [rax]
  sub bl, 48
  add rcx, rbx
  inc rax

  ;loop
  jmp _atoiloop
  
_atoiend:
  mov rax, rcx
  ;restore before returning
  pop rbx
  pop rcx
  ret

; itoa turns a number into a 0t string
; input: number in rax
; output: string addr in rax
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
	mov     rdx, 16
	mov     rsi, rax
	mov     rdi, STDOUT
	mov     rax, SYS_WRITE
	syscall
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
		mov [result], ax
		mov rax, [result]
		call itoa
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
		mov [result], ax
		mov rax, [result]
		call itoa
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
		
		rol ax, 1
		dec r8
		jmp loopROR
	
	endROR:
		mov [result], ax
		mov rax, [result]
		call itoa
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
		mov [result], ax
		mov rax, [result]
		call itoa
		call print
		ret

unsignedAddition:
	xor ax, ax
	xor bx, bx
	
	mov ax, [operand1]
	mov bx, [operand2]
	
	add ax, bx
	
	mov [result], ax
	mov rax, [result]
	call itoa
	call print
	
	ret

substraction:
	xor ax, ax
	xor bx, bx
	
	mov ax, [operand1]
	mov bx, [operand2]
	
	sub ax, bx
	
	mov [result], ax
	mov rax, [result]
	call itoa
	call print
	
	ret

aluAnd:
	xor ax, ax
	xor bx, bx
	
	mov ax, [operand1]
	mov bx, [operand2]
	
	and ax, bx
	
	mov [result], ax
	mov rax, [result]
	call itoa
	call print
	
	ret

aluXor:
	xor ax, ax
	xor bx, bx
	
	mov ax, [operand1]
	mov bx, [operand2]
	
	xor ax, bx
	
	mov [result], ax
	mov rax, [result]
	call itoa
	call print
	
	ret
	
aluOr:
	xor ax, ax
	xor bx, bx
	
	mov ax, [operand1]
	mov bx, [operand2]
	
	or ax, bx
	
	mov [result], ax
	mov rax, [result]
	call itoa
	call print
	
	ret
	
twoComplement:
	xor ax, ax
	
	mov ax, [operand1]
	
	neg ax
	
	mov [result], ax
	mov rax, [result]
	call itoa
	call print
	
	ret

oneComplement:
	xor ax, ax
	
	mov ax, [operand1]
	
	neg ax
	dec ax
	
	mov [result], ax
	mov rax, [result]
	call itoa
	call print
	
	ret
