segment .text
 
extern printf     

global podatek
global wypisz

podatek:
  movq    rax, xmm0 ; rax = podatekNaliczony, stawkaPodatku
  shr     rdi, 32 ; obrot

  movq    xmm0, rdi ; xmm0 = obrot
  movd    xmm1, eax ; xmm1 = podatekNaliczony

  subss   xmm0, xmm1 ; xmm0 = obrot - podatekNaliczony

  shr     rax, 32 ; stawkaPodatku
  movd    xmm2, eax ; stawkaPodatku

  mulss   xmm0, xmm2 ; (obrot - podatekNaliczony) * stawkaPodatku
ret       

wypisz:
  ; rdi = *faktura
  ; id, obrot, podatekNaliczony, stawkaPodatku

  push rdi

  movq xmm0, [rdi + 8]
  mov rdi, [rdi]

  call podatek
  
  movss xmm1, xmm0
  cvtss2sd xmm1, xmm1

  pop rdi

  mov esi, [rdi] ; id 
  movss xmm0, [rdi + 4] ; obrot
  cvtss2sd xmm0, xmm0
  lea rdi, [rel format]
  mov rax, 2
  sub rsp, 8
  ; rax - 2
  ; rdi - str;
  ; rsi - id
  ; xmm0 - obrot
  ; xmm1 - podatek
  call printf wrt ..plt
  add rsp, 8 
ret

segment .data
  format: dd "Faktura %d : obrot %f podatek %f", 0xa, 0x0