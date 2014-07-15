
%include "corewar.inc"

section .data

str1:	db 'error: read', 10, 0
str2:	db 'error while loading file', 10, 0
str3:	db 'error: size indicate in file different from true size, maybe the file is corrupt: ', 0
str4:	db 10, 0

section .text

extern close
extern my_putstr
extern little_to_big_endian
extern read

global check_size_read
global get_size

check_size_read:

	push	ebp
	mov	ebp, esp

	push	ebx
	mov	eax, 6
	mov	ebx, [ebp + 16]
	call	close
	pop	ebx

	mov	eax, [ebp + 20]
	cmp	dword [ebp + 20], -1
	je	.FAILR

	mov	eax, [ebp + 12]
	cmp	dword [ebp + 12], 0
	je	.FAILL

	mov	eax, [ebp + 12]
	mov	eax, [eax + s_champions.size]
;	mov	ebx, [ebp + 8]
.TEST	cmp	dword [ebp + 8], eax
	jne	.FAILS

	xor	eax, eax
	jmp	.END

.FAILR	push	str1
	call	my_putstr
	add	esp, 4
	mov	eax, -1
	jmp	.END

.FAILL	push	str2
	call	my_putstr
	add	esp, 4
	mov	eax, -1
	jmp	.END

.FAILS	push	str3
	call	my_putstr
	add	esp, 4

	mov	eax, [ebp + 12]
	push	dword [eax + s_champions.filename]
	call	my_putstr
	add	esp, 4

	push	str4
	call	my_putstr
	add	esp, 4

	mov	eax, -1
	jmp	.END

.END	mov	esp, ebp
	pop	ebp
	ret


get_size:

	push	ebp
	mov	ebp, esp

	sub	esp, 4
	; [ebp - 4] buf

	mov	dword [ebp - 4], 0

	push	ebx
	push	ecx
	push	edx

	mov	eax, 3
	mov	ebx, [ebp + 12]
	lea	ecx, [ebp - 4]
	mov	edx, 4
	int	80h

	pop	edx
	pop	ecx
	pop	ebx

	cmp	eax, -1
	je	.FAILR

	push	dword [ebp - 4]
	call	little_to_big_endian
	add	esp, 4

	push	edx
	mov	edx, [ebp + 8]
	mov	[edx + s_champions.size], eax
	pop	edx

	add	esp, 4
	xor	eax, eax
	jmp	.END

.FAILR	push	str1
	call	my_putstr
	add	esp, 4
	mov	eax, -1

.END	mov	esp, ebp
	pop	ebp
	ret
