segment .text

global multiply

multiply:
  %define Size 256
  %define BlockSize 24

  %define A dword[ebp + 8]
  %define B dword[ebp + 12]
  %define C dword[ebp + 16]
  
  %define KK dword[ebp - 4]
  %define EndOfC dword[ebp - 8]
  %define K dword[ebp - 12]
  %define SavedESP dword[ebp - 16]

  %define CurrentCPointerRegister esi
  %define CurrentBPointerRegister eax

  enter   20, 0 

  push    edi
  push    CurrentCPointerRegister
  push    ebx
  mov     SavedESP, esp
  
  mov     KK, 0

  mov     eax, C
  add     eax, Size * Size * 4
  mov     EndOfC, eax

  mov     CurrentBPointerRegister, B

.KKToSize:
  mov     edi, KK
  mov     ecx, Size
  mov     K, edi
  mov     ebx, edi ; ebx = k

  add     edi, BlockSize
  cmp     edi, ecx
  mov     KK, edi
  cmovbe  ecx, edi

  mov     edi, A ; edi = &A[i]
  mov     esp, ecx ; esp = Limit

  mov     CurrentCPointerRegister, C

.ResetJToSizeLoop:
  xor     ecx, ecx ; ecx = j


.JToSize:
  test    ebx, ebx
  je      .LoadMM256Zero
  
.LoadSumAB:
  vmovups ymm2, [CurrentCPointerRegister + ecx]
  vmovups ymm1, [CurrentCPointerRegister + ecx + 32]

.ResetKToLimit:
  lea     edx, [CurrentBPointerRegister + ecx] ; edx = &B[k][j]

.KToSavedESP:
  vbroadcastss    ymm0, [edi + ebx * 4] ; read from A
  vmovaps  ymm5, ymm0
  vmulps  ymm3, ymm0, [edx]
  vmulps  ymm6, ymm5, [edx + 32]

  add     edx, Size * 4
  add     ebx, 1

  vaddps  ymm2, ymm3
  vaddps  ymm1, ymm6

  cmp     esp, ebx
  ja      .KToSavedESP

.SaveSums:
  vmovups  [CurrentCPointerRegister + ecx], ymm2 ; store part sum to C
  vmovups  [CurrentCPointerRegister + ecx + 32], ymm1

  add     ecx, 16 * 4
  mov     ebx, K ; ebx = K
  cmp     ecx, Size * 4

  jne     .JToSize

  add     CurrentCPointerRegister, Size * 4
  add     edi, Size * 4

  cmp     EndOfC, CurrentCPointerRegister
  jne     .ResetJToSizeLoop
  
  add     CurrentBPointerRegister, Size * 4 * BlockSize
  cmp     KK, (Size / BlockSize) * BlockSize + BlockSize  ; 264
  jne     .KKToSize

  mov     esp, SavedESP
  pop     ebx
  pop     CurrentCPointerRegister
  pop     edi
  
  leave
  ret

.LoadMM256Zero:
  vxorps ymm1, ymm1
  vxorps ymm2, ymm2

  jmp     .ResetKToLimit