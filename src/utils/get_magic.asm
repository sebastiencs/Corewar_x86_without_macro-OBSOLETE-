
%include "corewar.inc"

section .data

str1:	db 'error: bad magic number with ', 0
str2:	db 10, 0
str3:	db 'error: read', 10, 0

section .text

extern little_to_big_endian
extern my_putstr
extern read

global get_magic

get_magic:

	push	ebp
	mov	ebp, esp

	sub	esp, 4
	; [ebp - 4] buf

	push	ebx
	push	ecx
	push	edx

	mov	eax, 3
	mov	ebx, dword [ebp + 12]
	lea	ecx, [ebp - 4]
	mov	edx, 4		; sizeof(int)
	int	80h
	pop	edx
	pop	ecx
	pop	ebx
	cmp	eax, -1
	je	.FAILR
	; push	dword 4
	; lea	eax, [ebp - 4]
	; push	dword eax
	; push	dword [ebp + 12]
	; call	read
	; add	esp, 12
	; cmp	eax, -1
	; je	.FAILR

	push	dword [ebp - 4]
	call	little_to_big_endian
	add	esp, 4

	cmp	dword eax, COREWAR_EXEC_MAGIC
	jne	.FAIL

	xor	eax, eax
	jmp	.END

.FAILR	push	str3
	call	my_putstr
	add	esp, 4
	mov	eax, -1
	jmp	.END

.FAIL	push	str1
	call	my_putstr
	add	esp, 4

	mov	eax, [ebp + 8]
	mov	eax, [eax + s_champions.filename]
	push	eax
	call	my_putstr
	add	esp, 4

	push	str2
	call	my_putstr
	add	esp, 4

	mov	eax, -1

.END	add	esp, 4
	mov	esp, ebp
	pop	ebp
	ret
