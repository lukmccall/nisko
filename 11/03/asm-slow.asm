section .text

global multiply

multiply:
    %define A [ebp + 8]
    %define B [ebp + 12]
    %define C [ebp + 16]
    %define Size 256
    
    enter 0, 0

    push esi
    push edi

    xor ecx, ecx
    
    pxor xmm0, xmm0
.zero_i:
    cmp ecx, Size*Size*4
    je .end_of_zero_i

    xor edx, edx
    .zero_j:
        cmp edx, Size*4
        je .end_of_zero_j
        
        mov eax, C
        add eax, ecx
        movups [eax + edx], xmm0

        add edx, 16
        jmp .zero_j
    .end_of_zero_j:


    add ecx, Size*4
    jmp .zero_i
.end_of_zero_i:

; ecx = i
; edx = k
; edi = k'
; esi = j

    xor ecx, ecx
.main_loop:
    cmp ecx, Size*Size*4
    je .ret

    xor edx, edx
    xor edi, edi

    .inner_loop:
        cmp edx, Size*4
        je .ret_of_innner_loop
        
        mov eax, A
        add eax, edx
        
        vbroadcastss xmm0, [eax + ecx]

        xor esi, esi
        .vector:
            cmp esi, Size*4
            je .ret_of_vector

            mov eax, B
            add eax, edi
            movups xmm1, [eax + esi]
            
            mov eax, C
            add eax, ecx
            movups xmm2, [eax + esi]
            
            mulps xmm1, xmm0
            addps xmm1, xmm2

            movups [eax + esi], xmm1

            add esi, 16
            jmp .vector
        .ret_of_vector:

        
        add edx, 4
        add edi, Size*4
        jmp .inner_loop

    .ret_of_innner_loop:


    add ecx, Size*4
    jmp .main_loop
.ret:
    pop edi 
    pop esi

    leave
    ret