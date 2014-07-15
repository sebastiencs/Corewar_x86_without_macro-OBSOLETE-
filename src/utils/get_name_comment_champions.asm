
%include "corewar.inc"

section .data

str1:	db 'error: read', 10, 0
str2:	db 'error: lseek', 10, 0
str3:	db 'error: open', 10, 0

section .text

extern open
extern get_magic
extern lseek
extern get_name
extern get_size
extern get_comment
extern my_putstr

global get_name_comment_champions

get_name_comment_champions:

	push	ebp
	mov	ebp, esp

	push	ebx
	push	ecx
	push	edx

	; mov	eax, [ebp + 8]
	; push	dword [eax + s_champions.filename]
	; call	my_putstr
	; add	esp, 4

	mov	eax, [ebp + 8]
	mov	ebx, [eax + s_champions.filename]
	mov	ecx, O_RDONLY
	mov	edx, 0
	mov	eax, 5			; open
	nop
	int	80h
	cmp	eax, 0
	jle	.FAILO

	mov	edx, [ebp + 12]
	mov	[edx], eax
	mov	edx, [edx]

	; mov	edx, [ebp + 12]
	; mov	edx, [edx]
	; lea	edx, [ebp + 12]
	; mov	[edx], eax

	push	dword edx
	push	dword [ebp + 8]
	call	get_magic
	add	esp, 8
	cmp	eax, -1
	je	.FAIL

	mov	ebx, [ebp + 12]
	mov	ebx, [ebx]
	mov	ecx, 4
	mov	edx, SEEK_SET
	mov	eax, 19			; lseek
	int	80h
	cmp	eax, -1
	je	.FAILLS

	mov	edx, [ebp + 12]
	push	dword [edx]
;	push	dword [ebp + 12]
	push	dword [ebp + 8]
	call	get_name
	add	esp, 8
	cmp	eax, -1
	je	.FAIL

	mov	ebx, [ebp + 12]
	mov	ebx, [ebx]
	mov	ecx, (4 + (PROG_NAME_LENGTH + 4))	; sizeof(int) + (PROG_NAME_LENGTH + 4)
	mov	edx, SEEK_SET
	mov	eax, 19			; lseek
	int	80h
	cmp	eax, -1
	je	.FAILLS

	mov	edx, [ebp + 12]
	push	dword [edx]
;	push	dword [ebp + 12]
	push	dword [ebp + 8]
	call	get_size
	add	esp, 8
	cmp	eax, -1
	je	.FAIL

	mov	ebx, [ebp + 12]
	mov	ebx, [ebx]
	mov	ecx, (8 + (PROG_NAME_LENGTH + 4))	; (sizeof(int) * 2) + (PROG_NAME_LENGTH + 4)
	mov	edx, SEEK_SET
	mov	eax, 19			; lseek
.TEST	int	80h
	cmp	eax, -1
	je	.FAILLS

	mov	edx, [ebp + 12]
	push	dword [edx]
;	push	dword [ebp + 12]
	push	dword [ebp + 8]
	call	get_comment
	add	esp, 8
	cmp	eax, -1
	je	.FAIL


	mov	ebx, [ebp + 12]
	mov	ebx, [ebx]
	mov	ecx, 2192				; sizeof(struct header_s)
	mov	edx, SEEK_SET
	mov	eax, 19			; lseek
	int	80h
	cmp	eax, -1
	je	.FAILLS

	xor	eax, eax
	jmp	.END

.FAILLS	push	str2
	call	my_putstr
	add	esp, 4
	mov	eax, -1
	jmp	.END

.FAILO	push	str3
	call	my_putstr
	add	esp, 4
	mov	eax, -1
	jmp	.END

.FAIL	mov	eax, -1

.END	pop	edx
	pop	ecx
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret
