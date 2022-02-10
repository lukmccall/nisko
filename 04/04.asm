section .text 

global minmax       

minmax:
  enter 0, 0                
 
  push esi

  %idefine struct [ebp + 8] 
  %idefine n [ebp + 12]
  %idefine args ebp + 16

  mov eax, [args] ; min
  mov edx, [args] ; max

  mov ecx, n

  .iterate:
    dec ecx
    cmp ecx, 0
    jl .return

    lea esi, [args + ecx * 4]
    mov esi, [esi]

    .check_min:
      cmp eax, esi
      jl .check_max
      mov eax, esi

    .check_max:
      cmp edx, esi
      jg .next
      mov edx, esi

    .next:
      jmp .iterate


  .return:
    mov esi, struct
    mov [esi], eax
    add esi, 4
    mov [esi], edx

    pop esi
    leave                          
    ret