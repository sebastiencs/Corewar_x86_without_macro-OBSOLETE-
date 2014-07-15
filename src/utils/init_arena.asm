
section .text

global init_arena

init_arena:

	push	ebp
	mov	ebp, esp

	push	ebx
	push	ecx
	push	edx

	mov	ecx, 0
	mov	eax, [ebp + 8]
	; mov	eax, [eax]
	mov	edx, [ebp + 16]

.LOOP	cmp	ecx, [ebp + 12]
	jge	.END

	lea	ebx, [eax + ecx]
	mov	byte [ebx], dl
	inc	ecx
	jmp	.LOOP

.END	pop	edx
	pop	ecx
	pop	ebx
	xor	eax, eax
	mov	esp, ebp
	pop	ebp
	ret
