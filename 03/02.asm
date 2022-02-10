%include "asm64_io.inc"

segment .data
  array dd 10, 2, -1, 21, 11, 37, 3, 4, -20 
  
segment .bss


segment .text
global asm_main
asm_main:
  enter   0,0 

  push    9
  push    array
  call    find_max

  call    println_int

  mov     rax, 0   
  leave
  ret

; stack:
;         n
;         &array
;         ret
find_max:
  push    r8
  push    r9
  push    r10
  push    r11

  mov     r8, [rsp + 2 * 8 + 4 * 8] ; r8 = array->size()
  mov     r9, [rsp + 1 * 8 + 4 * 8] ; r9 = &array
  mov     r10d, 1 << 31 ; r10d = min int
  
  .unitl_r8:
    cmp     r8, 0
    je      .ret     
    
    dec     r8
    cmp     r10d, [r9 + r8 * 4]
    jge     .next  

    .greater:
      mov     r10d, [r9 + r8 * 4]
    
    .next:
      jmp     .unitl_r8

  .ret:   
    movsx   rax, r10d

    pop    r11
    pop    r10
    pop    r9
    pop    r8

    ret     2 * 8
