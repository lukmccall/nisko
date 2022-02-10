segment .text

global _Z5zerujPjj
_Z5zerujPjj:
    cld
	mov ecx, esi
	mov eax, 0
	rep stosd
	ret

global _Z6kopiujPjS_j
_Z6kopiujPjS_j:
	cld
	mov ecx, edx
	rep movsd
	ret
