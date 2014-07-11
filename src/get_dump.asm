%include "corewar.inc"

section .data

str1:	db '-dump', 0
str2:	db '-d', 0

section .text

extern atoi
extern my_strcmp
extern my_putstr

global get_dump

get_dump:

	push	ebp
	mov	ebp, esp

	push	ecx
	push	edx

	mov	ecx, 1
	xor	edx, edx

.LOOP	mov	eax, [ebp + 8]
	cmp	dword ecx, eax
	jge	.ENDL

	push	str1
	mov	eax, [ebp + 12]
	push	dword [eax + (ecx * 4)]
	call	my_strcmp
	add	esp, 8
	cmp	eax, 0
	jne	.DISAS

.DUMP	push	ecx
	mov	eax, [ebp + 12]
	push	dword [eax + ((ecx + 1) * 4)]
	call	atoi
	add	esp, 4
	pop	ecx

	mov	edx, [ebp + 16]
	mov	dword [edx + s_corewar.nbr_cycle_dump], eax

.DISAS	push	str2
	mov	eax, [ebp + 12]
	push	dword [eax + (ecx * 4)]
	call	my_strcmp
	add	esp, 8
	cmp	eax, 0
	jne	.NEXT

	mov	edx, [ebp + 16]
	mov	dword [edx + s_corewar.is_desassembler], 1

.NEXT	inc	ecx
	jmp	.LOOP


.ENDL	pop	ecx
	pop	edx
	mov	esp, ebp
	pop	ebp
	ret
