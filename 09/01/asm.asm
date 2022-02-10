segment .bss
  temp resd 1 

segment .text

global diff
diff:
; rdi   out
; rsi   wiersz
; rdx   n

  mov rax, rdx ; rax = n  
  mov r9, rdx ; r9 = n


  and rax, -8 ; rax = n // 8
  mov rcx, 0 ; rcx - counter

  cmp rax, 0
  je .skalarnie

.wektorowo:

  movups xmm0, [rsi + rcx + 1]
  movups xmm1, [rsi + rcx] 
  psubsb xmm0, xmm1
  movups [rdi + rcx], xmm0
  
  add rcx, 8
  cmp rcx, rax
  jl .wektorowo
  
.skalarnie:   
   
  cmp rcx, r9
  jae .koniec
  
  mov al, [rsi + rcx + 1]
  mov [rel temp], al
  movss xmm0, [rel temp]
  
  mov al, [rsi + rcx]
  mov [rel temp], al
  movss xmm1, [rel temp]

  psubsb xmm0, xmm1

  movss [rel temp], xmm0
  mov al, [rel temp]
  mov [rdi + rcx], al
    
  inc rcx
  jmp .skalarnie
      
.koniec:
  mov rax, 0
  ret

