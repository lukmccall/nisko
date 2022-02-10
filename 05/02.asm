segment .data

segment .text
global prostopadloscian
prostopadloscian:
enter 0, 0

%define a dword [ebp + 8]
%define b dword [ebp + 12]
%define c dword [ebp + 16]
%define obj dword [ebp + 20]
%define pole dword [ebp + 24]
  
  ; P = 2(ab + ac + bc)
  ; V = abc

  fld a
  fld b 
  fmulp st1 
  fld c
  fmulp st1

  mov eax, obj
  fstp dword[eax]

  fld a 
  fld b
  fmulp st1

  fld a
  fld c
  fmulp st1

  faddp st1

  fld b
  fld c
  fmulp st1

  faddp st1
  
  fadd st0

  mov eax, pole
  fstp dword[eax]

  leave
ret