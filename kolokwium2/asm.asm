segment .text
 
global sumuj
sumuj: 
  enter 8, 0
  ; xmm0 - x
  ; rdi - n 
  ; rsi - array
  ; rdx - fun
  push r8
  xor r8, r8
  movd xmm1, r8d

  .for: 
    cmp r8, rdi
    jge .end
    
    push r8
    push rdi 
    push rsi 
    push rdx
    
    movss [rbp - 4], xmm1
    movss [rbp - 8], xmm0
  
    xor rdi, rdi   
    mov edi, [rsi + r8 * 4]
    
    call rdx 
    
    movss xmm1, [rbp - 4]
  
    addss xmm1, xmm0
    movss xmm0, [rbp - 8]
    
    pop rdx
    pop rsi     
    pop rdi 
    pop r8

    inc r8
    jmp .for

  .end:
  pop r8
  movaps xmm0, xmm1
  leave
  ret            
