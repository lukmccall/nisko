segment .text

global _Z6rotatehi
_Z6rotatehi:
	mov eax, edi
	mov cl, sil
	rol al, cl
	ret

global _Z6rotateji
_Z6rotateji:
	mov rax, rdi
	mov cl, sil
	rol eax, cl
	ret
