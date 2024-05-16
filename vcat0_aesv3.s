	.file	"vcat0.c"
	.text
	.section	.rodata
.LC0:
	.string	"\n\n[+] Congrats Hacked!\n"
	.text
	.globl	flag1
	.type	flag1, @function
flag1:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$23, %edx
	movl	$.LC0, %esi
	movl	$1, %edi
	call	write
	movl	$0, %edi
	call	exit
	.cfi_endproc
.LFE6:
	.size	flag1, .-flag1
	.section	.rodata
	.align 8
.LC1:
	.string	"\n\nFailed To Generate Random Value\n"
	.text
	.globl	randfailed
	.type	randfailed, @function
randfailed:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$34, %edx
	movl	$.LC1, %esi
	movl	$1, %edi
	call	write
	movl	$0, %edi
	call	exit
	.cfi_endproc
.LFE7:
	.size	randfailed, .-randfailed
	.section	.rodata
	.align 8
.LC2:
	.string	"\n\nReturn Address Failed Integrity Check\n"
	.text
	.globl	craifailed
	.type	craifailed, @function
craifailed:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$40, %edx
	movl	$.LC2, %esi
	movl	$1, %edi
	call	write
	movl	$0, %edi
	call	exit
	.cfi_endproc
.LFE8:
	.size	craifailed, .-craifailed
	.globl	doit
	.type	doit, @function
doit:
.LFB9:
	# xmm4 has return address followed by stack address
	movq (%rsp), %xmm3 
	movq %rsp, %xmm4    
	pslldq $8, %xmm4
	por %xmm3, %xmm4
	# encrypt
	pxor  %xmm5,  %xmm4
	aesenc %xmm6, %xmm4 
	aesenc %xmm7, %xmm4 
	aesenc %xmm8, %xmm4 
	aesenc %xmm9, %xmm4 
	aesenc %xmm10, %xmm4 
	aesenclast %xmm11, %xmm4
	# store the raac
	movq %xmm4, %r9
	shl $47, %r9
	xor %r9, (%rsp)
	# clear r9 to not leak information
	xor %r9, %r9
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	jmp	.L5
.L6:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	leaq	-32(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	write
.L5:
	leaq	-32(%rbp), %rax
	movl	$64, %edx
	movq	%rax, %rsi
	movl	$0, %edi
	call	read
	movl	%eax, -4(%rbp)
	cmpl	$0, -4(%rbp)
	jg	.L6
	nop
	nop
	leave
	movq (%rsp), %r9
	movq %r9, %r10 
	# r10 has old mac
	mov $0xffff800000000000, %r11
	and %r11, %r10
	# r9 has return address
	mov $0x00007ffffffffff, %r11
	and %r11, %r9
	# xmm4 has return address followed by stack address
	movq %r9, %xmm3 
	movq %rsp, %xmm4    
	pslldq $8, %xmm4
	por %xmm3, %xmm4
	# encrypt
	pxor  %xmm5,  %xmm4
	aesenc %xmm6, %xmm4 
	aesenc %xmm7, %xmm4 
	aesenc %xmm8, %xmm4 
	aesenc %xmm9, %xmm4 
	aesenc %xmm10, %xmm4 
	aesenclast %xmm11, %xmm4
	# r11 has newly computed mac
	movq %xmm4, %r11
	shl $47, %r11
	# compare old mac and new mac
	cmp %r10, %r11
	jne craifailed
	# restore return address
	movq %r9, (%rsp)
	# clear r9, r10, r11 to not leak information
	xor %r9, %r9
	xor %r10, %r10
	xor %r11, %r11
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	doit, .-doit
	.globl	main
	.type	main, @function
main:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	# rdrand creates upto 64-bit random values so it needs to be called twice
	rdrand %r9
	rdrand %r10  
	# check if rdrand failed
	jnc randfailed 
	# xmm5 has the secret aes key
	movq %r9, %xmm5
	movq %r10, %xmm6
	# clear r9 and r10 to not leak information
	xor %r9, %r9
	xor %r10, %r10
	pslldq $8, %xmm5
	por %xmm6, %xmm5
	pxor   %xmm4, %xmm4
	# key expand xmm6
	aeskeygenassist $1, %xmm0, %xmm1
	pshufd $0b11111111, %xmm1, %xmm1
	shufps $0b00010000, %xmm0, %xmm4
	pxor   %xmm4, %xmm0
	shufps $0b10001100, %xmm0, %xmm4
	pxor   %xmm4, %xmm0
	pxor   %xmm1, %xmm0
	movaps %xmm0, %xmm6
	# key expand xmm7
	aeskeygenassist $2, %xmm0, %xmm1
	pshufd $0b11111111, %xmm1, %xmm1
	shufps $0b00010000, %xmm0, %xmm4
	pxor   %xmm4, %xmm0
	shufps $0b10001100, %xmm0, %xmm4
	pxor   %xmm4, %xmm0
	pxor   %xmm1, %xmm0
	movaps %xmm0, %xmm7
	# key expand xmm8
	aeskeygenassist $4, %xmm0, %xmm1
	pshufd $0b11111111, %xmm1, %xmm1
	shufps $0b00010000, %xmm0, %xmm4
	pxor   %xmm4, %xmm0
	shufps $0b10001100, %xmm0, %xmm4
	pxor   %xmm4, %xmm0
	pxor   %xmm1, %xmm0
	movaps %xmm0, %xmm8
	# key expand xmm9
	aeskeygenassist $8, %xmm0, %xmm1
	pshufd $0b11111111, %xmm1, %xmm1
	shufps $0b00010000, %xmm0, %xmm4
	pxor   %xmm4, %xmm0
	shufps $0b10001100, %xmm0, %xmm4
	pxor   %xmm4, %xmm0
	pxor   %xmm1, %xmm0
	movaps %xmm0, %xmm9
	# key expand xmm10
	aeskeygenassist $16, %xmm0, %xmm1
	pshufd $0b11111111, %xmm1, %xmm1
	shufps $0b00010000, %xmm0, %xmm4
	pxor   %xmm4, %xmm0
	shufps $0b10001100, %xmm0, %xmm4
	pxor   %xmm4, %xmm0
	pxor   %xmm1, %xmm0
	movaps %xmm0, %xmm10
	# key expand xmm11
	aeskeygenassist $32, %xmm0, %xmm1
	pshufd $0b11111111, %xmm1, %xmm1
	shufps $0b00010000, %xmm0, %xmm4
	pxor   %xmm4, %xmm0
	shufps $0b10001100, %xmm0, %xmm4
	pxor   %xmm4, %xmm0
	pxor   %xmm1, %xmm0
	movaps %xmm0, %xmm11
	movl	$0, %eax
	call	doit
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	main, .-main
	.ident	"GCC: (Debian 12.2.0-14) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
