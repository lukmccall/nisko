section .text

global minmax

minmax:
    %define n [ebp + 8]
    %define tab [ebp + 12]
    %define max [ebp + 16]
    %define min [ebp + 20]
    
    enter 0,0

    xor eax, eax
    mov edx, tab
    mov ecx, n
    
    and ecx, -8
    
    VMOVDQU  ymm1, [edx]
    vmovaps ymm0, ymm1
    add eax, 8
    add edx, 32

.vector:
    cmp eax, ecx
    je .ret

    VMOVDQU  ymm2, [edx]
 
    vpmaxsd ymm1, ymm2
    vpminsd ymm0, ymm2

    add eax, 8
    add edx, 32
    jmp .vector

.ret:

    vextracti128  xmm2, ymm1, 1
    pmaxsd xmm1, xmm2

    vextracti128  xmm2, ymm0, 1
    pminsd xmm0, xmm2

    mov ecx, n
    and ecx, -4

.vector2:
    cmp eax, ecx
    je .ret2

    lddqu xmm2, [edx]
 
    pmaxsd xmm1, xmm2
    pminsd xmm0, xmm2

    add eax, 4 
    add edx, 16
    jmp .vector2

.ret2:

    vmovhlps xmm2, xmm1
    pmaxsd xmm1, xmm2
    pshufd xmm2, xmm1, 0x55
    pmaxsd xmm1, xmm2

    movhlps xmm2, xmm0
    pminsd xmm0, xmm2
    pshufd xmm2, xmm0, 0x55
    pminsd xmm0, xmm2

    mov eax, max 
    movss [eax], xmm1

    mov eax, min 
    movss [eax], xmm0

.end:
    leave
    ret