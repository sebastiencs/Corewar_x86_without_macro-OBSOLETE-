
section .data

str1:	db 'error: two champions are in the same address', 10, 0

section .text

extern my_putstr

global check_place_arena

check_place_arena:

	push	ebp
	mov	ebp, esp

	push	edx

	mov	eax, [ebp + 8]
	mov	edx, [ebp + 16]
	mov	edx, [edx]

	mov	al, byte [eax + edx]
	cmp	al, 0
	jne	.FAIL

	mov	eax, [ebp + 8]
	lea	eax, [eax + edx]
	mov	edx, [ebp + 12]
	mov	[eax], dl

	mov	eax, [ebp + 16]
	inc	dword [eax]

	xor	eax, eax
	jmp	.END

.FAIL	push	str1
	call	my_putstr
	add	esp, 4
	mov	eax, -1

.END	pop	edx
	mov	esp, ebp
	pop	ebp
	ret
