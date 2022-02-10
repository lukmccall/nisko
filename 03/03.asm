%include "asm64_io.inc"

segment .data
  number_str db "-1234567891", 0
  
segment .bss
  buffer              resb 12
  to_str.inner_buffer resb 11
  to_str.inner_buffer.size equ $ - to_str.inner_buffer 

segment .text
global asm_main
asm_main:
  enter   0,0 

  push    number_str
  call    to_number
  
  call    println_int

  push    buffer
  push    rax
  call    to_str

  mov     rax, buffer
  call    println_string

  mov     rax, 0   
  leave
  ret

; stack:
;         adress of buffer
;         number_to_convert
to_str:
  push    rax
  push    r8
  push    r9
  push    r10
  push    rdi
  push    rsi

  mov     rax, [rsp + 1 * 8 + 6 * 8] ; number_to_convert
  mov     r8, [rsp + 2 * 8 + 6 * 8] ; buffer
  
  mov     r9, to_str.inner_buffer.size - 1 ; counter

  cmp     rax, 0
  jge     .do_while_greater_then_0
  mov     r10, 1 ; is signed
  mov     rdi, -1
  imul    rdi

  .do_while_greater_then_0:
    xor     rdx, rdx
    mov     rsi, 10
    div     rsi     ; RAX = (RDX:RAX div RSI),
                    ; RDX = (RDX:RAX mod RSI)
    add     rdx, '0'
    mov     [to_str.inner_buffer + r9], dl
    dec     r9

    cmp     rax,  0
    je      .check_if_singed

    jmp     .do_while_greater_then_0  

  .check_if_singed:
    cmp     r10, 1
    jne     .copy_to_output
    mov     byte[to_str.inner_buffer + r9], '-'
    dec     r9  

  .copy_to_output:
    cmp    r9, to_str.inner_buffer.size - 1
    je     .add_0
    
    mov    dl, [to_str.inner_buffer + r9 + 1]
    mov    [r8], dl
    inc    r9
    inc    r8
    
    jmp   .copy_to_output

  .add_0:
    mov     byte[r8], 0

  .return:
    pop     rsi
    pop     rdi
    pop     r10
    pop     r9
    pop     r8
    pop     rax

    ret     2 * 8 

; stack:
;         adress of string
; rax = return 
to_number:
  push    r9
  push    r10
  push    r11
  push    rcx
  push    rdi

  mov     rax, 0 ; result
  mov     r9, [rsp + 1 * 8 + 5 * 8] ; str
  mov     r10, 0  ; counter
  mov     r11, 0 ; is singed

  .iterate_over_string:
    cmp     byte[r9 + r10], 0
    je      .check_if_singed

    xor     rcx,  rcx
    mov     cl, [r9 + r10]
    cmp     cl, '-'
    jne     .not_singed

    mov     r11, 1
    jmp     .next_step

    .not_singed:
      sub     cl, '0'

      mov     rdi, 10
      mul     rdi     ; rax *= 10

      add     rax,  rcx
    
    .next_step:
      inc     r10
      jmp .iterate_over_string

  .check_if_singed:
    cmp     r11, 1
    jne     .return
    mov     rdi, -1
    imul    rdi

  .return:
    pop     rdi
    pop     rcx
    pop     r11
    pop     r10
    pop     r9

    ret 1 * 8
