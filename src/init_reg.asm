
%include "corewar.inc"

section .text

global init_reg

init_reg:

	push	ebp
	mov	ebp, esp

	push	ecx
	push	edx

	mov	ecx, 2
	mov	eax, [ebp + 8]
	mov	edx, [ebp + 12]
	mov	[eax + 4], edx

.LOOP	cmp	ecx, REG_NUMBER
	jg	.ENDL

	mov	dword [eax + (ecx * 4)], 0
	inc	ecx
	jmp	.LOOP

.ENDL	pop	edx
	pop	ecx
	mov	esp, ebp
	pop	ebp
	ret