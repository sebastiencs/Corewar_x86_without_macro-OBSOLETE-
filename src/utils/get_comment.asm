
%include "corewar.inc"

section .data

str1:	db 'error: malloc', 10, 0
str2:	db 'error: read', 10, 0

section .text

extern my_putstr
extern malloc

global get_comment

get_comment:

	push	ebp
	mov	ebp, esp

	sub	esp, 12
	; [ebp - 4]  *name
	; [ebp - 8]  i
	; [ebp - 12] buf

	push	ebx
	push	ecx
	push	edx

	push	dword (COMMENT_LENGTH + 1)
	call	malloc
	add	esp, 4
	cmp	eax, 0
	je	.FAILM

	mov	[ebp - 4], eax

	mov	ecx, 0
	mov	dword [ebp - 8], 0

.LOOP	cmp	dword [ebp - 8], COMMENT_LENGTH
	jge	.ENDL

	push	ebx
	push	ecx
	push	edx
	mov	eax, 3
	mov	ebx, [ebp + 12]
	lea	ecx, [ebp - 12]
	mov	edx, 1
	int	80h
	pop	edx
	pop	ecx
	pop	ebx

	cmp	eax, 0
	jl	.FAILR
	cmp	eax, 0
	je	.ENDL

	cmp	byte [ebp - 12], 0
	je	.NEXT

	mov	eax, [ebp - 4]
	mov	dl, byte [ebp - 12]

	mov	byte [eax + ecx], dl
	inc	ecx

.NEXT	inc	dword [ebp - 8]
	jmp	.LOOP

.ENDL	mov	eax, [ebp - 4]
	mov	byte [eax + ecx], 0

	mov	eax, [ebp + 8]
	mov	edx, [ebp - 4]
	mov	[eax + s_champions.comment], edx

	xor	eax, eax
	jmp	.END

.FAILM	push	str1
	call	my_putstr
	add	esp, 4
	mov	eax, -1
	jmp	.END

.FAILR	push	str2
	call	my_putstr
	add	esp, 4
	mov	eax, -1

.END	pop	edx
	pop	ecx
	pop	ebx
	add	esp, 12
	mov	esp, ebp
	pop	ebp
	ret
