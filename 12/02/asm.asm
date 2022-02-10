section .text

global new_oblicz

new_oblicz:
  ; rdi - *ptr
    enter 0, 0

    mov rax, [rdi]
    mov rax, [rax+16]
    mov rax, [rax]
    call rax

    dec rax
    
    leave
    ret
