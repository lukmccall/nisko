segment .data

segment .text
global iloczyn_skalarny
iloczyn_skalarny:
enter 0, 0

%define n dword [ebp + 8]
%define x [ebp + 12]
%define y [ebp + 16]
  push ebx

  mov eax, n ;  counter
  mov ebx, 0 ; offset

  fldz

  .iterate:
    dec eax

    cmp eax, 0
    jl  .end

    mov ecx, x
    add ecx, ebx
    fld tword[ecx] 

    mov ecx, y
    add ecx, ebx
    fld tword[ecx]
    ; x y w 
    fmulp st1 ; xy w
    faddp st1 ; xy+w 
    
    add ebx, 12 

    jmp .iterate
  .end:
    pop ebx
    leave
ret