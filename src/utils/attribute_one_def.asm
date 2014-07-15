
%include "corewar.inc"

section .data

mem_size:	dd MEM_SIZE

section .text

global attribute_one_def

attribute_one_def:

	push	ebp
	mov	ebp, esp

	push	dword 0
	push	edx
	
	; [ebp - 4] place_save

	mov	eax, [ebp + 8]

.L1	cmp	eax, 0
	je	.ENDL1

	cmp	dword [eax + s_champions.load_address], 0
	je	.NEXT1

	mov	edx, [eax + s_champions.load_address]
	mov	dword [ebp - 4], edx

.NEXT1	mov	eax, [eax + s_champions.next]
	jmp	.L1

.ENDL1	mov	eax, [ebp + 8]

.L2	cmp	eax, 0
	je	.ENDL2

	cmp	dword [eax + s_champions.load_address], 0
	jne	.NEXT2

	push	eax
	mov	eax, [ebp - 4]
	add	eax, [ebp + 8]
	mov	edx, 0
	div	dword [mem_size]

	pop	eax
	mov	[eax + s_champions.load_address], edx

	add	esp, 4
	push	edx

.NEXT2	mov	eax, [eax + s_champions.next]
	jmp	.L2

.ENDL2	xor	eax, eax

	pop	edx
	add	esp, 4
	mov	esp, ebp
	pop	ebp
	ret
