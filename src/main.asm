
%include "corewar.inc"

section .data

t_corewar:
istruc s_corewar
    at s_corewar.arena,			dd	0
    at s_corewar.info_arena,		dd	0
    at s_corewar.nb_champions,		dd	0
    at s_corewar.champions,		dd	0
    at s_corewar.last_champions,	dd	0
    at s_corewar.last_live_nb,		dd	0
    at s_corewar.last_live_name,	dd	0
    at s_corewar.prog_number_max,	dd	0
    at s_corewar.nbr_cycle_dump,	dd	0
    at s_corewar.nbr_live_cur,		dd	0
    at s_corewar.is_desassembler,	dd	0
    at s_corewar.cycle_to_dir_cur,	dd	0
iend

nbr: db 'argc = %d argv[1] = %s', 10, 0

section .text

extern get_args
extern load_arena
extern my_gui

extern printa

main:

	push	ebp
	mov	ebp, esp

	push	t_corewar
	push	dword [ebp + 12]
	push	dword [ebp + 8]
	call	get_args
	add	esp, 12
	cmp	eax, -1
	je	.EXIT

	push	t_corewar
	call	load_arena
	add	esp, 4
	cmp	eax, -1
	je	.EXIT

	mov	eax, [ebp + 12]
	mov	eax, [eax]
	push	eax
	push	t_corewar
	call	my_gui
	add	esp, 8
	cmp	eax, -1
	je	.EXIT


	mov	eax, t_corewar
	push	t_corewar
	call	printa
	add	esp, 4

	mov	esp, ebp
	pop	ebp

	mov	eax, 0
	ret

.EXIT	mov	esp, ebp
	pop	ebp
	mov	eax, -1
	ret

	; push	ebp
	; mov	ebp, esp

	; mov	ecx, [ebp + 8]
	; mov	edx, [ebp + 12]

	; push	ecx
	; push	edx

	; push	dword [edx + 4]
	; push	ecx
	; push	nbr
	; call	printf
	; add	esp, 12

	; mov	esp, ebp
	; pop	ebp

	; mov	eax, 0

	; ret
