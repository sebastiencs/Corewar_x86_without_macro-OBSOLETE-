
%include "corewar.inc"

section .text

global get_list_pc

get_list_pc:

	push	ebp
	mov	ebp, esp

	push	ebx
	push	edx

	mov	eax, [ebp + 12]
	mov	eax, [eax + s_gui.list_pc]
	mov	ebx, [ebp + 8]
	mov	ebx, [ebx + s_corewar.champions]

.LOOP	cmp	ebx, 0
	je	.END

	cmp	ecx, ((MAX_PC * 2) - 1)
	jge	.END

	mov	edx, [ebx + s_champions.pc]
	mov	[eax], edx
	mov	edx, [ebx + s_champions.color_gui]
	mov	[eax + 1], edx

	add	eax, 2
	mov	ebx, [ebx + s_champions.next]
	jmp	.LOOP

.END	xor	eax, eax
	mov	esp, ebp
	pop	ebp
	ret
