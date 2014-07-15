
%include "corewar.inc"

section .text

global find_max_prog_number

find_max_prog_number:

	push	ebp
	mov	ebp, esp

	push	edx

	mov	edx, 0
	mov	eax, [ebp + 8]

.LOOP	cmp	eax, 0
	je	.END

	cmp	[eax + s_champions.prog_number], edx
	jle	.NEXT

	mov	edx, [eax + s_champions.prog_number]

.NEXT	mov	eax, [eax + s_champions.next]
	jmp	.LOOP

.END	mov	eax, edx
	pop	edx
	mov	esp, ebp
	pop	ebp
	ret
