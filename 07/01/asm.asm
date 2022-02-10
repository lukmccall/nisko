segment .text
 
global suma
suma: 
  mov rcx, rdi
  xor rax, rax
  
  cmp rcx, 0 
  je .end

  .for:  
	add rax, [rsi+4*rcx-4]
  loop .for
  
  .end:
  
  ret               

