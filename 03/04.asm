%include "asm64_io.inc"

segment .data
  s1 db "abcdefghijklmnopqrstuvwxyz", 0
  s2 db "zyxwvutsrqponmlkjihgfedcba", 0
  text_to_transform db "123 zoz nz plgz.", 0

segment .bss

segment .text
global asm_main
asm_main:
  enter   0,0 

  mov     r8, 0 ; counter

  .iterate_over_string:
    movzx   rbx, byte[text_to_transform + r8]
    cmp     rbx, 0
    je      .return

    push    s1
    push    rbx
    call    find_leater_in_str
    
    cmp     rax, 0
    jl      .print_latter

    .transform:
      mov     bl, [s2 + rax] 
    
    .print_latter:
      mov     rax,  rbx 
      call    print_char

      inc     r8  
      jmp     .iterate_over_string
  
  .return:
    mov     rax, 0   
    leave
    ret

; stack:
;         str
;         letter
; ret in rax
; -1 if not found
find_leater_in_str:
  push    rbx

  mov     rax,  [rsp + 1 * 8 + 1 * 8] ; letter
  mov     rbx,  [rsp + 2 * 8 + 1 * 8] ; str

  .iterate_over_string: 
    cmp     byte[rbx], 0
    je      .not_found
    cmp     [rbx], al
    jne     .next

    .found:
      sub     rbx, [rsp + 2 * 8 + 1 * 8]
      mov     rax,  rbx
      jmp     .return
    .next:
      inc     rbx
      jmp     .iterate_over_string

  .not_found:
    mov     rax, -1     
    
  .return:
    pop     rbx
    ret     2 * 8
