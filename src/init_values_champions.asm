
%include "corewar.inc"

section .data

str1:	db MALLOC_FAILED

section .text

extern init_reg
extern malloc
extern my_putstr

global init_values_champions

init_values_champions:

	push	ebp
	mov	ebp, esp

	push	edx

	mov	eax, [ebp + 8]

.LOOP	cmp	eax, 0
	je	.ENDL

.TEST	push	eax
	push	dword (4 * (REG_NUMBER + 1))		; sizeof(int) * ...
	call	malloc
	add	esp, 4
	cmp	eax, 0
	je	.FAILM

	mov	edx, eax
	pop	eax

	mov	[eax + s_champions.reg], edx

	push	dword [eax + s_champions.prog_number]
	push	dword [eax + s_champions.reg]
	call	init_reg
	add	esp, 8

	mov	edx, [eax + s_champions.load_address]
	mov	[eax + s_champions.pc], edx

	mov	dword [eax + s_champions.carry], 0
	mov	dword [eax + s_champions.last_live], 0
	mov	dword [eax + s_champions.cycle_to_wait], 0

	mov	eax, [eax + s_champions.next]
	jmp	.LOOP

.ENDL	xor	eax, eax
	jmp	.END

.FAILM	push	str1
	call	my_putstr
	add	esp, 4
	mov	eax, -1

.END	pop	edx
	mov	esp, ebp
	pop	ebp
	ret
