section .text

global fun
global fun_float

fun:
  enter 0,0

  ; rdi - array
  ; rsi - N

  mov rax, rsi
  and rax, -2
  xor rcx, rcx

  pxor xmm0, xmm0

.vector:
  cmp rcx, rax
  je .end_of_vector
  
  movupd xmm1, [rdi + rcx * 8]
  addpd xmm0, xmm1

  add rcx, 2
  jmp .vector
.end_of_vector:
  
  ; movhlps xmm1, xmm0
  ; addpd xmm0, xmm1

  haddpd xmm0, xmm0
     
.rest:
  cmp rcx, rsi
  je .end_of_rest
  
  movsd xmm1, [rdi + rcx * 8]
  addsd xmm0, xmm1

  add rcx, 1
  jmp .rest
.end_of_rest:

  leave
  ret


fun_float:
  enter 0,0

  ; rdi - array
  ; rsi - N

  mov rax, rsi
  and rax, -4
  xor rcx, rcx

  pxor xmm0, xmm0

.vector:
  cmp rcx, rax
  je .end_of_vector
  
  movups xmm1, [rdi + rcx * 4]
  addps xmm0, xmm1

  add rcx, 4
  jmp .vector
.end_of_vector:
  
  haddps xmm0, xmm0
  haddps xmm0, xmm0
     
.rest:
  cmp rcx, rsi
  je .end_of_rest
  
  movss xmm1, [rdi + rcx * 4]
  addss xmm0, xmm1

  add rcx, 1
  jmp .rest
.end_of_rest:

  ; shufps xmm0,xmm0,0x1b  ;reverse the order of element (0x1B=00 01 10 11)
  ; shufps xmm0,xmm0,0xaa  ;four copies of third element (0xAA=10 10 10 10)

  leave
  ret