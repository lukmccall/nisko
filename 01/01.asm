; wersja NASM na system 64-bitowy (x86-64)
; kompilacja: nasm -felf64 hello.asm -o hello.o
; linkowanie: ld hello.o -o hello
; linkowanie: ld -m elf_x86_64  hello.o -o hello

%define SYS_READ 0
%define SYS_WRITE 1
%define SYS_EXIT 60

%define STDIN 0
%define STDOUT 1

section .text            ; początek sekcji kodu.

global _start            ; linker ld domyślnie rozpoczyna
                         ; wykonywanie programu od etykiety _start
                         ; musi ona być widoczna na zewnątrz (global)
_start:                   ; punkt startu programu
  mov     rax, SYS_WRITE
  mov     rdi, STDOUT
  mov     rsi, prompt
  mov     rdx, prompt.size
  syscall

  mov     rax, SYS_READ
  mov     rdi, STDIN
  mov     rsi, name
  mov     rdx, 0xff
  syscall

  mov     [name.size], al    

  mov     rax, SYS_WRITE          ; numer funkcji systemowej:
                          ; 1=sys_write - zapisz do pliku
  mov     rdi, STDOUT          ; numer pliku, do którego piszemy.
                          ; 1 = standardowe wyjście = ekran
  mov     rsi, hello      ; RSI = adres tekstu
  mov     rdx, hello.size    ; RDX = długość tekstu
  syscall                 ; wywołujemy funkcję systemową

  mov     rax, SYS_WRITE
  mov     rdi, STDOUT
  mov     rsi, name
  mov     dl, [name.size]
  syscall

  mov     rax, SYS_EXIT         ; numer funkcji systemowej
                          ; (60=sys_exit - wyjdź z programu)
  mov     rdi, 0          ; RDI - kod wyjścia
  syscall                 ; wywołujemy funkcję systemową

section .bss
  name resb 0xff
  name.size resb 1

section .data                   ; początek sekcji danych.
  prompt db "Podaj imie: "
  prompt.size equ $ - prompt  
  hello db "Czesc "   ; nasz napis, który wyświetlimy
  hello.size equ $ - hello   ; długość napisu
