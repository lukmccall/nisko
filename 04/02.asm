section .text 

global iloczyn       

iloczyn:
  enter 0, 0                

  push esi

  %idefine    n    [ebp+8]
  %idefine    array    [ebp+12]
  
  mov ecx, n
  mov eax, 0

  cmp ecx, 0
  jle .return

  inc eax
  
  .iterate:
    dec ecx
    cmp ecx, 0
    jl  .return
    mov esi, array
    mov esi, [esi + ecx * 4]

.red:
    imul  esi
    jmp .iterate

  .return:
    pop esi
    leave                          
    ret