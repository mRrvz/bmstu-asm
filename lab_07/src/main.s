	.file	"main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"ASM length: %d\nC length: %d\n"
.LC1:
	.string	"\nGCD: "
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	rax, QWORD PTR stdout[rip]
	mov	esi, 0
	mov	rdi, rax
	call	setbuf@PLT
	movabs	rax, 8247343400852088180
	mov	QWORD PTR -16[rbp], rax
	mov	DWORD PTR -8[rbp], 6778473
	mov	DWORD PTR -4[rbp], 0
	lea	rdx, -16[rbp]
#APP
# 11 "main.c" 1
	.intel_syntax noprefix
	mov ecx, 32000
	mov al, 0
	lea rdi, [rdx]
	repne scasb
	mov eax, 32000
	sub eax, ecx
	dec eax
	mov edx, eax
	
# 0 "" 2
#NO_APP
	mov	DWORD PTR -4[rbp], edx
	lea	rax, -16[rbp]
	mov	rdi, rax
	call	strlen@PLT
	mov	rdx, rax
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, eax
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	printf@PLT
	mov	esi, 10
	mov	edi, 2
	mov	eax, 0
	call	gcdmem@PLT
	mov	esi, eax
	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Debian 9.3.0-10) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
