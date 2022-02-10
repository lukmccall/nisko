section .data
  quarter dd 0.25

section .text

global scaleSSE

scaleSSE:
; rdi   grad
; rsi   data
; rdx   n

  xor rax, rax
  mov rax, rdx

  and rax, -8
  xor rcx, rcx 
  
  mov r9, rcx

  movss xmm4, [rel quarter]
  shufps xmm4, xmm4, 0h


  cmp rax, 0
  je .rest

  .vector:
    ; | a1 | a2 | a3 | a4 | b1 | b2 | b3 | b4 |
    ; | c1 | c2 | c3 | c4 | d1 | d2 | d3 | d4 |
    
    movups xmm0, [rsi + rcx * 4] ; data[rcx] ; a1 a2 a3 a4
    movups xmm1, [rsi + rcx * 4 + 16] ; data[rcx + 4] ; b1 b2 b3 b4

    mov r8, rdx
    add r8, rcx
    
    movups xmm2, [rsi + r8 * 4] ; data[rcx + n] ; c1 c2 c3 c4
    movups xmm3, [rsi + r8 * 4 + 16] ; data[rcx + n+ 4] ; d1 d2 d3 d4

    addps xmm0, xmm2 ; a1+c1 a2+c2 a3+c3 a4+c4
    addps xmm1, xmm3 ; b1+d1 b2+d2 b3+d3 b4+d4

    haddps xmm0, xmm1 ; a1+c1+a2+c2 a3+c3+a4+c4 b1+d1+b2+d2 b3+d3+b4+d4
    
    mulps xmm0, xmm4 

    movups [rdi + r9 * 4], xmm0

    add rcx, 8
    add r9, 4 
    cmp rcx, rax
	
    jle .vector 
  
  .rest:
    cmp rcx, rdx
    jge .end

    ; | a1 | a2 |
    ; | c1 | c2 |
    
    movss xmm0, [rsi + rcx * 4] ; data[rcx] ; a1
    movss xmm1, [rsi + rcx * 4 + 4] ; data[rcx + 4] ; a2

    mov r8, rdx
    add r8, rcx
    
    movss xmm2, [rsi + r8 * 4] ; data[rcx + n] ; c1
    movss xmm3, [rsi + r8 * 4 + 4] ; data[rcx + n + 1] ; c2

    addss xmm0, xmm1 ; a1+a2
    addss xmm2, xmm3 ; c1+c2
    addss xmm0, xmm2 ; a1+a2+c1+c2
    
    mulss xmm0, xmm4 ; (a1+a2+c1+c2) / 4 

    movss [rdi + r9 * 4], xmm0

    add rcx, 2
    add r9, 1
    jmp .rest

  .end:
  xor rax, rax
  ret