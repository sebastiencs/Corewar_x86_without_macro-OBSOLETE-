
%include "corewar.inc"

section .text

extern get_color_champions
extern set_color_with_pc

global get_color

get_color:

	push	ebp
	mov	ebp, esp

	push	edx

	mov	eax, [ebp + 8]
	mov	eax, [eax + s_corewar.info_arena]
	add	eax, dword [ebp + 16]

	mov	edx, 0
	mov	dl, byte [eax]

	push	edx
	push	dword [ebp + 8]
	call	get_color_champions
	add	esp, 8

	push	dword [ebp + 16]
	push	dword [ebp + 12]
	push	dword [ebp + 8]
	call	set_color_with_pc
	add	esp, 12
	cmp	eax, -1
	je	.FAIL

	xor	eax, eax
	jmp	.END

.FAIL	mov	eax, -1

.END	pop	edx
	mov	esp, ebp
	pop	ebp
	ret
