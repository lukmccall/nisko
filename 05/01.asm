segment .data

segment .text
global wartosc
wartosc:
enter 0, 0

%define a qword [ebp + 8]
%define b qword [ebp + 16]
%define c qword [ebp + 24]
%define d qword [ebp + 32]
%define x qword [ebp + 40]

  ; ((((a * x) + b) * x) + c) * x + d

  fld x ; x
  fld a ; a x
  fmul  st1 ; a*x x
  fld b ; b a*x x
  faddp st1 ; a*x+b x
  fmul st1 ; w x 
  fld c ; c w x 
  faddp st1 ; w x
  fmulp st1 ; w
  fld d ; d w
  faddp st1 ; w 

  mov eax, 0
  leave
ret