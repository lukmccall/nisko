	.file	"main.cpp"
	.text
	.section	.rodata
	.type	_ZStL19piecewise_construct, @object
	.size	_ZStL19piecewise_construct, 1
_ZStL19piecewise_construct:
	.zero	1
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.text
	.globl	_Z4funcd
	.type	_Z4funcd, @function
_Z4funcd:
.LFB1522:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movsd	%xmm0, -8(%rbp)
	movsd	-8(%rbp), %xmm0
	mulsd	%xmm0, %xmm0
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1522:
	.size	_Z4funcd, .-_Z4funcd
	.globl	main
	.type	main, @function
main:
.LFB1523:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movsd	.LC0(%rip), %xmm0
	movsd	%xmm0, -96(%rbp)
	movsd	.LC1(%rip), %xmm0
	movsd	%xmm0, -88(%rbp)
	movsd	.LC2(%rip), %xmm0
	movsd	%xmm0, -80(%rbp)
	movsd	.LC3(%rip), %xmm0
	movsd	%xmm0, -72(%rbp)
	movsd	.LC4(%rip), %xmm0
	movsd	%xmm0, -64(%rbp)
	movsd	.LC4(%rip), %xmm0
	movsd	%xmm0, -48(%rbp)
	movsd	.LC3(%rip), %xmm0
	movsd	%xmm0, -40(%rbp)
	movsd	.LC2(%rip), %xmm0
	movsd	%xmm0, -32(%rbp)
	movsd	.LC1(%rip), %xmm0
	movsd	%xmm0, -24(%rbp)
	movsd	.LC0(%rip), %xmm0
	movsd	%xmm0, -16(%rbp)
	movl	$5, -100(%rbp)
	leaq	-96(%rbp), %rax
	leaq	_Z4funcd(%rip), %rdx
	movl	$5, %esi
	movq	%rax, %rdi
	call	transform@PLT
	movl	$0, -108(%rbp)
.L5:
	cmpl	$4, -108(%rbp)
	jg	.L4
	movl	-108(%rbp), %eax
	cltq
	movq	-96(%rbp,%rax,8), %rax
	movq	%rax, %xmm0
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZNSolsEd@PLT
	movq	%rax, %rdx
	movq	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@GOTPCREL(%rip), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	_ZNSolsEPFRSoS_E@PLT
	addl	$1, -108(%rbp)
	jmp	.L5
.L4:
	movq	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@GOTPCREL(%rip), %rax
	movq	%rax, %rsi
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZNSolsEPFRSoS_E@PLT
	leaq	-48(%rbp), %rax
	movl	$5, %esi
	movq	%rax, %rdi
	call	transform2@PLT
	movl	$0, -104(%rbp)
.L7:
	cmpl	$4, -104(%rbp)
	jg	.L6
	movl	-104(%rbp), %eax
	cltq
	movq	-48(%rbp,%rax,8), %rax
	movq	%rax, %xmm0
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZNSolsEd@PLT
	movq	%rax, %rdx
	movq	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@GOTPCREL(%rip), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	_ZNSolsEPFRSoS_E@PLT
	addl	$1, -104(%rbp)
	jmp	.L7
.L6:
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L9
	call	__stack_chk_fail@PLT
.L9:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1523:
	.size	main, .-main
	.type	_Z41__static_initialization_and_destruction_0ii, @function
_Z41__static_initialization_and_destruction_0ii:
.LFB2010:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	cmpl	$1, -4(%rbp)
	jne	.L12
	cmpl	$65535, -8(%rbp)
	jne	.L12
	leaq	_ZStL8__ioinit(%rip), %rdi
	call	_ZNSt8ios_base4InitC1Ev@PLT
	leaq	__dso_handle(%rip), %rdx
	leaq	_ZStL8__ioinit(%rip), %rsi
	movq	_ZNSt8ios_base4InitD1Ev@GOTPCREL(%rip), %rax
	movq	%rax, %rdi
	call	__cxa_atexit@PLT
.L12:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2010:
	.size	_Z41__static_initialization_and_destruction_0ii, .-_Z41__static_initialization_and_destruction_0ii
	.type	_GLOBAL__sub_I__Z4funcd, @function
_GLOBAL__sub_I__Z4funcd:
.LFB2011:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$65535, %esi
	movl	$1, %edi
	call	_Z41__static_initialization_and_destruction_0ii
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2011:
	.size	_GLOBAL__sub_I__Z4funcd, .-_GLOBAL__sub_I__Z4funcd
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I__Z4funcd
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1072693248
	.align 8
.LC1:
	.long	0
	.long	1073741824
	.align 8
.LC2:
	.long	0
	.long	1074266112
	.align 8
.LC3:
	.long	0
	.long	1074790400
	.align 8
.LC4:
	.long	0
	.long	1075052544
	.hidden	__dso_handle
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
