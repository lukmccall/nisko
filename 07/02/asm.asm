segment .text

global wartosc
wartosc:
  enter 0, 0
  mov rcx, rdi
  mulpd xmm0, xmm2
  addpd xmm0, xmm1
  
  movsd xmm3, [rel one]
  
  .for:  
	  mulpd xmm3, xmm0 
  loop .for
  
  movaps xmm0, xmm3
  
  leave
  ret               


segment .data
	one dq 1.0