section .data
  top_offset: dq  0
  type_info:  dq  0
  f_pointer:  dq  oblicz

section .text

global zmien

zmien:
  ; rdi - *a
    enter 0,0

    mov rax, [rdi]

    mov rax, [rax]
    mov rax, [rax - 8]
    mov [rel type_info], rax

    lea rax, [rel f_pointer]
    mov qword [rdi], rax

    leave
    ret

oblicz:
  ; rsi - n

    enter 0, 0
    mov rax, rsi
    imul rax, 3

    leave
    ret
