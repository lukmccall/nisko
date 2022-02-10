segment .text
 
global iloczyn
iloczyn:
  pop r10 ; ret

  push r9
  push r8
  push rcx
  push rdx
  push rsi
  
  
  mov rcx, rdi ; n 
  
  mov rax, 1
  .for:
    mov rdx, [rsp + 8 * rcx - 8]
    imul rdx
  loop .for
  
  sub rsp, 5 * 8

  push r10 ; restore ret address

ret               
