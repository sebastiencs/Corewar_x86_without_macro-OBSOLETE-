
%include "corewar.inc"

section .data

str_malloc_error:	db MALLOC_FAILED

section .text

extern my_putstr
extern malloc

global push_champion

create_champion:

	push	ebp
	mov	ebp, esp

	push	edx

	push	dword SIZE_S_CHAMPIONS
	call	malloc
	add	esp, 4
	cmp	eax, 0
	je	.FAIL

	mov	edx, [ebp + 8]
	mov	[eax + s_champions.filename], edx

	mov	edx, [ebp + 12]
	mov	[eax + s_champions.prog_number], edx
	mov	[eax + s_champions.color_gui], edx

	mov	edx, [ebp + 16]
	mov	[eax + s_champions.load_address], edx

	mov	dword [eax + s_champions.next], 0

	jmp	.END

.FAIL	push	str_malloc_error
	call	my_putstr
	add	esp, 4

.END	pop	edx
	mov	esp, ebp
	pop	ebp
	ret

push_champion:

	push	ebp
	mov	ebp, esp

	mov	eax, [ebp + 8]
	mov	eax, [eax + s_corewar.champions]
	push	eax

	cmp	eax, 0
	je	.CREATE

.EXIST	mov	eax, [ebp - 4]
	cmp	dword [eax + s_champions.next], 0
	je	.ENDL
	mov	eax, [eax + s_champions.next]
	mov	dword [ebp - 4], eax
	jmp	.EXIST

.ENDL	push	[ebp + 20]
	push	[ebp + 16]
	push	[ebp + 12]
	call	create_champion
	add	esp, 12
	cmp	eax, 0
	je	.FAIL

	mov	ebp + 4, eax

.CREATE	nop

.FAIL	nop