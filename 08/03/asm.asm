section .text

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
