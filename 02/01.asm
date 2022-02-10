%include "asm64_io.inc"


%define SYS_READ 0
%define STDIN 0

segment .data
  liczba_pierwsza_str db "Pierwsza", 0 
  liczba_zlozona_str db "Zlozona", 0 

segment .bss
  number resb 0xff
;
; dane niezainicjalizowane
;

segment .text
global asm_main
asm_main:
  enter 0,0 

  mov     rax, SYS_READ
  mov     rdi, STDIN
  mov     rsi, number
  mov     rdx, 0xff
  syscall
  
  dec     al
  
  mov     r8b, al
  ; r8b <- size
  xor     rax, rax
  xor     rcx, rcx 
convert_to_number:
  cmp     cl, r8b 
  jae     end_conver_to_number
  
  mov     rbx, number
  add     rbx, rcx

  movzx   rbx, byte[rbx]
  sub     rbx, '0'

  mov     rdi, 10
  mul     rdi ; RDX:RAX = RAX * RDI

  add     rax, rbx

  inc     cl

  jmp convert_to_number

end_conver_to_number:

  cmp       rax, 1 
  je        liczba_pierwsza

  mov     rcx, rax ; copy rax

  mov     rdi, rax
  call    isqrt

  mov     r8, rax ; r8 <- sqrt(input)

  mov     rdi,  rcx ; restore rax to rdi

  mov     rcx, 2
check_if_prime:
  cmp     rcx, r8
  ja     liczba_pierwsza

  mov     rax, rdi
  mov     rsi, rcx
  xor     rdx, rdx
  div     rsi       ; RAX = (RDX:RAX div RSI),
                    ; RDX = (RDX:RAX mod RSI) 
  cmp     rdx, 0
  je      liczba_zlozona
  inc     rcx

  jmp check_if_prime

liczba_zlozona:
  mov rax, liczba_zlozona_str
  call println_string

  jmp koniec_programu

liczba_pierwsza:
  mov rax, liczba_pierwsza_str
  call println_string

koniec_programu:
  mov rax, 0 ; kod zwracany z funkcji  
  leave
  ret

isqrt:
; a = value
; b = 0
; while (a > b) {
;          a = ((a+b)/2)
;          b = (value/a)
; }
; result = min{a,b}

  mov rbx, rdi
  xor rax, rax

isqrt_while:
  cmp rax, rbx
  jnb isqrt_endwhile

  add rbx, rax
  shr rbx, 1

  mov rax, rdi
  xor rdx, rdx
  div rbx

  jmp isqrt_while

isqrt_endwhile:
  mov rax, rbx
  ret
