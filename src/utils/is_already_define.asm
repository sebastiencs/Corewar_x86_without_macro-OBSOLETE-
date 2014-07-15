
%include "corewar.inc"

section .text

global is_addr_already_define

is_addr_already_define:

	push	ebp
	mov	ebp, esp

	push	edx

	mov	edx, 0
	mov	eax, [ebp + 8]

.LOOP	cmp	eax, 0
	je	.ENDL

	cmp	dword [eax + s_champions.load_address], 0
	je	.NEXT

	inc	edx

.NEXT	mov	eax, [eax + s_champions.next]
	jmp	.LOOP

.ENDL	mov	eax, edx

	pop	edx
	mov	esp, ebp
	pop	ebp
	ret
