BITS 64                   ;( 1)
section .text             ;( 2)
; int przetworz(int, int);     
global _Z9przetworzii     ;( 3)
; double przetworz(double, double);  
global _Z9przetworzdd     ;( 4)
; double przetworz(const double*, const double*);
global _Z9przetworzPKdS0_ ;( 5)
                          ;( 6)
; NWW(a, b)
_Z9przetworzii:           ;( 7)
  mov eax, edi            ;( 8)
  mov ecx, esi            ;( 9)
.petla:                   ;(10)
  xor rdx, rdx            ;(11)
  idiv ecx                ;(12)
  test edx, edx           ;(13)
  jz .koniec              ;(14)
  mov eax, ecx            ;(15)
  mov ecx, edx            ;(16)
  jmp .petla              ;(17)
.koniec:                  ;(18)
  ; ecx = NWD(x,y)
  mov eax, edi            ;(19)
  idiv ecx                ;(20)
  imul eax, esi           ;(21)
  ; return x/NWD * y
  pop rcx                 ;(22)
  jmp rcx                 ;(23)
                          ;(24)
  ; (x, y)
_Z9przetworzdd:           ;(25)
  enter 16,0              ;(26)
  ; x*x
  mulsd  xmm0, xmm0       ;(27)

  movsd  [rsp], xmm1      ;(28)
  movsd  [rsp+8], xmm0    ;(29)
  movapd xmm0, [rsp]      ;(30)
  
  ; xmm0 = x^x+y, y+something
  haddpd xmm0, xmm1       ;(31)
  leave                   ;(32)
  ; ret x^x+y
  ret                     ;(33)
                          ;(34)
_Z9przetworzPKdS0_:       ;(35)
  movsd xmm0, [rdi]       ;(36)
  movsd xmm1, [rsi]       ;(37)
  ; needed for stack aligment
  push rax                ;(38)
  ; x^x+y
  call _Z9przetworzdd     ;(39)
  pop rax                 ;(40)
  ; movsd xmm3, a
  movsd xmm3, [b-8]       ;(41)
  maxsd xmm0, xmm3        ;(42)
  ret                     ;(43)
                          ;(44)
section .data             ;(45)
  a dq 1.0                ;(46)
  b dq 2.0                ;(47)

; RDI, RSI, RDX, RCX, R8, R9
