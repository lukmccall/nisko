section .data
  one dd 1.0

section .text

global oblicz

oblicz:
  enter 0,0
  ; rdi - n
  ; xmm0 - x
  ; rsi - *a
  ; rdx - *w

  xor rcx, rcx
  shufps xmm0, xmm0, 0h
  movss xmm2, [rel one]
  shufps xmm2, xmm2, 0h

.vector:
  cmp rcx, rdi
  je .end_of_vector
  
  movups xmm1, [rsi + rcx * 4]
  addps xmm1, xmm0
  mulps xmm1, xmm0
  addps xmm1, xmm2

  movups [rdx + rcx * 4], xmm1

  add rcx, 4
  jmp .vector
.end_of_vector:
  
  leave
  ret