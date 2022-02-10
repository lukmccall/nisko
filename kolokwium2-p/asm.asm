segment .text
 
global transform
transform: 
  ; rdi - double* array
  ; rsi - N 
  ; rdx - double (*func)(double)

  xor r8, r8
  .for: 
    cmp r8, rsi
    jge .end
    
    movsd xmm0, [rdi + r8 * 8]
    call rdx 
    movsd [rdi + r8 * 8], xmm0

        
    inc r8
    jmp .for

  .end:
  ret               

extern _Z4funcd

global transform2
transform2: 
  ; rdi - double* array
  ; rsi - N 

  xor r8, r8
  .for: 
    cmp r8, rsi
    jge .end
    
    movsd xmm0, [rdi + r8 * 8]
    call _Z4funcd 
    movsd [rdi + r8 * 8], xmm0

        
    inc r8
    jmp .for

  .end:
  ret               

