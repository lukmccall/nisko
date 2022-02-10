%define SYS_READ 0
%define SYS_WRITE 1
%define SYS_OPEN 2
%define SYS_CLOSE 3
%define SYS_EXIT 60

%define STDIN 0
%define STDOUT 1

%define flags.work 01102o
%define flags.access 0666o

section .text            

global _start           

_start:               
  mov     rax, SYS_OPEN
  mov     rdi, name
  mov     rsi, flags.work 
  mov     rdx, flags.access
  syscall

  mov     ebx, eax

  mov     rax, SYS_WRITE
  mov     edi, ebx
  mov     rsi, text
  mov     rdx, text.size
  syscall
  
  
  mov     rax, SYS_CLOSE
  mov     edi, ebx
  syscall

  mov     rax, SYS_EXIT                   
  mov     rdi, 0          
  syscall                 


section .data                  
  name db "03.txt", 0
  name.size equ $ - name  
  text db "Lukasz Kosmaty", 0ah
  text.size equ $ - text

