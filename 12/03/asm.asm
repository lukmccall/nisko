section .text

global sum

sum:
  ; rdi - *ptr
  ; rsi - size
  ; rax - arg number
%define sum qword [rbp - 8]
%define arg1 qword [rbp - 16]
%define arg2 qword [rbp - 24]

    enter 32, 0

    mov rdx, 0
    cmp rax, 1
    mov rcx, 8
    cmove rdx, rcx
    cmp rax, 2
    mov rcx, 16
    cmove rdx, rcx

    movsd arg1, xmm0
    movsd arg2, xmm1
    pxor xmm2, xmm2
    movsd sum, xmm2 

    mov r8, rdi
.iterate:
    cmp rsi, 0
    je .end

    mov rdi, r8
    mov rdi, [rdi]
    mov rcx, [rdi]
    mov rcx, [rcx + rdx]

    movsd xmm0, arg1
    movsd xmm1, arg2

    call rcx

    movsd xmm1, sum
    addsd xmm0, xmm1
    movsd sum, xmm0

    dec rsi
    add r8, 8
    jmp .iterate
.end:

    
    leave
    ret
