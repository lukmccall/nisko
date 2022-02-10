global change          ;( 1)
segment .data          ;( 2)
x  dd 4, 0, 0, 0, 0    ;( 3)
y  dq fun1, fun2, fun3 ;( 4)
segment .text          ;( 5)
change:                ;( 6)
  mov rax, [rdi]       ;( 7)
  mov rax, [rax-8]     ;( 8)
  ; copy typeinfo
  mov [x+12], rax      ;( 9)
  ; a = a - 1
  sub dword[rdi+8], 1  ;(10)
  ; set new vtable
  mov qword[rdi], y    ;(11)
  ret                  ;(12)
  ; call fun2 with (x, p->a)
fun1:                  ;(13)
  mov edx, [rdi+8]     ;(14)
  jmp fun2             ;(15)
  ret                  ;(16)
fun2:                  ;(17)
  ; can be replace by 'mov eax, esi'
  movsx rax, esi       ;(18)
  ; x - a
  sub eax, edx         ;(19)
  ; if x-a == 0 then return x else x-a
  cmovz eax, esi       ;(20)
  ret                  ;(21)
fun3:                  ;(22)
  mov r10, [rdi]       ;(23)
  ; call fun1 -> call fun2 (x, a)
  call [r10]           ;(24)
  ; (x-a)^2
  imul eax, eax        ;(25)
  ret                  ;(26)

; RDI, RSI, RDX, RCX, R8, R9
