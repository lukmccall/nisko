%include "asm64_io.inc"

segment .data

segment .bss


segment .text
global asm_main
asm_main:
  enter   0,0 

  mov     r8, 0 ; r8 - counter
  
read_numbers:
  call    read_int   
  movsx   rax, eax
  
  cmp     rax, 0
  je      read_a     
  
  push    rax
  inc     r8 
  jmp     read_numbers

read_a:
  call    read_int ; rax = A
  movsx   rax, eax

  mov     r9, 0 ; r9 - result
find_less:
  cmp     r8, 0
  je      end

  pop     rbx
  cmp     rbx, rax   
  jl      is_less   ; if rbx < rax  
  jmp     final

  is_less:
    inc     r9
  final:
    dec     r8
    jmp     find_less

end:
  mov     rax, r9
  call    println_int

  mov     rax, 0   
  leave
  ret
