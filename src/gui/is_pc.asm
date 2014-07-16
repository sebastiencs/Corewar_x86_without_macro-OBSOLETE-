
%include "corewar.inc"

section .text

extern get_color_champions

global is_pc

is_pc:

	push	ebp
	mov	ebp, esp

	sub	esp, 8
	; [ebp - 4] cur
	; [ebp - 8] j

	mov	eax, [ebp + 12]
	mov	eax, [eax + s_gui.list_pc]		; eax -> list_pc
	mov	ecx, [ebp + 16]					; ecx -> i
	mov	dword [ebp - 8], 0
	mov	edx, [ebp + 8]
	mov	edx, [edx + s_corewar.nb_champions]	; edx -> nb_champions
	mov	dword [ebp - 4], 0

.LOOP	cmp	dword [ebp - 8], edx
	jge	.END

	cmp	dword [ebp - 4], ((MAX_PC * 2) - 1)
	jge	.END

 	cmp	[eax], ecx
	jne	.NEXT

	push	dword [eax + 1]
	push	dword [ebp + 12]
	call	get_color_champions
	add	esp, 8
	mov	eax, 1
	jmp	.END1

.NEXT	inc	dword [ebp - 8]
	add	eax, 2
	jmp	.NEXT

.END	xor	eax, eax
.END1	mov	esp, ebp
	pop	ebp
	ret
