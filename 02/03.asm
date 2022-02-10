%include "asm64_io.inc"

segment .data

segment .bss  
;
; dane niezainicjalizowane
;

segment .text
global asm_main
asm_main:
  enter 0,0 

  call read_int

  mov   r8, rax

; pierwsza = 2;
; while(liczba>1)
; {
;     // sprawdz czy liczba dzieli sie bez reszty
;     while(liczba % pierwsza == 0)
;     {
;         cout << pierwsza << " ";
;         liczba = liczba / pierwsza; // podziel liczbe
;     }
;     pierwsza++; // sprawdz kolejna liczbe
; }

; rdx:rax / rsi
  mov   rsi, 2
while:
  cmp   r8,  1
  jle   end

inner_while:
  mov   rax, r8 ; copy r8
  xor   rdx, rdx
  div   rsi
  cmp   rdx, 0
  jne   next   

  mov   r8, rax

  mov   rax, rsi
  call println_int
  
  jmp inner_while

next: 
  inc   rsi
  jmp   while

  
end: 
  mov   rax, 0 ; kod zwracany z funkcji  
  leave
  ret
