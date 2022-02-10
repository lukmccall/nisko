segment .data

segment .text
global tablicuj
tablicuj:
enter 0, 0

%define a qword [ebp + 8]
%define b qword [ebp + 16]
%define p qword [ebp + 24]
%define q qword [ebp + 32]
%define xmin qword [ebp + 40]
%define xmax qword [ebp + 48]
%define k dword [ebp + 56]
%define result [ebp + 60]

  push ebx

  fild k 
  fld1 
  fsubp st1
  fld xmin
  fld xmax ; xmax xmin k 
  fsubrp st1

  fdivrp st1
  ;st0 - offset
  ;y=a*(sin(P*2*pi*x))^2 + b*(sin(Q*2*pi*x))^2

  fld xmin ; x offset
  
  mov ebx, 0 ; ebx - counter
  .iterate:
    cmp ebx, k
    jge .end

    fldpi ; pi x offset
    fld p
    fadd st0  ; p*2 pi x offset
    fmul st1 ; p*2*pi pi x offset
    fmul st2 ; p*2*pi*x pi x offset
    fsin      ; sin(p*2*pi*x) pi x offset
    fmul st0 ; sin(p*2*pi*x)^2 pi x offset
    fmul a   ; a*sin(p*2*pi*x)^2 pi x offset

    fld q     ; q L pi x offset
    fadd st0  ; q*2 L pi x offset
    fmul st2 ; q*2*pi L pi x offset
    fmul st3 ; q*2*pi*x L pi x offset
    fsin      ; sin(q*2*pi*x) L pi x offset
    fmul st0 ; sin(q*2*pi*x)^2 L pi x offset
    fmul b   ; b*sin(q*2*pi*x)^2 L pi x offset
    faddp st1 ; L+P pi x offset

    mov eax, result
    fstp qword[eax + ebx * 8] ; pi x offset
  .d:
    fstp st0 ; x offset
    fadd st1

    inc ebx
    jmp .iterate

  .end:
  fstp st0
  fstp st0
  pop ebx
  leave
ret