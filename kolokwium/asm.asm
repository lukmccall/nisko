section .text 

global oblicz       

oblicz:
  %define a dword [ebp + 8]
  %define b dword [ebp + 12]
  %define x tword [ebp + 16]
  %define n dword [ebp + 28]
  
  enter 0, 0               

  mov ecx, n
  
  fild a ; a
  fld b ; b a
  fld x ; x b a 

  .loop:
    cmp ecx, 0 
    jle .ret
    
    ; xn  = (xn-1 / a) + b

    fdiv  st2 ; x/a b a 
    fadd  st1 ; (x/a)+b b a 

    dec ecx
    jmp .loop
  
  .ret:
  fxch st2
  fstp st0
  fstp st0
  leave                          
  ret