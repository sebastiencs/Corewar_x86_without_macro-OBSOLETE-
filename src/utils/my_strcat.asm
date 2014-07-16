
section .text

extern malloc
extern my_strlen

global my_strcat

my_strcat:

	push	ebp
	mov	ebp, esp

	sub	esp, 8
	; [ebp - 4] strlen(s1)
	; [ebp - 8] new_str
	push	ecx
	push	edx

	cmp	dword [ebp + 8], 0
	je	.NULL

	cmp	dword [ebp + 12], 0
	je	.NULL

	push	dword [ebp + 8]
	call	my_strlen
	add	esp, 4
	mov	[ebp - 4], eax

	push	dword [ebp + 12]
	call	my_strlen
	add	esp, 4

	add	eax, dword [ebp - 4]
	inc	eax

	push	eax
	call	malloc
	add	esp, 4
	cmp	eax, 0
	je	.NULL

	mov	edx, eax
	mov	[ebp - 8], eax

	mov	ecx, 0

.L1	mov	eax, [ebp + 8]
	cmp	byte [eax], 0
	je	.ENDL1

	mov	al, byte [eax]
	mov	byte [edx + ecx], al

	inc	ecx
	inc	dword [ebp + 8]

	jmp	.L1

.ENDL1	add	edx, ecx
	mov	ecx, 0

.L2	mov	eax, [ebp + 12]
	cmp	byte [eax], 0
	je	.ENDL2

	mov	al, byte [eax]
	mov	byte [edx + ecx], al

	inc	ecx
	inc	dword [ebp + 12]

	jmp	.L2

.ENDL2	mov	byte [edx + ecx], 0
	mov	eax, [ebp - 8]
	jmp	.END

.NULL	mov	eax, 0

.END	pop	edx
	pop	ecx
	mov	esp, ebp
	pop	ebp
	ret
