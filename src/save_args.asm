
%include "corewar.inc"

section .text

extern save_champion
extern is_file_dot_cor

global save_args

save_args:

	push	ebp
	mov	ebp, esp

	push	edx
	push	ecx
	sub	esp, 4

	mov	ecx, 1
	mov	dword [ebp - 4], 0

.LOOP	cmp	dword ecx, [ebp + 8]
	jge	.ENDL

	mov	eax, [ebp + 12]
	push	dword [eax + (ecx * 4)]
	call	is_file_dot_cor
	add	esp, 4
	cmp	eax, 1
	jne	.NOCOR

	inc	dword [ebp - 4]

	push	dword [ebp + 16]
	push	dword [ebp + 12]
	push	ecx
	call	save_champion
	add	esp, 12
	cmp	eax, -1
	je	.FAIL

.NOCOR	inc	ecx
	jmp	.LOOP

.ENDL	mov	dword edx, [ebp - 4]
	mov	eax, [ebp + 16]
	mov	[eax + s_corewar.nb_champions], edx
	xor	eax, eax
	jmp	.END

.FAIL	mov	eax, -1

.END	add	esp, 4
	pop	ecx
	pop	edx
	mov	esp, ebp
	pop	ebp
	ret
