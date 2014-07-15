
%include "corewar.inc"

section .data

str1:	db 'error: two programs have the same number', 10, 0

section .text

extern my_putstr
global check_same_prog_number

check_same_prog_number:

	push	ebp
	mov	ebp, esp

	push	edx
	push	ebx

	mov	eax, [ebp + 8]

.L1	cmp	eax, 0
	je	.ENDL1

	mov	edx, [eax + s_champions.next]

.L2	cmp	edx, 0
	je	.ENDL2

	mov	ebx, [edx + s_champions.prog_number]
	cmp	[eax + s_champions.prog_number], ebx
	jne	.NEXT2

	cmp	dword [eax + s_champions.prog_number], 0
	je	.NEXT2

	jmp	.FAIL

.NEXT2	mov	edx, [edx + s_champions.next]
	jmp	.L2

.ENDL2	mov	eax, [eax + s_champions.next]
	jmp	.L1

.ENDL1	xor	eax, eax
	jmp	.END

.FAIL	mov	eax, -1
	push	str1
	call	my_putstr
	add	esp, 4

.END	pop	ebx
	pop	edx
	mov	esp, ebp
	pop	ebp
	ret
