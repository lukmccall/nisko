section .text

extern _ZN6BigIntC1Ej

global _Z5zerujPjj
_Z5zerujPjj:
  cld
  mov ecx, esi
  mov eax, 0
  rep stosd
  ret


global _Z6kopiujPjS_j
_Z6kopiujPjS_j:
	cld
	mov ecx, edx
	rep movsd
	ret


global _ZN6BigInt5dodajEj
_ZN6BigInt5dodajEj:
	mov ecx, [rdi]  ; ecx = rozmiar
	mov r8, [rdi + 8] ; r8 = dane
                    ; esi = n
  ; r8[0] + n
	mov eax, [r8]
	add eax, esi 
	mov [r8], eax

	.loop:
		jnc .notOverflow ; jump if carry flag is 0 
		dec ecx
		jz .overflow
		add r8, 4
		add dword[r8], 1
	jmp .loop

	.overflow:
		mov eax, 1
    jmp .ret 
  .notOverflow:
    xor eax, eax

  .ret:
    ret

		
global _ZN6BigInt6pomnozEj
_ZN6BigInt6pomnozEj:
	mov ecx, [rdi]  ; ecx = rozmiar
	mov r8, [rdi + 8] ; r8 = dane
                    ; esi = n
 
  xor edx, edx
  
  .loop:
    cmp ecx, 0
    je  .check_for_overflow 
    
    dec ecx
    mov eax, [r8]
    mov r9d, edx ; copy carry
    mul esi
    add eax, r9d ; add carry from previous step
    mov [r8], eax
    add r8, 4
  jmp .loop

  .check_for_overflow:
    cmp edx, 0
    je .notOverflow

  .owerflow:
    mov rax, 1
    jmp .ret
  .notOverflow:
    xor rax, rax

  .ret:
    ret

global _ZN6BigInt14podzielZResztaEj
_ZN6BigInt14podzielZResztaEj:
	mov ecx, [rdi]  ; ecx = rozmiar
	mov r8, [rdi + 8] ; r8 = dane
                    ; esi = n

	xor edx, edx
  lea r8, [r8 + rcx * 4 - 4] ; r8 = &dane[rozmiar-1]
  
	.loop:
		mov eax, [r8] 
    div esi
    mov [r8], eax
    sub r8, 4
	loop .loop

	mov eax, edx
	ret


global _ZplRK6BigIntS1_
_ZplRK6BigIntS1_:
  enter 24,0
            ; rdi - return
            ; rsi - a
            ; rdx - b
  mov [rbp - 8], rdi ; return 
  mov [rbp - 16], rsi ; a
  mov [rbp - 24], rdx  ; b

  mov     rsi, [rsi] ; rsi = n
  call _ZN6BigIntC1Ej

  mov rcx, [rbp - 16]
  mov ecx, [rcx]      ; ecx = n
  
  mov r8, [rbp - 8]
  mov r8, [r8 + 8] ; r8 = *ret_dane

  mov r9, [rbp - 16]
  mov r9, [r9 + 8] ; r9 = *a_dane

  mov r10, [rbp - 24]
  mov r10, [r10 + 8] ; r10 = *b_dane

  clc
  .loop:
    mov eax, [r9]
    adc eax, [r10]
    mov [r8], eax

    add r8, 4   
    add r9, 4
    add r10, 4

  loop .loop

  mov rax, [rbp - 8]
  leave
	ret


global _ZmiRK6BigIntS1_
_ZmiRK6BigIntS1_:
enter 24,0
            ; rdi - return
            ; rsi - a
            ; rdx - b
  mov [rbp - 8], rdi ; return 
  mov [rbp - 16], rsi ; a
  mov [rbp - 24], rdx  ; b

  mov     rsi, [rsi] ; rsi = n
  call _ZN6BigIntC1Ej

  mov rcx, [rbp - 16]
  mov ecx, [rcx]      ; ecx = n
  
  mov r8, [rbp - 8]
  mov r8, [r8 + 8] ; r8 = *ret_dane

  mov r9, [rbp - 16]
  mov r9, [r9 + 8] ; r9 = *a_dane

  mov r10, [rbp - 24]
  mov r10, [r10 + 8] ; r10 = *b_dane

  clc
  .loop:
    mov eax, [r9]
    sbb eax, [r10]
    mov [r8], eax

    add r8, 4   
    add r9, 4
    add r10, 4

  loop .loop

  mov rax, [rbp - 8]
  leave
	ret