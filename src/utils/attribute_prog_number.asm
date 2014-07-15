
%include "corewar.inc"

section .text

extern check_same_prog_number
extern check_big_prog_number
extern attribute_i_to_someone

global attribute_prog_number

attribute_prog_number:

	push	ebp
	mov	ebp, esp

	push	ecx
	push	edx

	mov	ecx, 1

	push	dword [ebp + 8]
	call	check_same_prog_number
	add	esp, 4
	cmp	eax, -1
	je	.FAIL

	push	dword [ebp + 12]
	push	dword [ebp + 8]
	call	check_big_prog_number
	add	esp, 8
	cmp	eax, -1
	je	.FAIL

.L1	cmp	dword ecx, [ebp + 12]
	jg	.ENDL1

	push	dword ecx
	push	dword [ebp + 8]
	call	attribute_i_to_someone
	add	esp, 8

	inc	ecx
	jmp	.L1

.ENDL1	mov	eax, [ebp + 8]

.L2	cmp	eax, 0
	je	.ENDL2

	mov	edx, [eax + s_champions.prog_number]
	mov	[eax + s_champions.color_gui], edx

	mov	eax, [eax + s_champions.next]
	jmp	.L2

.ENDL2	xor	eax, eax
	jmp	.END

.FAIL	mov	eax, -1

.END	pop	edx
	pop	ecx
	mov	esp, ebp
	pop	ebp
	ret
