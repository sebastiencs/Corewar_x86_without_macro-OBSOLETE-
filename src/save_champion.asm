
%include "corewar.inc"

section .data

str1:		db '-n', 0
str2:		db '-a', 0
mem_size:	dd MEM_SIZE

section .text

extern push_champion
extern is_file_dot_cor
extern my_strcmp
extern atoi

global save_champion

save_champion:

	push	ebp
	mov	ebp, esp

	sub	esp, 12
	push	edx
	push	ecx

	; [ebp - 4]  = cur
	; [ebp - 8]  = prog_number
	; [ebp - 12] = load_address

	mov	eax, [ebp + 8]
	mov	dword [ebp - 4], eax

	mov	dword ecx, [ebp + 8]
	sub	ecx, 1

	mov	dword [ebp - 8], 0
	mov	dword [ebp - 12], 0

.LOOP	cmp	ecx, 0
	jle	.ENDL

	mov	eax, [ebp + 12]
	push	dword [eax + (ecx * 4)]
	call	is_file_dot_cor
	add	esp, 4
	cmp	eax, -1
	jne	.ENDL

.PROGN	push	str1
	mov	eax, [ebp + 12]
	push	dword [eax + (ecx * 4)]
	call	my_strcmp
	add	esp, 8
	cmp	eax, 0
	jne	.LOADA

	push	ecx
	mov	eax, [ebp + 12]
	push	dword [eax + ((ecx + 1) * 4)]
	call	atoi
	add	esp, 4
	mov	[ebp - 8], eax
	pop	ecx

.LOADA	push	str2
	mov	eax, [ebp + 12]
	push	dword [eax + (ecx * 4)]
	call	my_strcmp
	add	esp, 8
	cmp	eax, 0
	jne	.NEXT

	push	ecx
	mov	eax, [ebp + 12]
	push	dword [eax + ((ecx + 1) * 4)]
	call	atoi
	add	esp, 4
	pop	ecx

	xor	edx, edx
	div	dword [mem_size]
	mov	dword [ebp - 12], edx

.NEXT	dec	ecx
	jmp	.LOOP

.ENDL	push	dword [ebp - 12]
	push	dword [ebp - 8]
	mov	eax, [ebp + 12]
	mov	edx, [ebp - 4]
	push	dword [eax + (edx * 4)]
	push	dword [ebp + 16]
	call	push_champion
	add	esp, 16
	cmp	eax, -1
	je	.FAIL

	xor	eax, eax
	jmp	.END

.FAIL	mov	eax, -1

.END	pop	ecx
	pop	edx
	add	esp, 12
	mov	esp, ebp
	pop	ebp
	ret
