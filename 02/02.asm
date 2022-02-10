%include "asm64_io.inc"

%define SYS_WRITE 1

%define STDOUT 1

segment .data

segment .bss
  buff resb 13
  
;
; dane niezainicjalizowane
;

segment .text
global asm_main
asm_main:
  enter 0,0 
  
  mov   eax, -123456789
  xor   r8b , r8b 
  mov   r8b, 12 ; r8b <- index
  cmp   eax, 0
  jge   convert_number

  mov    r9, 1

  mov    esi, -1
  imul   esi

convert_number: 
  cmp   eax, 0
  je    end
  mov   edi, 10
  xor   edx, edx
  div   edi      ; EAX = (EDX:EAX div EDI),
                 ; EDX = (EDX:EAX mod EDI)
  add   edx, '0'
  mov   [buff + r8], dl 
  dec   r8b

  jmp convert_number
end: 

  cmp   r9, 1
  jne   print
add_minus: 
  mov   rsi, buff
  add   rsi, r8
  mov   byte[rsi], '-'
  dec   r8b

print:

  mov   rsi, buff
  add   rsi, r8

  ; calc size
  mov   rdx,  13
  sub   rdx,  r8

  mov     rax, SYS_WRITE
  mov     rdi, STDOUT

  syscall

  mov rax, 0 ; kod zwracany z funkcji  
  leave
  ret
