%include "asm64_io.inc"

segment .data

segment .bss

segment .text
global asm_main
asm_main:
    enter 0,0 

    push    r12
    push    r13
    push    r14
    push    r15

    call    read_int
    mov     r8, rax     ; read N

    call    read_int
    mov     r9, rax     ; read a

    call    read_int
    mov     r10, rax    ; read b

    for:
        cmp     r9, r10 ;   a = b
        jg      end_for
    
        ; int NWD(int a, int b)
        ; {
        ;     int pom;
            
        ;     while(b!=0)
        ;     {
        ;         pom = b;
        ;         b = a%b;
        ;         a = pom;	
        ;     }
            
        ;     return a;
        ; }
        mov     r12, r8 ; copy N
        mov     r13, r9   ; copy a

        ndw_loop:
            xor     rdx, rdx
            mov     rax, r13   ; a/N
            div     r12

            cmp     rdx, 0
            je      yes
            no:
                mov     r13, r12
                mov     r12, rdx

                jmp     ndw_loop
            yes:
                cmp     r12, 1
                jne     nwd_is_not_1

                nwd_is_one:
                    mov     rax, r9
                    call    println_int
                nwd_is_not_1:

        inc      r9
        jmp     for
    end_for:

    pop     r15
    pop     r14
    pop     r13
    pop     r12

    mov rax, 0 ; kod zwracany z funkcji
    leave
    ret