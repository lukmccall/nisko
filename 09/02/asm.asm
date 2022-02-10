section .text

global gradientSSE

gradientSSE:
; rdi   grad
; rsi   data
; rdx   n
; rcx   scale
  shufps xmm0, xmm0, 0h
  movaps xmm3, xmm0

  xor rax, rax
  mov rax, rdx
  sub rax, 2
  and rax, -4
  mov rcx, 1 

  cmp rax, 0
  je .rest

  .vector:
    movups xmm0, [rsi + rcx * 4 + 4] ; data[rcx + 1]
    movups xmm1, [rsi + rcx * 4 - 4] ; data[rcx - 1]
     
	  subps xmm0, xmm1
    mulps xmm0, xmm0

    mov r8, rdx
    neg r8
    add r8, rcx

    mov r9, rdx
    add r9, rcx

    movups xmm1, [rsi + r8 * 4] ; data[rcx - n]
    movups xmm2, [rsi + r9 * 4] ; data[rcx + n]
    
	  subps xmm1, xmm2
    mulps xmm1, xmm1

    addps xmm0, xmm1
    sqrtps xmm0, xmm0

    mulps xmm0, xmm3

    movups [rdi + rcx * 4], xmm0

    add rcx, 4
    cmp rcx, rax
	
    jl .vector 
  
  .rest:
    cmp rcx, rdx
    jae .end 

    movss xmm0, [rsi + rcx * 4 + 4] ; data[rcx + 1]
    movss xmm1, [rsi + rcx * 4 - 4] ; data[rcx - 1]
     
	  subss xmm0, xmm1
    mulss xmm0, xmm0

    mov r8, rdx
    neg r8
    add r8, rcx

    mov r9, rdx
    add r9, rcx

    movss xmm1, [rsi + r8 * 4] ; data[rcx - n]
    movss xmm2, [rsi + r9 * 4] ; data[rcx + n]
    
	  subss xmm1, xmm2
    mulss xmm1, xmm1

    addss xmm0, xmm1
    sqrtss xmm0, xmm0

    mulss xmm0, xmm3

    movss [rdi + rcx * 4], xmm0
    
    inc rcx
    jmp .rest 


  .end:
  xor rax, rax
  ret