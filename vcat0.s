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
