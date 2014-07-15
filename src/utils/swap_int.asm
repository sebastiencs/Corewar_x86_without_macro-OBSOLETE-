
section .text

global swap_int

swap_int:

	push	ebp
	mov	ebp, esp

	sub	esp, 4
	push	edx

	; [ebp - 4] tmp

	mov	eax, [ebp + 8]
	mov	eax, [eax]

	mov	dword [ebp - 4], eax

	mov	eax, [ebp + 12]
	mov	eax, [eax]
	mov	edx, [ebp + 8]
	mov	[edx], eax

	mov	eax, [ebp + 12]
	mov	edx, [ebp - 4]
	mov	[eax], edx

	pop	edx
	mov	esp, ebp
	pop	ebp
	ret