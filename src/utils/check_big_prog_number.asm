
%include "corewar.inc"

section .data

str1:	db 'error: prog_number too big !', 10, 0

section .text

extern my_putstr

global check_big_prog_number

check_big_prog_number:

	push	ebp
	mov	ebp, esp

	push	edx

	mov	eax, [ebp + 8]
	mov	edx, [ebp + 12]

.LOOP	cmp	eax, 0
	je	.ENDL

	cmp	dword [eax + s_champions.prog_number], edx
	jg	.FAIL

	mov	eax, [eax + s_champions.next]
	jmp	.LOOP

.ENDL	xor	eax, eax
	jmp	.END

.FAIL	mov	eax, -1
	push	str1
	call	my_putstr
	add	esp, 4

.END	pop	edx
	mov	esp, ebp
	pop	ebp
	ret
