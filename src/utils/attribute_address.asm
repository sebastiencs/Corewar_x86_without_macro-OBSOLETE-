
%include "corewar.inc"

section .text

extern is_addr_already_define
extern attribute_address_defined

global attribute_address

attribute_address:

	push	ebp
	mov	ebp, esp

	sub	esp, 8
	push	edx
	; [ebp - 4] cur
	; [ebp - 8] place_after

	mov	dword [ebp - 4], 0
	mov	eax, MEM_SIZE
	mov	edx, 0
	div	dword [ebp + 12]
	mov	dword [ebp - 8], eax

.IF	push	dword [ebp + 8]
	call	is_addr_already_define
	add	esp, 4
	cmp	eax, 0
	jne	.ELSE

	mov	eax, [ebp + 8]
	mov	edx, [ebp - 4]

.LOOP	cmp	eax, 0
	je	.END

	mov	[eax + s_champions.load_address], edx
	mov	[eax + s_champions.pc], edx

	add	edx, dword [ebp - 8]

	mov	eax, [eax + s_champions.next]
	jmp	.LOOP

.ELSE	push	dword [ebp - 8]
	push	dword [ebp + 12]
	push	dword [ebp + 8]
	call	attribute_address_defined
	add	esp, 12

.END	xor	eax, eax
	pop	edx
	add	esp, 8
	mov	esp, ebp
	pop	ebp
	ret
