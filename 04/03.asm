section .text 

global sortuj       

sortuj:
; int sort3(int arr[])
; {
;     // Insert arr[1]
;     if (arr[1] < arr[0])
;        swap(arr[0], arr[1]);
 
;     // Insert arr[2]
;     if (arr[2] < arr[1])
;     {
;        swap(arr[1], arr[2]);
;        if (arr[1] < arr[0])
;           swap(arr[1], arr[0]);
;     }
; }
  enter 0, 0                

  push ebx
  push edi

  %idefine    a    [ebp+8]
  %idefine    b    [ebp+12]
  %idefine    c    [ebp+16]
  
  mov eax, a
  mov ebx, b
  mov ecx, c


  mov edx, [eax]
  mov edi, [ebx]
  
  .red:
  cmp edx, edi
  jge  .set_2

  .set_1:
    xchg eax, ebx

  .set_2:
    mov edx, [ebx]
    mov edi, [ecx]
    
    cmp edx, edi
    jge .return
    xchg ebx, ecx

    mov edx, [eax]
    mov edi, [ebx]
    cmp edx, edi
    jge .return
    xchg eax, ebx

  .return:
    mov eax, [eax]
    mov ebx, [ebx]
    mov ecx, [ecx]

    mov edi, a
    mov [edi], eax

    mov edi, b
    mov [edi], ebx

    mov edi, c
    mov [edi], ecx
    
    pop edi
    pop ebx
    leave                          
    ret