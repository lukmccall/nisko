;KOMPILACJA:  plik źródłowy c_asm.asm
;nasm -o c_asm.obj -felf32 c_asm.asm
;gcc -m32 c_asm.obj -o c_asm
section .text

extern printf         
extern scanf

global main  
main:                  
  enter 0, 0

  push  number
  push  format
  
  call  scanf

  add esp, 2*4

  push  number2
  push  format

  call scanf

  add esp, 2*4

  xor edx, edx
  mov eax, [number]
  mov edi, [number2]
  cdq
  idiv edi

  push  eax
  push  format

  call printf

  add esp, 2*4
  
  mov eax, 0         
  leave
ret                     

section .data
  format db "%d", 0

section .bss
  number resb 4
  number2 resb 4