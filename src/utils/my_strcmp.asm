section .text

global my_strcmp

my_strcmp:

	push	ebp
	mov	ebp, esp

	push	ebx
	push	edx

	mov	ebx, [ebp + 8]
	mov	edx, [ebp + 12]

.LOOP	mov	eax, 0

	mov	al, byte [ebx]
	mov	ah, byte [edx]

	sub	al, ah
	jnz	.END

	cmp	ah, 0
	jz	.END

	inc	dword ebx
	inc	dword edx

	jmp	.LOOP

.END	cbw
	cwde
	pop	edx
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret
