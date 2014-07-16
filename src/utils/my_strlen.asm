
section .text

global my_strlen

my_strlen:

	push	ebp
	mov	ebp, esp

	push	ecx

	mov	ecx, 0

	cmp	dword [ebp + 8], 0
	je	.END

	mov	eax, [ebp + 8]

.LOOP	cmp	byte [eax + ecx], 0
	je	.END

	inc	ecx
	jmp	.LOOP

.END	mov	eax, ecx
	pop	ecx
	mov	esp, ebp
	pop	ebp
	ret
