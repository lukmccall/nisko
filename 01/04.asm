%define SYS_READ 0
%define SYS_WRITE 1
%define SYS_OPEN 2
%define SYS_CLOSE 3
%define SYS_EXIT 60
%define SYS_TIME 201

%define STDIN 0
%define STDOUT 1

section .text            

global _start           

_start:               
  mov     rax, SYS_TIME
  syscall

  xor     rdx, rdx
  mov     edi, 10
  div     edi

  add     dl, '0'
  mov   byte[output + 7], dl

  xor     rdx, rdx
  mov     edi, 6
  div     edi
  
  add     dl, '0'
  mov   byte[output + 6], dl

  xor     rdx, rdx
  mov     edi, 10
  div     edi
  
  add     dl, '0'
  mov   byte[output + 4], dl

  xor     rdx, rdx
  mov     edi, 6
  div     edi
  
  add     dl, '0'
  mov   byte[output + 3], dl

  add     eax, 2 ; GMT + 2
  
  xor     rdx, rdx
  mov     edi, 24
  div     edi

  mov     eax, edx

  xor     rdx, rdx
  mov     edi, 10
  div     edi
  
  add     dl, '0'
  mov   byte[output + 1], dl

  xor     rdx, rdx
  mov     edi, 10
  div     edi
  
  add     dl, '0'
  mov   byte[output + 0], dl

  mov     rax, SYS_WRITE
  mov     rdi, STDOUT
  mov     rsi, output
  mov     rdx, output.size
  syscall 

  mov     rax, SYS_EXIT                   
  mov     rdi, 0          
  syscall                 


section .data                  
  output db "XX:XX:XX", 0ah
  output.size equ $ - output
