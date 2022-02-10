%define SYS_READ 0
%define SYS_WRITE 1
%define SYS_EXIT 60

%define STDIN 0
%define STDOUT 1

section .text            

global _start           

_start:               
  mov     rax, SYS_WRITE
  mov     rdi, STDOUT
  mov     rsi, prompt
  mov     rdx, prompt.size
  syscall

  mov     rax, SYS_READ
  mov     rdi, STDIN
  mov     rsi, a_str
  mov     rdx, 16
  syscall 

  mov     rax, SYS_READ
  mov     rdi, STDIN
  mov     rsi, b_str
  mov     rdx, 16
  syscall

  mov     al, [a_str]
  sub     al, '0'
  mov     [a], al

  mov     al, [b_str]
  sub     al, '0'
  mov     [b], al

  movzx    ax, byte[a]
  movzx    bx, byte[b]
  add      ax, bx
  mov      bx, 10

  xor      dx, dx
  div      bx

  add      ax, '0'
  add      dx, '0'

  mov     [ans + 7], al
  mov     [ans + 8], dl

  mov     rax, SYS_WRITE
  mov     rdi, STDOUT
  mov     rsi, ans
  mov     rdx, ans.size
  syscall 

  mov     rax, SYS_EXIT                   
  mov     rdi, 0          
  syscall                 

section .bss
  a_str resb 16
  b_str resb 16
  a resb 1
  b resb 1

section .data                  
  prompt db "Podaj liczby: ", 0ah
  prompt.size equ $ - prompt  
  ans db "Wynik: XX", 0ah
  ans.size equ $ - ans  
