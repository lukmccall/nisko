BITS 32                   ;( 1)
section .text             ;( 2)
global sumuj              ;( 3)
sumuj:                    ;( 4)
        enter 8, 0        ;( 5)
        push ebx          ;( 6)
        mov  ecx, 5       ;( 7)
        lea  ebx, [ebp+8] ;( 8)
        fldz              ;( 9)
        ; st0: 0
petla:  fld  qword [ebx]  ;(10)
        ; st0: [ebx] st1: 0
        fcomi st0, st1    ;(11)
        jbe label0        ;(12)
        fxch st1          ;(13)
label0:                   ;(14)
        add  ebx, 8       ;(15)
        loop petla        ;(16)
        fxch st5          ;(17)
        mov ecx, 4        ;(18)
petla2: faddp             ;(19)
        loop petla2       ;(20)
        fxch st1          ;(21)
        mov ebx, [ebx]    ;(22)
        fstp qword [ebx]  ;(23)
        pop ebx           ;(24)
        leave             ;(25)
        ret               ;(26)

; -1.5, 0
; 2.5, -1.5, 0
; -1.5, 2.5, 0
; -3.5, -1.5, 2.5, 0
; 4.5, -3.5, -1.5, 2.5, 0
; -3.5, 4.5, -1.5, 2.5, 0
; -5.5, -3.5, 4.5, -1.5, 2.5, 0


; 0, -3.5, 4.5, -1.5, 2.5, -5.5
;|          sum           | store