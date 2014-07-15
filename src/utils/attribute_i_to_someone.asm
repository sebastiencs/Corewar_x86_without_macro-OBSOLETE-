
%include "corewar.inc"

section .text

global attribute_i_to_someone

attribute_i_to_someone:

	push	ebp
	mov	ebp, esp

	sub	esp, 4
	push	edx

	; [ebp - 4] is_already_attr

	mov	dword [ebp - 4], 0

.L1	cmp	eax, 0
	je	.ENDL1

	mov	edx, [ebp + 12]
	cmp	[eax + s_champions.prog_number], edx
	jne	.NEXT1

	mov	dword [ebp - 4], 1

.NEXT1	mov	eax, [eax + s_champions.next]
	jmp	.L1

.ENDL1	cmp	dword [ebp - 4], 1
	je	.END

	mov	eax, [ebp + 8]

.L2	cmp	eax, 0
	je	.END

	cmp	dword [eax + s_champions.prog_number], 0
	jne	.NEXT2

	mov	edx, [ebp + 12]
	mov	dword [eax + s_champions.prog_number], edx
	jmp	.END

.NEXT2	mov	eax, [eax + s_champions.next]
	jmp	.L2

.END	pop	edx
	add	esp, 4
	mov	esp, ebp
	pop	ebp
	ret
