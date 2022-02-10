section .text

global obliczSSE

obliczSSE:
    %define wynik [ebp + 8]
    %define a [ebp + 12]
    %define b [ebp + 16]
    %define x dword [ebp + 20]
    %define n dword [ebp + 24]
    
    enter 0,0

    push esi
    push edi

    xor eax, eax
    mov ecx, n  

    mov esi, a
    mov edi, b
    mov edx, wynik

    test ecx, ecx
    je .ret

    vbroadcastss xmm7, x
    movaps xmm6, xmm7
    mulps xmm6, xmm6

.vector:
    movups xmm0, [esi + 4 * eax]
    movups xmm1, [edi + 4 * eax]

    movaps xmm2, xmm0
    pcmpeqd xmm2, xmm1

    movaps xmm3, xmm0
    maxps xmm3, xmm1

    movaps xmm4, xmm0
    minps xmm4, xmm1

    subps xmm3, xmm4
    divps xmm4, xmm3

    mulps xmm4, xmm7
    movaps xmm5, xmm7
    
    pand xmm5, xmm2
    pandn xmm2, xmm4

    por xmm2, xmm5 

    mulps xmm1, xmm6

    addps xmm2, xmm1
    
    movups [edx + 4 * eax], xmm2

    add eax, 4
    cmp eax, ecx
    jb .vector
.ret:
    pop edi
    pop esi
    leave
    ret